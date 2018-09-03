//
//  FooterView.m
//  XLFormDemo
//
//  Created by mango on 2018/8/24.
//  Copyright © 2018年 mango. All rights reserved.
//

#import "FooterView.h"

#define Width [UIScreen mainScreen].bounds.size.width

@interface FooterView ()

@property (nonatomic, strong) UIButton *sendBtn;

@end


@implementation FooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sendBtn.backgroundColor = [UIColor orangeColor];
        self.sendBtn.layer.cornerRadius = 3;
        self.sendBtn.frame = CGRectMake(15 , 50 , Width - 30 , 45 );
        [self setupWithBtn:self.sendBtn withTitle:@"获取数据" withTitleColor:[UIColor whiteColor] withFontSize:15];
        [self addSubview:self.sendBtn];
        
    }
    return self;
}

-(void)setupWithBtn:(UIButton *)btn withTitle:(NSString *)title withTitleColor:(UIColor *)color withFontSize:(CGFloat)fontSize{
    
    [self addSubview:btn];
    
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    
}

-(void)buttonForSendData:(id)target action:(SEL)action{
    
    [self.sendBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
}



@end
