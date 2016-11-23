//
//  YWComfiredAgreeViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWComfiredAgreeViewController.h"

@interface YWComfiredAgreeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

@end

@implementation YWComfiredAgreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavi];
    [self makeUI];
    [self requestAgreeData];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.automaticallyAdjustsScrollViewInsets = YES;
}
- (void)makeNavi{
    self.title = @"协议";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTittle:@"同意协议" withTittleColor:[UIColor whiteColor] withTarget:self action:@selector(agreeAction) forControlEvents:UIControlEventTouchUpInside withWidth:60.f];
}

- (void)makeUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.agreeBtn.layer.cornerRadius =  5.f;
    self.agreeBtn.layer.masksToBounds = YES;
}

- (IBAction)agreeBtnAction:(id)sender {
    [self agreeAction];
}

- (void)agreeAction{
    self.agreeBlock();
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Http
- (void)requestAgreeData{
    //h3333333333333333
    [self.textView setContentOffset:CGPointMake(0.f, 0.f)];
}

@end
