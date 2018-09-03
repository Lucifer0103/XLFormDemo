//
//  CFormThirdTypeCell.m
//  XLFormDemo
//
//  Created by mango on 2018/8/24.
//  Copyright © 2018年 mango. All rights reserved.
//

#import "CFormThirdTypeCell.h"
#import "NSObject+XLFormAdditions.h"

NSString *const CFormRowDescriptorTypeThirdType = @"CFormRowDescriptorTypeThirdType";

@interface CFormThirdTypeCell ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) UIPickerView * pickerView;

@property (nonatomic, strong) NSMutableDictionary *valueDic;

@end


@implementation CFormThirdTypeCell
{
    UIColor * _beforeChangeColor;
}


#pragma mark - XLFormDescriptorCell
+(void)load{
    
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[CFormThirdTypeCell class] forKey:CFormRowDescriptorTypeThirdType];
    
}

-(void)configure
{
    [super configure];
}


-(void)update
{
    [super update];
    
    
    self.accessoryType = self.rowDescriptor.isDisabled ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.editingAccessoryType = self.accessoryType;
    
    
    self.textLabel.text = self.rowDescriptor.title;
    
    self.detailTextLabel.text = [self valueDisplayText];
    
}


-(void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller
{
    
    
    [self.formViewController.tableView deselectRowAtIndexPath:[controller.form indexPathOfFormRow:self.rowDescriptor] animated:YES];
    
}




#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.rowDescriptor.selectorOptions[component][row] displayText];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.rowDescriptor.rowType isEqualToString:CFormRowDescriptorTypeThirdType]){
        
        
        if (!self.rowDescriptor.value || ![self.rowDescriptor.value isKindOfClass:[NSArray class]]){
            return;
        }
        
        
        self.rowDescriptor.value[component] = self.rowDescriptor.selectorOptions[component][row];
        
        self.detailTextLabel.text = [self valueDisplayText];
        
        
        [self setNeedsLayout];
        
        
    }
}






#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.rowDescriptor.selectorOptions.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.rowDescriptor.selectorOptions[component] count];
}


#pragma mark - Properties

-(UIPickerView *)pickerView
{
    if (_pickerView) return _pickerView;
    _pickerView = [[UIPickerView alloc] init];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    
    
    for (int i = 0; i < self.rowDescriptor.selectorOptions.count; i++) {
        
        NSArray *optionArr = self.rowDescriptor.selectorOptions[i];
        [_pickerView selectRow:[self selectedIndex:optionArr withComponent:i] inComponent:i animated:NO];
    }
    
    return _pickerView;
}


#pragma mark - Helpers


-(NSString *)valueDisplayText
{
    if (!self.rowDescriptor.value){
        return self.rowDescriptor.noValueDisplayText;
    }
    
    if (![self.rowDescriptor.value isKindOfClass:[NSArray class]]) {

        return self.rowDescriptor.displayTextValue;
    }
    
    
    NSArray *value = self.rowDescriptor.value;
    
    NSString *str = @"";
    for (int i = 0; i < value.count; i++) {
        
        str = [str stringByAppendingString:[value[i] displayText]];
    }
    
    return str;
}



-(NSInteger)selectedIndex:(NSArray *)optionArr withComponent:(NSInteger)integer
{
    if (self.rowDescriptor.value && [self.rowDescriptor.value isKindOfClass:[NSArray class]] && ([self.rowDescriptor.value count] > integer)){
        for (id option in optionArr){
            if ([[option valueData] isEqual:[self.rowDescriptor.value valueData][integer]]){
                return [optionArr indexOfObject:option];
            }
        }
    }
    
    return -1;
}


- (UIView *)inputView
{
    if ([self.rowDescriptor.rowType isEqualToString:CFormRowDescriptorTypeThirdType]){
        return self.pickerView;
    }
    return [super inputView];
}

-(BOOL)formDescriptorCellCanBecomeFirstResponder
{
    return [self canBecomeFirstResponder];
}

-(BOOL)formDescriptorCellBecomeFirstResponder
{
    if ([self isFirstResponder]){
        return [self resignFirstResponder];
    }
    return [self becomeFirstResponder];
    
}


- (BOOL)canBecomeFirstResponder
{
    return !self.rowDescriptor.isDisabled;
}

-(BOOL)becomeFirstResponder
{
    if (self.isFirstResponder){
        return [super becomeFirstResponder];
    }
    BOOL result = [super becomeFirstResponder];
    
    
    return result;
    
}
-(BOOL)resignFirstResponder
{
    return [super resignFirstResponder];
}

-(void)highlight
{
    [super highlight];
    _beforeChangeColor = self.detailTextLabel.textColor;
    self.detailTextLabel.textColor = self.tintColor;
}

-(void)unhighlight
{
    [super unhighlight];
    self.detailTextLabel.textColor = _beforeChangeColor;
}


-(NSMutableDictionary *)valueDic{
    if (_valueDic == nil) {
        _valueDic = [NSMutableDictionary dictionary];
    }
    
    return _valueDic;
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
