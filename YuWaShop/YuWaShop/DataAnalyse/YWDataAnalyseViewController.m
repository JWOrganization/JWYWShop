//
//  YWDataAnalyseViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/17.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWDataAnalyseViewController.h"

@interface YWDataAnalyseViewController ()

@end

@implementation YWDataAnalyseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"数据分析";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.f];
}



@end
