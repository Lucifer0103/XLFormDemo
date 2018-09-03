//
//  FormViewController.m
//  XLFormDemo
//
//  Created by mango on 2018/8/24.
//  Copyright © 2018年 mango. All rights reserved.
//

#import "FormViewController.h"
#import "XLForm.h"
#import "CFormThirdTypeCell.h"
#import "CFormChooseCell.h"
#import "FooterView.h"


#define Width [UIScreen mainScreen].bounds.size.width

@interface FormViewController ()

@property (nonatomic, strong) NSDictionary *formDic;

@property (nonatomic, strong) FooterView *footerView;

@end

@implementation FormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    self.tableView.rowHeight = 40;
    
    FooterView *footerView = [[FooterView alloc] initWithFrame:CGRectMake(0, 0, Width, 150)];
    [footerView buttonForSendData:self action:@selector(clickSend)];
    self.tableView.tableFooterView = footerView;

    [self initializeForm];

}



- (void)initializeForm{
    
/** 表单(数据) */
    XLFormDescriptor * form = [XLFormDescriptor formDescriptor];
    
    // 表单Section对象
    XLFormSectionDescriptor *section;
    // 表单Row对象
    XLFormRowDescriptor *row;
    // 临时记录Row对象
    XLFormRowDescriptor *tempRow;
    
/** 第一个Section 没有参数的 */
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    // 文字输入
    row = [self setupRowData:@{@"tag" : @"BT", @"type": XLFormRowDescriptorTypeText, @"title" : @"标题"} withXLFormSection:section];
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfig setObject:[UIColor lightGrayColor] forKey:@"textField.textColor"];
    [row.cellConfig setObject:[UIFont systemFontOfSize:14] forKey:@"textField.font"];
    [row.cellConfig setObject:@"请输入文字" forKey:@"textField.placeholder"];



    // 文本输入
    row = [self setupRowData:@{@"tag" : @"WZMS", @"type": XLFormRowDescriptorTypeTextView, @"title" : @"文字描述"} withXLFormSection:section];
    [row.cellConfig setObject:[UIFont systemFontOfSize:14] forKey:@"textView.font"];
    [row.cellConfig setObject:[UIColor lightGrayColor] forKey:@"textView.textColor"];
    
    
    // PickerView选择
    row = [self setupRowData:@{@"tag" : @"LX", @"type": XLFormRowDescriptorTypeSelectorPickerView, @"title" : @"类型"} withXLFormSection:section];
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@"LX1" displayText:@"类型1"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@"LX2" displayText:@"类型2"],
                            ];
    
    // value : 设置初始值 (初始值需要是选择器数据源中的值)
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@"LX2" displayText:@"类型2"];
    tempRow = row;


    // 数值输入
    row = [self setupRowData:@{@"tag" : @"Num", @"type": XLFormRowDescriptorTypeDecimal, @"title" : @"数值"} withXLFormSection:section];
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [row.cellConfig setObject:[UIColor lightGrayColor] forKey:@"textField.textColor"];
    [row.cellConfig setObject:[UIFont systemFontOfSize:14] forKey:@"textField.font"];
    [row.cellConfig setObject:@"请输入数值" forKey:@"textField.placeholder"];
    [row.cellConfig setObject:@(UITextFieldViewModeAlways) forKey:@"textField.rightViewMode"];
    [row.cellConfig setObject:[self inputUnitWithText:@" 美元"] forKey:@"textField.rightView"];

    // 开关
    row = [self setupRowData:@{@"tag" : @"SFXS", @"type": XLFormRowDescriptorTypeBooleanSwitch, @"title" : @"是否显示"} withXLFormSection:section];
    row.value = @1;

    tempRow.hidden = [NSString stringWithFormat:@"$%@==0", @"SFXS"];


/** 第二个Section 没有参数的 */
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];


    // 自定义cell
    row = [self setupRowData:@{@"tag" : @"XZ", @"type": FormRowDescriptorTypeChoose, @"title" : @"选择"} withXLFormSection:section];
    row.value =  @[@{@"value" : @"XZ-1",
                     @"select": @"0",
                     @"name" : @"选项1"}.mutableCopy,

                   @{@"value" : @"XZ-2",
                     @"select": @"0",
                     @"name" : @"选项2"}.mutableCopy,

                   @{@"value" : @"XZ-3",
                     @"select": @"0",
                     @"name" : @"选项3"}.mutableCopy,

                   @{@"value" : @"XZ-4",
                     @"select": @"0",
                     @"name" : @"选项4"}.mutableCopy,

                   @{@"value" : @"XZ-5",
                     @"select": @"0",
                     @"name" : @"选项5"}.mutableCopy,
                   ];


    //PickerView 三级选择 (自定义)
    row = [self setupRowData:@{@"tag" : @"SJXZ", @"type": CFormRowDescriptorTypeThirdType, @"title" : @"三级选择"} withXLFormSection:section];

    row.selectorOptions = @[
                            @[[XLFormOptionsObject formOptionsObjectWithValue:@"XZ1-1" displayText:@"一级1"],
                              [XLFormOptionsObject formOptionsObjectWithValue:@"XZ1-2" displayText:@"一级2"],
                              ],
                            @[[XLFormOptionsObject formOptionsObjectWithValue:@"XZ2-1" displayText:@"二级1"],
                              [XLFormOptionsObject formOptionsObjectWithValue:@"XZ2-2" displayText:@"二级2"],
                              [XLFormOptionsObject formOptionsObjectWithValue:@"XZ2-3" displayText:@"二级3"],
                              ],
                            @[[XLFormOptionsObject formOptionsObjectWithValue:@"XZ3-1" displayText:@"三级1"],
                              [XLFormOptionsObject formOptionsObjectWithValue:@"XZ3-2" displayText:@"三级2"],
                              [XLFormOptionsObject formOptionsObjectWithValue:@"XZ3-3" displayText:@"三级3"],
                              [XLFormOptionsObject formOptionsObjectWithValue:@"XZ3-4" displayText:@"三级4"],
                              ]
                            ];


    row.value = @[
                  [XLFormOptionsObject formOptionsObjectWithValue:@"XZ1-1" displayText:@"一级1"],
                  [XLFormOptionsObject formOptionsObjectWithValue:@"XZ2-2" displayText:@"二级2"],
                  [XLFormOptionsObject formOptionsObjectWithValue:@"XZ3-3" displayText:@"三级3"],
                  ].mutableCopy;


  
    
    self.form = form;
    
}

#pragma mark - 表单属性设置
-(XLFormRowDescriptor *)setupRowData:(NSDictionary *)selectorDic withXLFormSection:(XLFormSectionDescriptor *)section{
    
    // Tag : row的标签, 用于查找区分row
    // Type : row的类型, 框架提供一些, 也支持自定义
    // Title : row的标题
    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:selectorDic[@"tag"] rowType:selectorDic[@"type"] title:selectorDic[@"title"]];
    

    [section addFormRow:row];
    
    // 设置一些属性
    [row.cellConfig setObject:[UIFont systemFontOfSize:14] forKey:@"textLabel.font"];
    [row.cellConfig setObject:[UIColor blackColor] forKey:@"textLabel.textColor"];
    [row.cellConfig setObject:[UIFont systemFontOfSize:14] forKey:@"detailTextLabel.font"];
    [row.cellConfig setObject:[UIColor lightGrayColor] forKey:@"detailTextLabel.textColor"];
    
    
    return row;
}



#pragma mark - XLFormDescriptorDelegate 表单协议
-(void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)rowDescriptor oldValue:(id)oldValue newValue:(id)newValue{

    [super formRowDescriptorValueHasChanged:rowDescriptor oldValue:oldValue newValue:newValue];


    if ([rowDescriptor.tag isEqualToString:@"LX"]) {


        XLFormOptionsObject *object = rowDescriptor.value;

        XLFormRowDescriptor *numDateDescriptor = [self.form formRowWithTag:@"Num"];

        if ([object.formDisplayText isEqualToString:@"类型1"]) {

            [numDateDescriptor.cellConfig setObject:[self inputUnitWithText:@" 英镑"] forKey:@"textField.rightView"];
        }else{

            [numDateDescriptor.cellConfig setObject:[self inputUnitWithText:@" 美元"] forKey:@"textField.rightView"];
        }

        [self updateFormRow:numDateDescriptor];

    }

}



-(UILabel *)inputUnitWithText:(NSString *)text{
    
    UILabel *unitLabel = [[UILabel alloc] init];
    unitLabel.textColor = [UIColor redColor];
    unitLabel.font = [UIFont systemFontOfSize:14];
    unitLabel.textAlignment = 2;
    unitLabel.text = text;
    [unitLabel sizeToFit];
    
    return unitLabel;
}


#pragma mark - TableView协议
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return CGFLOAT_MIN;
    }else{
        return 15;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

#pragma mark - 获取数据
-(void)clickSend{
    
    NSDictionary *dict = [self formValues];
    
    NSLog(@"%@", dict);
    
    NSLog(@"%@", [dict[@"LX"] formValue]);
    
  
}




@end
