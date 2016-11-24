//
//  YWPersonSubVipViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPersonSubVipViewController.h"
#import "YWPersonSubVipTableViewCell.h"
#import "YWPersonSubVipHeaderView.h"

@interface YWPersonSubVipViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)YWPersonSubVipHeaderView * headerView;
@property (nonatomic,strong)YWPersonSubVipHeaderModel * headerModel;
@property (nonatomic,copy)NSString * pagens;
@property (nonatomic,assign)NSInteger pages;
@property (nonatomic,strong)NSMutableArray * dataArr;

@property (nonatomic,assign)NSInteger status;

@end

@implementation YWPersonSubVipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"锁定会员";
    [self dataSet];
    [self setupRefresh];
    [self requestDataWithPages:0];
}

- (void)dataSet{
    self.pagens = @"10";
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    [self.tableView registerNib:[UINib nibWithNibName:@"YWPersonSubVipTableViewCell" bundle:nil] forCellReuseIdentifier:@"YWPersonSubVipTableViewCell"];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 95.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!self.headerView) {
        WEAKSELF;
        self.headerView = [[[NSBundle mainBundle]loadNibNamed:@"YWPersonSubVipHeaderView" owner:nil options:nil] firstObject];
        self.headerView.frame = CGRectMake(0.f, 0.f, kScreen_Width, 60.f);
        self.headerView.changeShowBlock = ^(NSInteger type){
            [weakSelf requestChangeTypeWithType:type];
        };
        self.headerView.getMoneyBlock = ^(){
            [weakSelf requestGetMoney];
        };
        [self.headerView setNeedsLayout];
    }
    if (self.headerModel)self.headerView.model = self.headerModel;
    
    return self.headerView;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWPersonSubVipTableViewCell * subVipCell = [tableView dequeueReusableCellWithIdentifier:@"YWPersonSubVipTableViewCell"];
    subVipCell.model = self.dataArr[indexPath.row];
    
    return subVipCell;
}

#pragma mark - TableView Refresh
- (void)setupRefresh{
    self.tableView.mj_header = [UIScrollView scrollRefreshGifHeaderWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
        [self headerRereshing];
    }];
    self.tableView.mj_footer = [UIScrollView scrollRefreshGifFooterWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
        [self footerRereshing];
    }];
}
- (void)headerRereshing{
    self.pages = 0;
    [self requestDataWithPages:0];
}
- (void)footerRereshing{
    self.pages++;
    [self requestDataWithPages:self.pages];
}
- (void)cancelRefreshWithIsHeader:(BOOL)isHeader{
    if (isHeader) {
        [self.tableView.mj_header endRefreshing];
    }else{
        [self.tableView.mj_footer endRefreshing];
    }
}

#pragma mark - Http
- (void)requestChangeTypeWithType:(NSInteger)type{
    self.status = type;
    [self.tableView.mj_header beginRefreshing];
}
- (void)requestDataWithPages:(NSInteger)page{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(RefreshTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cancelRefreshWithIsHeader:(page==0?YES:NO)];
    });
    
    if (page == 0)[self.dataArr removeAllObjects];
    //233333333333333要删
    [self.dataArr addObject:[[YWPersonSubVipModel alloc]init]];
    self.headerModel = [[YWPersonSubVipHeaderModel alloc]init];
    //233333333333333要删
    [self.tableView reloadData];
}

- (void)requestGetMoney{
    //h33333333333提现
    
    [self.tableView reloadData];
}

@end
