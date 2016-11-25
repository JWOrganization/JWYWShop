//
//  YWPCCutSetViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPCCutSetViewController.h"
#import "YWPCCutPickerView.h"

@interface YWPCCutSetViewController ()

@property (nonatomic,strong)YWPCCutPickerView * cutPicker;
@property (weak, nonatomic) IBOutlet UILabel *cutLabel;
@property (weak, nonatomic) IBOutlet UILabel *cutShowLabel;

@property (nonatomic,copy)NSString * cut;//23333333可能写单例或放UserSession设置模型内
@property (nonatomic,assign)NSInteger cutInter;

@end

@implementation YWPCCutSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"折扣设置";
    [self makeUI];
}

- (void)makeUI{
    WEAKSELF;
    
    //23333333333要换
    self.cutLabel.text = @"95折";
    self.cutShowLabel.text = @"实际收入95折\n给予消费者显示全付";
    //23333333333要换
    
    self.cutPicker = [[YWPCCutPickerView alloc]initWithFrame:CGRectMake(0.f, 64.f, kScreen_Width, kScreen_Height - 64.f)];
    self.cutPicker.hidden = YES;
    self.cutPicker.saveBlock = ^(NSString * name,NSInteger cut,NSString * showName){
        weakSelf.cutLabel.text = name;
        weakSelf.cutShowLabel.text = [NSString stringWithFormat:@"实际收入%@\n给予消费者显示%@",name,showName];
    };
    [self.view addSubview:self.cutPicker];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    self.cutPicker.hidden = NO;
}

#pragma mark - Http
- (void)requestSendCut{
    //h333333333333折扣设置
    
}

@end
