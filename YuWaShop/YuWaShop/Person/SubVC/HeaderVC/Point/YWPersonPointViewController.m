//
//  YWPersonPointViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPersonPointViewController.h"
#import "YWPersonPointHeaderView.h"
#import "YWPersonPointTableViewCell.h"

@interface YWPersonPointViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)YWPersonPointHeaderView * headerView;
@property (nonatomic,strong)YWPersonPointHeaderModel * headerModel;
@property (nonatomic,copy)NSString * pagens;
@property (nonatomic,assign)NSInteger pages;
@property (nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation YWPersonPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"积分分红";
    [self dataSet];
    [self requestDataWithPages:0];
}

- (void)dataSet{
    self.pagens = @"10";
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    [self.tableView registerNib:[UINib nibWithNibName:@"YWPersonPointTableViewCell" bundle:nil] forCellReuseIdentifier:@"YWPersonPointTableViewCell"];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60.f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!self.headerView) {
        WEAKSELF;
        self.headerView = [[[NSBundle mainBundle]loadNibNamed:@"YWPersonPointHeaderView" owner:nil options:nil] firstObject];
        self.headerView.frame = CGRectMake(0.f, 0.f, kScreen_Width, 60.f);
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
    YWPersonPointTableViewCell * pointCell = [tableView dequeueReusableCellWithIdentifier:@"YWPersonPointTableViewCell"];
    pointCell.model = self.dataArr[indexPath.row];
    
    return pointCell;
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
- (void)requestDataWithPages:(NSInteger)page{
    //h333333333积分分红
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(RefreshTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cancelRefreshWithIsHeader:(page==0?YES:NO)];
    });
    
    if (page == 0)[self.dataArr removeAllObjects];
    //233333333333333要删
    [self.dataArr addObject:[[YWPersonPointModel alloc]init]];
    self.headerModel = [[YWPersonPointHeaderModel alloc]init];
    //233333333333333要删
    [self.tableView reloadData];
}

- (void)requestGetMoney{
    //h33333333333提现
    
    [self.tableView reloadData];
}

@end
