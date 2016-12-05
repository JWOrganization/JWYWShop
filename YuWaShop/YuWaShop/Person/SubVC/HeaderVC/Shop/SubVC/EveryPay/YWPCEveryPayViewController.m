//
//  YWPCEveryPayViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPCEveryPayViewController.h"
#import "YWPersonShopModel.h"

@interface YWPCEveryPayViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITextField *everyPayTextfield;
@property (weak, nonatomic) IBOutlet UILabel *currentPayLabel;
@property (nonatomic,strong)YWPersonShopModel * model;

@end

@implementation YWPCEveryPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavi];
    [self makeUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0.f];
    [self.everyPayTextfield becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.f];
    [self.everyPayTextfield resignFirstResponder];
}

- (void)makeNavi{
    self.title = @"人均消费";
    self.model = [YWPersonShopModel sharePersonShop];
}

- (void)makeUI{
    self.submitBtn.layer.cornerRadius = 5.f;
    self.submitBtn.layer.masksToBounds = YES;
    self.currentPayLabel.text = [NSString stringWithFormat:@"当前人均消费%@元",@"233333"];
}

- (BOOL)saveInfoAction{
    if ([self.everyPayTextfield.text isEqualToString:@""]) {
        [self showHUDWithStr:@"人均消费不能为空哟~" withSuccess:NO];
        return NO;
    }else if (![JWTools isNumberWithStr:self.everyPayTextfield.text]){
        [self showHUDWithStr:@"请输入数字哟~" withSuccess:NO];
        return NO;
    }
    [self requestSendEveryPay];
    [self.everyPayTextfield resignFirstResponder];
    return YES;
}

- (IBAction)submitBtnAction:(id)sender {
    [self saveInfoAction];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [self saveInfoAction];
}

#pragma mark - Http
- (void)requestSendEveryPay{
    //h333333333333上传人均消费
    NSDictionary * pragram = @{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([UserSession instance].uid),@"per_capita":@([self.everyPayTextfield.text floatValue])};
    
    [[HttpObject manager]postDataWithType:YuWaType_Shoper_ShopAdmin_SetPerCapita withPragram:pragram success:^(id responsObj) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code is %@",responsObj);
        [self showHUDWithStr:@"恭喜,保存成功" withSuccess:YES];
        //2333333333修改门户设置信息
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failur:^(id responsObj, NSError *error) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code error is %@",responsObj);
    }]; //h333333333
}

@end
