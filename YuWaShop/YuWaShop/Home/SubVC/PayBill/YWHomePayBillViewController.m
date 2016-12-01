//
//  YWHomePayBillViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/30.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWHomePayBillViewController.h"

@interface YWHomePayBillViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cutShowBtn;
@property (weak, nonatomic) IBOutlet UILabel *cutLabel;
@property (weak, nonatomic) IBOutlet UITextField *costTextField;
@property (weak, nonatomic) IBOutlet UITextField *cutTextField;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImageView;

@property (nonatomic,assign)BOOL isCut;
@property (nonatomic,assign)CGFloat cut;
@property (nonatomic,assign)CGFloat cutNumber;
@property (nonatomic,assign)CGFloat costNumber;
@property (nonatomic,assign)CGFloat payNumber;

@end

@implementation YWHomePayBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"买单收银";
    [self dataSet];
    [self makeUI];
}
- (void)dataSet{
    self.cut = [UserSession instance].cut + 5;
}
- (void)makeUI{
    NSInteger cutInter = [UserSession instance].cut;
    if (cutInter%10 == 5) {
        self.cutLabel.text = cutInter== 95?@"全付":[NSString stringWithFormat:@"%zi折",((cutInter+5)/10)];
    }else{
        self.cutLabel.text = [NSString stringWithFormat:@"%zi折",(cutInter+5)];
    }
    
    self.cutShowBtn.layer.cornerRadius = 3.f;
    self.cutShowBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 5.f;
    self.submitBtn.layer.masksToBounds = YES;
}

- (IBAction)cutUseSwichAction:(UISwitch *)sender {
    self.isCut = sender.isOn;
    [self payMoneySet];
}
- (IBAction)submitBtnAction:(id)sender {
    [self payMoneySet];
    [self requestCreateQRCode];
}

- (void)payMoneySet{
    if (self.costNumber >= 999999999) {
        [self showHUDWithStr:@"支付金额太大,请多次支付哟" withSuccess:NO];
        return;
    }
    
    if (self.costNumber<=0.f) {
        self.costTextField.text = @"";
        [self showHUDWithStr:@"付款不能小于0元哟~" withSuccess:NO];
        return;
    }
    if (self.cutNumber<=0.f){
        self.cutTextField.text = @"";
    }
    
    if (self.costNumber < self.cutNumber){
        self.cutTextField.text = self.costTextField.text;
        self.cutNumber = self.costNumber;
    }
    
    self.payNumber = (self.costNumber - self.cutNumber)*(self.isCut?self.cut:100) /100;
    self.payLabel.text = [NSString stringWithFormat:@"￥%.2f",self.payNumber];
    self.QRCodeImageView.image = nil;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (![string isEqualToString:@""]&&(fmodf([textField.text floatValue]*100, 1)!=0)) {
            textField.text = [NSString stringWithFormat:@"%.2f",[textField.text floatValue]];
        }
        if (textField.tag == 1) {
            self.costNumber = [textField.text floatValue];
        }else{
            self.cutNumber = [textField.text floatValue];
        }
        [self payMoneySet];
    });
    
    return YES;
}

#pragma mark - Http
- (void)requestCreateQRCode{
    self.costTextField.text = [NSString stringWithFormat:@"%.2f",[self.costTextField.text floatValue]];
    if (self.cutNumber<=0.f){
        self.cutTextField.text = @"";
    }else{
        self.cutTextField.text = [NSString stringWithFormat:@"%.2f",[self.cutTextField.text floatValue]];
    }
    if (self.payNumber<= 0) {
        [self showHUDWithStr:@"付款不能小于0元哟~" withSuccess:NO];
        return;
    }
    
    //h3333333333333生成支付二维码
    self.QRCodeImageView.image = [UIImage imageNamed:@"placeholder"];//233333333接入接口后换URL图片或者自己生成
}


@end
