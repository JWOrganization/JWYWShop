//
//  YWBankViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWBankViewController.h"
#import "YWBankTableViewCell.h"
#import "NSString+JWAppendOtherStr.h"

@interface YWBankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray * bankArr;

@end

@implementation YWBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡管理";
    [self dataSet];
    [self requestData];
}

- (void)dataSet{
    self.nameLabel.attributedText = [NSString stringWithFirstStr:@"如需要修改银行卡信息,请您联系" withFont:[UIFont systemFontOfSize:13.f] withColor:[UIColor blackColor] withSecondtStr:@"责任销售" withFont:[UIFont systemFontOfSize:13.f] withColor:CNaviColor];
    self.bankArr = [NSMutableArray arrayWithCapacity:0];
    [self.tableView registerNib:[UINib nibWithNibName:@"YWBankTableViewCell" bundle:nil] forCellReuseIdentifier:@"YWBankTableViewCell"];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bankArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWBankTableViewCell * bankCell = [tableView dequeueReusableCellWithIdentifier:@"YWBankTableViewCell"];
    bankCell.model = self.bankArr[indexPath.row];
    return bankCell;
}

#pragma mark - Http
- (void)requestData{
    //h333333333333
    
    //2333333333删
    [self.bankArr addObject:[[YWBankModel alloc]init]];
    //2333333333删
    [self.tableView reloadData];
}


@end
