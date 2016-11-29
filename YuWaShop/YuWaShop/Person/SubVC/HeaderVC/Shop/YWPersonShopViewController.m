//
//  YWPersonShopViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPersonShopViewController.h"
#import "YWPersonShopHeaderView.h"
#import "YWPersonShopTableViewCell.h"
#import "YWPersonShopModel.h"
#import "YWPCBasicSetViewController.h"
#import "YWPCMapViewController.h"
#import "YWPCTimeViewController.h"
#import "YWPCEnvironmentViewController.h"
#import "YWPCEveryPayViewController.h"
#import "YWPCCutSetViewController.h"
#import "YWPCCounselorViewController.h"

@interface YWPersonShopViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)YWPersonShopModel * model;
@property (nonatomic,strong)YWPersonShopHeaderView * headerView;
@property (nonatomic,strong)YWPersonShopHeaderModel * headerModel;
@property (nonatomic,strong)NSMutableArray * headerArr;
@property (nonatomic,strong)NSArray * nameArr;
@property (nonatomic,strong)NSArray * subViewClassArr;
@property (nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation YWPersonShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"门店管理";
    [self dataSet];
    [self requestData];
}

- (void)dataSet{
    NSArray * typeNameArr = @[@"",@"    基础信息",@"    附加信息",@"    寻求帮助"];
    self.nameArr = @[@[],@[@"基本信息",@"门店地图",@"营业时间"],@[@"人均消费",@"折扣设置",@"环境设置"],@[@"营销顾问"]];
    self.subViewClassArr = @[@[],@[[YWPCBasicSetViewController class],[YWPCMapViewController class],[YWPCTimeViewController class]],@[[YWPCEveryPayViewController class],[YWPCCutSetViewController class],[YWPCEnvironmentViewController class]],@[[YWPCCounselorViewController class]]];
    self.dataArr = [NSMutableArray arrayWithArray:@[@[],@[@"",@"",@""],@[@"",@"",@""],@[@""]]];
    self.headerArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 1; i < typeNameArr.count; i++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15.f, 0.f, kScreen_Width - 30.f, 38.f)];
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor colorWithHexString:@"#bebec0"];
        label.text = typeNameArr[i];
        label.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
        [self.headerArr addObject:label];
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"YWPersonShopTableViewCell" bundle:nil] forCellReuseIdentifier:@"YWPersonShopTableViewCell"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWPersonShopTableViewCell * shopCell = [tableView dequeueReusableCellWithIdentifier:@"YWPersonShopTableViewCell"];
    shopCell.nameLabel.text = self.nameArr[indexPath.section][indexPath.row];
    shopCell.detailLabel.text = self.dataArr[indexPath.section][indexPath.row];
    return shopCell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0?94.f:38.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (!self.headerView) {
            self.headerView = [[[NSBundle mainBundle]loadNibNamed:@"YWPersonShopHeaderView" owner:nil options:nil]firstObject];
            self.headerView.frame = CGRectMake(0.f, 0.f, kScreen_Width, 94.f);
            [self.headerView setNeedsLayout];
        }
        if (self.headerModel) {
            self.headerView.model = self.headerModel;
        }
        return self.headerView;
    }else{
        return self.headerArr[section - 1];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 0) {
        Class vcClass = self.subViewClassArr[indexPath.section][indexPath.row];
        UIViewController * vc = [[vcClass alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - Http
- (void)requestData{
    NSDictionary * pragram = @{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([UserSession instance].uid)};
    
    [[HttpObject manager]postDataWithType:YuWaType_ShopAdmin_Home withPragram:pragram success:^(id responsObj) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code is %@",responsObj);
    } failur:^(id responsObj, NSError *error) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code error is %@",responsObj);
    }]; //h333333333
    
    
    //233333333333要删
    self.model = [[YWPersonShopModel alloc]init];//第一次可放UserSession内
    self.dataArr = [NSMutableArray arrayWithArray:@[@[],@[@"妮可咖啡馆",@"有地图",@"09:00-21:00 周一,周二,周五"],@[@"23333元",@"7折",@""],@[@""]]];//有接口后要根据model内数据替换有非空文字的内容
    self.headerModel = [[YWPersonShopHeaderModel alloc]init];
    //233333333333要删
    
    [self.tableView reloadData];
}

@end
