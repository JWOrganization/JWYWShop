//
//  YWPCCutSetViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPCCutSetViewController.h"
#import "YWPersonShopModel.h"

@interface YWPCCutSetViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)UIPickerView * cutPicker;
@property (weak, nonatomic) IBOutlet UILabel *currentCutLabel;

@property (weak, nonatomic) IBOutlet UILabel *cutShowLabel;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (nonatomic,strong)UIPickerView * picker;
@property (nonatomic,copy)NSString * cut;//23333333可能写单例或放UserSession设置模型内
@property (nonatomic,assign)NSInteger cutInter;
@property (nonatomic,strong)NSArray * cutArr;
@property (nonatomic,strong)YWPersonShopModel * model;

@end

@implementation YWPCCutSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"折扣设置";
    self.model = [YWPersonShopModel sharePersonShop];
    [self makeUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0.f];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.f];
}

- (void)makeUI{
    self.sureBtn.layer.cornerRadius = 5.f;
    self.sureBtn.layer.masksToBounds = YES;
    
    self.currentCutLabel.text = [NSString stringWithFormat:@"当前折扣%@",([UserSession instance].cut==95?@"全付":[NSString stringWithFormat:@"%zi折",([UserSession instance].cut+5)])];
    self.cutShowLabel.text = [NSString stringWithFormat:@"客服折扣%zi+5=%@ (0.5折为平台分配资金)\n\n不能低于95折",self.cut,[UserSession instance].cut==95?@"全付":[NSString stringWithFormat:@"%zi折",([UserSession instance].cut+5)]];
    
    [self makePickerView];
}

- (IBAction)sureBtnAction:(id)sender {
    [self requestSendCut];
}

- (void)makePickerView{
    self.picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0.f, 392.f, kScreen_Width, kScreen_Height - 392.f - 66.f)];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    self.picker.backgroundColor = [UIColor whiteColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.picker selectRow:(95-[UserSession instance].cut >=0?(95-[UserSession instance].cut):0) inComponent:0 animated:YES];
    });
    self.cut = [NSString stringWithFormat:@"%zi折",[UserSession instance].cut];
    self.cutInter = [UserSession instance].cut;
    [self saveAvtion];
    NSMutableArray * cutArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 95; i >= 10; i--) {
        if (i%10 == 0) {
            [cutArr addObject:[NSString stringWithFormat:@"%zi折",(i/10)]];
        }else{
            [cutArr addObject:[NSString stringWithFormat:@"%zi折",i]];
        }
    }
    self.cutArr = [NSArray arrayWithArray:cutArr];
    [self.view addSubview:self.picker];
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.cut = self.cutArr[row];
    self.cutInter = 95 - row;
    [self saveAvtion];
}

- (void)saveAvtion{
    NSString * showName;
    if (self.cutInter%10 == 5) {
        showName = self.cutInter== 95?@"全付":[NSString stringWithFormat:@"%zi折",((self.cutInter+5)/10)];
    }else{
        showName = [NSString stringWithFormat:@"%zi折",(self.cutInter+5)];
    }
    self.cutShowLabel.text = [NSString stringWithFormat:@"客服折扣%@+5=%@ (0.5折为平台分配资金)\n\n不能低于95折",self.cut,showName];
}
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.cutArr.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.cutArr[row];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.font=[UIFont systemFontOfSize:24];
        pickerLabel.textColor=[UIColor blackColor];
        pickerLabel.textAlignment= NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    [[pickerView.subviews objectAtIndex:1] setHidden:TRUE];
    [[pickerView.subviews objectAtIndex:2] setHidden:TRUE];
    return pickerLabel;
}

#pragma mark - Http
- (void)requestSendCut{
    //h333333333333折扣设置
    
    NSString * cutStr = [NSString stringWithFormat:@"0.%zi",self.cutInter];//2333333要换成str
    
    [UserSession instance].cut = self.cutInter;
    NSMutableArray * shopArr = [NSMutableArray arrayWithArray:self.model.dataArr[2]];
    [shopArr replaceObjectAtIndex:1 withObject:([UserSession instance].cut==95?@"全付":[NSString stringWithFormat:@"%zi折",([UserSession instance].cut+5)])];
    [self.model.dataArr replaceObjectAtIndex:2 withObject:shopArr];
    self.currentCutLabel.text = [NSString stringWithFormat:@"当前折扣%@",([UserSession instance].cut==95?@"全付":[NSString stringWithFormat:@"%zi折",([UserSession instance].cut+5)])];
    [self showHUDWithStr:@"折扣设置成功" withSuccess:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

@end
