//
//  YWPCEveryPayViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPCEveryPayViewController.h"

@interface YWPCEveryPayViewController ()

@end

@implementation YWPCEveryPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavi];
}

- (void)makeNavi{
    self.title = @"人均消费";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTittle:@"保存" withTittleColor:[UIColor whiteColor] withTarget:self action:@selector(saveInfoAction) forControlEvents:UIControlEventTouchUpInside withWidth:30.f];
}

- (void)saveInfoAction{
    
}

@end
