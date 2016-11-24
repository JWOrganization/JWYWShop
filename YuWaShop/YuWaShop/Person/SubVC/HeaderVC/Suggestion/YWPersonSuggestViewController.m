//
//  YWPersonSuggestViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPersonSuggestViewController.h"

@interface YWPersonSuggestViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet JWTextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation YWPersonSuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self makeUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.textView becomeFirstResponder];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)makeUI{
    self.textView.placeholderColor = [UIColor colorWithHexString:@"#C4C4C9"];
    self.textView.placeholder = @"请输入您的建议(最少5字)";
    
    self.submitBtn.layer.cornerRadius = 5.f;
    self.submitBtn.layer.masksToBounds = YES;
}

- (IBAction)submitBtnAction:(id)sender {
    [self requestSendSuggestion];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self requestSendSuggestion];
        });
    }
    return YES;
}

#pragma mark - Http
- (void)requestSendSuggestion{
    if ([self.textView.text isEqualToString:@""]) {
        [self showHUDWithStr:@"建议不能为空哟~" withSuccess:NO];
        return;
    }else if (self.textView.text.length < 10){
        [self showHUDWithStr:@"字数不够呐" withSuccess:NO];
        return;
    }
    
    //h333333333333传建议
    [self showHUDWithStr:@"感谢您的建议" withSuccess:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    });
}

@end
