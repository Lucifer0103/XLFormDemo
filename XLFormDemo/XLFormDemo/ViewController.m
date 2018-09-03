//
//  ViewController.m
//  XLFormDemo
//
//  Created by mango on 2018/8/24.
//  Copyright © 2018年 mango. All rights reserved.
//

#import "ViewController.h"
#import "FormViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)click:(id)sender {
    
    [self.navigationController pushViewController:[FormViewController new] animated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
