//
//  YWPersonSuggRePlayViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/28.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPersonSuggRePlayViewController.h"
#import "YWPSRePlayTableViewCell.h"

@interface YWPersonSuggRePlayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation YWPersonSuggRePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见回复";
    [self dataSet];
    [self requestData];
}

- (void)dataSet{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YWPSRePlayTableViewCell" bundle:nil] forCellReuseIdentifier:@"YWPSRePlayTableViewCell"];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.tableView fd_heightForCellWithIdentifier:@"YWPSRePlayTableViewCell" configuration:^(YWPSRePlayTableViewCell * cell) {
        cell.model = self.dataArr[indexPath.row];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWPSRePlayTableViewCell * replayCell = [tableView dequeueReusableCellWithIdentifier:@"YWPSRePlayTableViewCell"];
    replayCell.model = self.dataArr[indexPath.row];
    return replayCell;
}

#pragma mark - Http
- (void)requestData{
    //h33333333获取建议回复
    //233333333333要删
    for (int i = 0; i<3; i++) {
        YWPSRePlayModel * model = [[YWPSRePlayModel alloc]init];
        [self.dataArr addObject:model];
    }
    //233333333333要删
    
    [self.tableView reloadData];
}

@end
