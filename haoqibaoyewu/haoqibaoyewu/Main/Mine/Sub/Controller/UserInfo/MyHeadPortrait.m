//
//  MyHeadPortrait.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/18.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "MyHeadPortrait.h"

@interface MyHeadPortrait ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    UIImageView *_headImageView;
}
@end

@implementation MyHeadPortrait

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人头像";
    
    [self _creatRightButton];
    [self _creatHeadImageView];
    
}
/**
 *  创建头像图片视图
 */
-(void)_creatHeadImageView{
    if (_headImageView==nil) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,(SCREENHEIGHT-kTopBarHeight)/2-SCREENWIDTH/2+kTopBarHeight, SCREENWIDTH, SCREENWIDTH)];
        [self.view addSubview:_headImageView];
        _headImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage LoadImageFromBundle:@"p0.jpg"]];
    
    
}
/**
 *  导航栏右侧按钮
 */
-(void)_creatRightButton{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:UIIMAGE(@"头像切换") style:UIBarButtonItemStylePlain target:self action:@selector(_rightAction)];
    
    
}
/**
 *  打开头像
 */
-(void)_rightAction{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
    
    [actionSheet showInView:self.view];
    
}
/**
 *  选择图像来源
 *
 *  @param actionSheet ActionSheet
 *  @param buttonIndex 0==拍照，1==相册
 */
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //UIImagePickerControl
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    //设置代理
    picker.delegate = self;
    
    //开启编辑
    picker.allowsEditing = YES;
    
    //相机资源
    UIImagePickerControllerSourceType sourceType;
    
    if (buttonIndex==0) {//拍照
        //判断是否可用
        sourceType = UIImagePickerControllerSourceTypeCamera;
        
        //摄像头是否可用
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear|UIImagePickerControllerCameraDeviceFront];
        if (!isCamera) {
           
            //反馈
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"相机不可用" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
            
            return;
        }
        
    }else if (buttonIndex==1) {//从手机相册选择
        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }else{
        return;
    }
    //调出相册
    picker.sourceType = sourceType;
    
    [self presentViewController:picker animated:YES completion:nil];
    
    
}
#pragma mark - pickerImageControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *editedImg = info[UIImagePickerControllerEditedImage];
    
    _headImageView.image = editedImg;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"头像修改" message:@"确认使用该头像" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.delegate = self;
    [alert show];
}
#pragma mark - alertDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        //拿到图片
        NSString *path_sandox = NSHomeDirectory();
        //设置一个图片的存储路径
        NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/head.png"];
        //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
        [UIImagePNGRepresentation(_headImageView.image) writeToFile:imagePath atomically:YES];
        
        [self uploadImageWithPath:imagePath];
        
    }else {
            [_headImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage LoadImageFromBundle:@"p0.jpg"]];
    }
    
}

-(void)uploadImageWithPath:(NSString *)path{
    
    /**
     *  获取数据
     */
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    
    [session.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept" ];
    //    [manager.requestSerializer setValue:@"application/json; charset=gb2312" forHTTPHeaderField:@"Content-Type" ];
    ;
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:JH_Token];
    /**
     *  添加token
     */
    [session.requestSerializer setValue: token forHTTPHeaderField:@"token" ];
    //
    
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", @"text/plain",nil];
    
    [session POST:@"http://114.55.157.62:8082/bcis/api/m/headImgUpload.json" parameters:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSURL *url=[NSURL fileURLWithPath:path];
        
        [formData appendPartWithFileURL:url name:@"file" fileName:@"image.jpg" mimeType:@"image/jpeg" error:nil];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
//        NSLog(@"%f",uploadProgress.fractionCompleted);
        
        [SVProgressHUD showProgress:uploadProgress.fractionCompleted];
        if (uploadProgress.fractionCompleted==1.0) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        NSNumber *isSuccess = dic[@"success"];
        //回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{
            
          
            //判断是否成功
            if ([isSuccess isEqual:@1]) {
                NSString *data = dic[@"data"];
                _imageBlock(data);
                [SVProgressHUD showSuccessWithStatus:@"上传完成"];
            }else{
                [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
                
                [_headImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage LoadImageFromBundle:@"p0.jpg"]];
            }
        });
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       dispatch_sync(dispatch_get_main_queue(), ^{
           
           [_headImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage LoadImageFromBundle:@"p0.jpg"]];
           
           [SVProgressHUD dismiss];
       });
    }];
    

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
