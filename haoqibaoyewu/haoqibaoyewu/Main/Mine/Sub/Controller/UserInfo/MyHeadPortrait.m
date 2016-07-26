//
//  MyHeadPortrait.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/18.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "MyHeadPortrait.h"

@interface MyHeadPortrait ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
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
    _headImageView.image = [UIImage LoadImageFromBundle:@"p0.jpg"];
    
    
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
    //拿到图片
    NSString *path_sandox = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/head.png"];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(editedImg) writeToFile:imagePath atomically:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
