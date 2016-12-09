//
//  YWComfiringViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/22.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWComfiringViewController.h"
#import "YWLoginViewController.h"

@interface YWComfiringViewController ()

@end

@implementation YWComfiringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavi];
}
- (void)makeNavi{
    self.title = @"认证中";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTittle:@"退出登录" withTittleColor:[UIColor whiteColor] withTarget:self action:@selector(outLogion) forControlEvents:UIControlEventTouchUpInside withWidth:66.f];
}

- (void)outLogion{
    [UserSession clearUser];
    YWLoginViewController * vc = [[YWLoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
