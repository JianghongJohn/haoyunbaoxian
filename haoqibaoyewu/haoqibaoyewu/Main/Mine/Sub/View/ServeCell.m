//
//  ServeCell.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/15.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "ServeCell.h"

@implementation ServeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makePhoneCall)];
    
    [_numberLabel addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)phoneAction:(UIButton *)sender {
    [self makePhoneCall];
}
-(void)makePhoneCall{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    NSString *telNum = _numberLabel.text;
    NSString *telString = [NSString stringWithFormat:@"tel:%@",telNum];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:telString]]];
    
    [self.contentView addSubview:webView];
    
}

/**
 *  setModel梳理数据
 */
-(void)setModel:(ServeModel *)model{
    if (_model!=model) {
        _model=model;
        
    }
    _thisImageView.image = UIIMAGE(_model.imageName);
    _nameLabel.text = _model.title;
    _numberLabel.text = _model.phoneNum;
    
}

@end
