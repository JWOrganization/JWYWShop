//
//  YWPCBasicSetViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPCBasicSetViewController.h"
#import "JWTextView.h"

@interface YWPCBasicSetViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *shopIconBtn;
@property (weak, nonatomic) IBOutlet JWTextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *subPhoneTextField;

@property (nonatomic,strong)UIImage * cameraImage;

@end

@implementation YWPCBasicSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"门店的基本信息";
    [self makeUI];
}

- (void)makeUI{
    self.submitBtn.layer.cornerRadius = 5.f;
    self.submitBtn.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 5.f;
    self.textView.layer.masksToBounds = YES;
    self.textView.placeholder = @"显示简介";
//    self.textView.isDrawPlaceholder = NO;//233333有简介了的话
    
}

- (IBAction)submitBtnAction:(id)sender {
}
- (IBAction)shopIconBtnAction:(id)sender {
    [self makeLocalImagePicker];
}

- (void)makeLocalImagePicker{
    WEAKSELF;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {//take photo
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [weakSelf myImagePickerWithType:UIImagePickerControllerSourceTypeCamera];
        } else {
            MyLog(@"照片源不可用");
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {//to localPhotos
        [weakSelf myImagePickerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)myImagePickerWithType:(UIImagePickerControllerSourceType)sourceType{
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        [picker setSourceType:sourceType];
        [picker setAllowsEditing:YES];
        [picker setDelegate:self];
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        MyLog(@"照片源不可用");
    }
}

#pragma mark - ImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.cameraImage = info[@"UIImagePickerControllerEditedImage"];
    [self.shopIconBtn setImage:self.cameraImage forState:UIControlStateNormal];
    [self requestChangeIcon];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Http
- (void)requestChangeIcon{
    //h33333333333上传门店头像
}

- (void)requestUpLoadShopInfo{
    //h333333333333提交商店信息
    if ([self.nameTextField.text isEqualToString:@""]) {
        [self showHUDWithStr:@"门店名称不能为空哟" withSuccess:NO];
        return;
    }else if (!self.cameraImage) {
        [self showHUDWithStr:@"门店头像不能为空哟" withSuccess:NO];
        return;
    }else if ([self.textView.text isEqualToString:@""]) {
        [self showHUDWithStr:@"门店简介不能为空哟" withSuccess:NO];
        return;
    }else if ([self.addressTextField.text isEqualToString:@""]) {
        [self showHUDWithStr:@"门店地址不能为空哟" withSuccess:NO];
        return;
    }else if ([self.firstPhoneTextField.text isEqualToString:@""]) {
        [self showHUDWithStr:@"首选电话不能为空哟" withSuccess:NO];
        return;
    }else if (![JWTools isPhoneIDWithStr:self.firstPhoneTextField.text]||![JWTools isPhoneIDWithStr:self.subPhoneTextField.text]) {
        [self showHUDWithStr:@"请输入正确电话哟" withSuccess:NO];
        return;
    }
    
    
    [self showHUDWithStr:@"恭喜,修改成功" withSuccess:YES];
}

@end
