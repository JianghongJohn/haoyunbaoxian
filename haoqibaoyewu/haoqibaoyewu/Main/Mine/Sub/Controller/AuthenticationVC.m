//
//  AuthenticationVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/12.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "AuthenticationVC.h"

@interface AuthenticationVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    UITableView *_tableView;
    UIImageView *_frontView;
    UIImageView *_backView;
    NSInteger _imageSelectedIndex;
    BOOL _front;
    BOOL _verso;
}
@end

@implementation AuthenticationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
 
    [self _creatTableView];
}


/**
 *  创建tableView
 */
-(void)_creatTableView{
    
    if (_tableView==nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, SCREENWIDTH, SCREENHEIGHT-kTopBarHeight) style:UITableViewStyleGrouped];
    }
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    /**
     *  创建一个底部按钮
     *
     *  @return 点击推出登陆
     */
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 80)];
    
    UIButton *bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, SCREENWIDTH-40, 30)];
    bottomButton.backgroundColor = [UIColor redColor];
    [bottomButton setTitle:@"提交" forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(_postImage) forControlEvents:UIControlEventTouchUpInside];
    bottomButton.layer.cornerRadius = 5;
    [bottomView addSubview:bottomButton];
    
    _tableView.tableFooterView = bottomView;
}
-(void)_postImage{
    //获取tableViewCell
    UITableViewCell *nameCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *name = [nameCell.contentView viewWithTag:100];
    //获取tableViewCell
    UITableViewCell *IDCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITextField *ID = [IDCell.contentView viewWithTag:101];
    
    
    if (_front&&_verso&&[JH_Util checkUserIdCard:ID.text]&&name.text.length>=2) {
        
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
        NSDictionary *parameters1 =  @{
                                       @"name":name.text,
                                       @"idNumber":ID.text
                                       
                                       };
        //讲字典类型转换成json格式的数据，然后讲这个json字符串作为字典参数的value传到服务器
        NSString *jsonStr = [NSDictionary DataTOjsonString:parameters1];
        NSLog(@"jsonStr:%@",jsonStr);
        NSDictionary *params = @{@"json":(NSString *)jsonStr}; //服务器最终接受到的对象，是一个字典，
        
        session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", @"text/plain",nil];
        
        [session POST:@"http://114.55.157.62:8082/bcis/api/m/updateIdCard.json" parameters:params
         constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            //拿到图片
            NSString *path_sandox = NSHomeDirectory();
            //设置一个图片的存储路径
            NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/front.png"];
            
            NSURL *url=[NSURL fileURLWithPath:imagePath];
            
            [formData appendPartWithFileURL:url name:@"frontIdCard" fileName:@"front.jpg" mimeType:@"image/jpeg" error:nil];
//
            //拿到图片
            NSString *path_sandox2 = NSHomeDirectory();
            //设置一个图片的存储路径
            NSString *imagePath2 = [path_sandox2 stringByAppendingString:@"/Documents/verso.png"];
            
            NSURL *url2=[NSURL fileURLWithPath:imagePath2];
            
            [formData appendPartWithFileURL:url2 name:@"versoIdCard" fileName:@"verso.jpg" mimeType:@"image/jpeg" error:nil];
            
            
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
                    
                    
                    [SVProgressHUD showSuccessWithStatus:@"上传完成"];
                }else{
                    [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
                    
                    
                }
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
            
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *authenticationVC = @"authenticationVC";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:authenticationVC];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:authenticationVC];
    }
    if (indexPath.row==0) {
        cell.textLabel.text = @"真实姓名";
        //添加textfield为取得文字，设置tag值
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, SCREENWIDTH-110, 40)];
        textField.placeholder = @"请输入真实姓名";
        textField.tag = 100;
        [cell.contentView addSubview:textField];
    }else if (indexPath.row==1){
        cell.textLabel.text = @"身份认证";
       //添加textfield为取得文字，设置tag值
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, SCREENWIDTH-110, 40)];
        textField.placeholder = @"请输入身份证号";
        textField.tag = 101;
        [cell.contentView addSubview:textField];
    }else{
        cell.textLabel.text = @"身份证姓名";
        //正面照和反面照
        UILabel *frontIMG = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-50, 0, 70, 20)];
         UILabel *backtIMG = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2+50, 0, 70, 20)];
        frontIMG.text = @"正面照";
        backtIMG.text = @"反面照";
        frontIMG.textAlignment = NSTextAlignmentCenter;
        backtIMG.textAlignment = NSTextAlignmentCenter;
        
        frontIMG.font = SYSFONT12;
        backtIMG.font = SYSFONT12;
        
        _frontView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-50,30,70, 70)];
        _backView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2+50,30, 70, 70)];
        _frontView.image = [UIImage imageNamed:@"添加"];
        _backView.image = [UIImage imageNamed:@"添加"];
        
        [cell.contentView addSubview:frontIMG];
        [cell.contentView addSubview:backtIMG];
        [cell.contentView addSubview:_frontView];
        [cell.contentView addSubview:_backView];
        
        /**
         *  为图片添加手势
         */
        UITapGestureRecognizer *frontTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFrontImage)];
        [_frontView addGestureRecognizer:frontTap];
        
        UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectBackImage)];
        [_backView addGestureRecognizer:backTap];
        
        _frontView.userInteractionEnabled = YES;
        _backView.userInteractionEnabled = YES;
        
        _frontView.contentMode = UIViewContentModeScaleAspectFit;
        _backView.contentMode = UIViewContentModeScaleAspectFit;
        
        
    }
    
    
    return cell;
}
-(void)selectFrontImage{
    _imageSelectedIndex = 0;
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
        [sheet showInView:self.view];
        

}
-(void)selectBackImage{
    _imageSelectedIndex = 1;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
    [sheet showInView:self.view];

}

//图片选择器
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 8_3) __TVOS_PROHIBITED;
{
    UIImagePickerController *imgPC = [[UIImagePickerController alloc] init];
    
    //设置代理
    imgPC.delegate = self;
    
    //允许编辑图片
    imgPC.allowsEditing = YES;
    
    UIImagePickerControllerSourceType sourceType;
    //选择相机 或者 相册
    if (buttonIndex == 0) {//拍照
        
        sourceType = UIImagePickerControllerSourceTypeCamera;
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"摄像头无法使用" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
            
            return;
        }
        
        
    }else if(buttonIndex == 1){ //选择相册
        
        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
    }else{
        
        return;
    }
    
    imgPC.sourceType = sourceType;
    
    [self presentViewController:imgPC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0);{
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;{
    NSLog(@"info== %@",info);
     NSLog(@"%@",NSHomeDirectory());
    //获取修改后的图片
    UIImage *editedImg = info[UIImagePickerControllerEditedImage];
    if (_imageSelectedIndex==0) {
        _frontView.image = editedImg;
        _front = YES;
        //拿到图片
        NSString *path_sandox = NSHomeDirectory();
        //设置一个图片的存储路径
        NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/front.png"];
       
        //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
        [UIImagePNGRepresentation(editedImg) writeToFile:imagePath atomically:YES];
        
    }else{
        _backView.image = editedImg;
        _verso = YES;
        //拿到图片
        NSString *path_sandox = NSHomeDirectory();
        //设置一个图片的存储路径
        NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/verso.png"];
        //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
        [UIImagePNGRepresentation(editedImg) writeToFile:imagePath atomically:YES];

    }

    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark - tableViewDataDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==2) {
        return 120;
    }
    return 50;
}
#pragma mark - 选中事件




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
