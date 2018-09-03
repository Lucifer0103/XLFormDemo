//
//  CFormChooseCell.m
//  XLFormDemo
//
//  Created by mango on 2018/8/24.
//  Copyright © 2018年 mango. All rights reserved.
//

#import "CFormChooseCell.h"


#define Scale [UIScreen mainScreen].bounds.size.width/375.0f
#define Width [UIScreen mainScreen].bounds.size.width

NSString *const FormRowDescriptorTypeChoose = @"FormRowDescriptorTypeChoose";


@interface CFormChooseCell ()


@property (nonatomic, strong) NSMutableArray *btnArr;

@end

@implementation CFormChooseCell


+(void)load{
    
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[CFormChooseCell class] forKey:FormRowDescriptorTypeChoose];
}


-(void)configure{
    [super configure];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryNone;
    
    
    self.btnArr = [NSMutableArray array];
    
    CGFloat gap = 15 * Scale;
    CGFloat btnWidth = 50 * Scale;
    
    CGFloat spacing = (Width - gap * 2 - btnWidth * 5) / 4 ? (Width - gap * 2 - btnWidth * 5) / 4 : 0;
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.tag = 200 + i;
        btn.backgroundColor = [UIColor lightGrayColor];
        
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:btn];
        
        btn.frame = CGRectMake(gap + (btnWidth + spacing) * i, 35 * Scale, btnWidth, 20 * Scale);
        
        
        [self.btnArr addObject:btn];
        
    }

}


- (void)update
{
    [super update];
    
    self.textLabel.text = self.rowDescriptor.title;
    
    
    for (int i = 0; i< [self.btnArr count]; i++) {
        
        UIButton *btn = self.btnArr[i];
        
        if (i < [self.rowDescriptor.value count]) {
            
            NSMutableDictionary *dic = [self.rowDescriptor.value objectAtIndex:i];
            [btn setTitle:dic[@"name"] forState:UIControlStateNormal];
            
            
            if ([dic[@"select"] integerValue] == 1) {
                btn.selected = YES;
                btn.backgroundColor = [UIColor cyanColor];
            }else{
                btn.selected = NO;
                btn.backgroundColor = [UIColor lightGrayColor];
            }
        }
        
    }
    
}



-(void)clickBtn:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    [self handleSelectedButton:btn];
    
    
}


-(void)handleSelectedButton:(UIButton *)btn{
    
    NSInteger selectNum = btn.tag - 200;
    
    if (btn.selected) {
        btn.backgroundColor = [UIColor cyanColor];
        
        if (selectNum < [self.rowDescriptor.value count]) {
            
            NSMutableDictionary *dic = [self.rowDescriptor.value objectAtIndex:selectNum];
            dic[@"select"] = @"1";
        }
        
        
    }else{
        btn.backgroundColor = [UIColor lightGrayColor];
        
        if (selectNum < [self.rowDescriptor.value count]) {
            
            NSMutableDictionary *dic = [self.rowDescriptor.value objectAtIndex:selectNum];
            dic[@"select"] = @"0";
        }
    }
    
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect tempFrame = self.textLabel.frame;
    tempFrame.origin.y = 8;
    
    self.textLabel.frame = tempFrame;
}



+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    
    return 70 * Scale;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
