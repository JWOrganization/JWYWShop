//
//  YWPersonSuggRePlayViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/28.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPersonSuggRePlayViewController.h"
#import "JWChatTableViewCell.h"

@interface YWPersonSuggRePlayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,copy)NSString * pagens;
@property (nonatomic,assign)NSInteger pages;

@end

@implementation YWPersonSuggRePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见回复";
    [self dataSet];
    [self setupRefresh];
    [self requestDataWithPages:0];
}
- (void)dataSet{
    self.pagens = @"10";
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    [self.tableView registerNib:[UINib nibWithNibName:@"JWChatTableViewCell" bundle:nil] forCellReuseIdentifier:@"JWChatTableViewCell"];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.tableView fd_heightForCellWithIdentifier:@"JWChatTableViewCell" configuration:^(JWChatTableViewCell * cell) {
        cell.model = self.dataArr[indexPath.row];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JWChatTableViewCell * replayCell = [tableView dequeueReusableCellWithIdentifier:@"JWChatTableViewCell"];
    replayCell.model = self.dataArr[indexPath.row];
    return replayCell;
}

#pragma mark - TableView Refresh
- (void)setupRefresh{
    self.tableView.mj_header = [UIScrollView scrollRefreshGifHeaderWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
        [self headerRereshing];
    }];
}
- (void)headerRereshing{
    self.pages++;
    if (self.dataArr.count <= 0)self.pages = 0;
    [self requestDataWithPages:self.pages];
}

#pragma mark - Http
- (void)requestDataWithPages:(NSInteger)page{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(RefreshTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    
    if (page == 0)[self.dataArr removeAllObjects]; 
    //233333333333要删
    for (int i = 0; i<3; i++) {
        YWPSRePlayModel * model = [[YWPSRePlayModel alloc]init];
        model.con = @"2333333333";
        model.time = [NSString stringWithFormat:@"1480594%zi51",i];
        model.status = i%2==0?1:0;
        if (self.dataArr.count<=0) {
            [self.dataArr addObject:model];
        }else{
            [self.dataArr insertObject:model atIndex:0];
        }
    }//2333333333333model算内容,数组insert
    //233333333333要删
    //h33333333333获取建议回复
    
    [self.tableView reloadData];
    if (page == 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.dataArr.count-1) inSection:0]  atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

@end
