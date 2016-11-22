//
//  YWComfiredViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/22.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWComfiredViewController.h"

@interface YWComfiredViewController ()

@end

@implementation YWComfiredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavi];
}
- (void)makeNavi{
    self.title = @"商务会员签约";
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;
}

@end
