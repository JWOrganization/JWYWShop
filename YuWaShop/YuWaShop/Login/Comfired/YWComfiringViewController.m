//
//  YWComfiringViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/22.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWComfiringViewController.h"

@interface YWComfiringViewController ()

@end

@implementation YWComfiringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavi];
}
- (void)makeNavi{
    self.title = @"认证中";
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
