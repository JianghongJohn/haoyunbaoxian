//
//  TouchImageView.m
//  shangkatong
//
//  Created by 五角星科技 on 16/2/23.
//  Copyright © 2016年 五角星科技. All rights reserved.
//

#import "TouchImageView.h"
#import "WebViewController.h"
#import "UIView+UIViewController.h"
@implementation TouchImageView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (![self.urlString isKindOfClass:[NSNull class]]&&self.urlString!=nil&&![self.urlString isEqualToString:@""]) {
    
        WebViewController *web = [[WebViewController alloc] init];
        web.urlString = _urlString;
        web.webTitle = _webTitle;
        NSLog(@"%@",_webTitle);
        NSLog(@"%@",_urlString);
        web.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:web animated:YES];
    }

}
-(void)setUrlString:(NSString *)urlString{
    _urlString = urlString;
}

@end
