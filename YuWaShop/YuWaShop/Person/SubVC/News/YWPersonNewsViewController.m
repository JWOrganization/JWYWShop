//
//  YWPersonNewsViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPersonNewsViewController.h"
#import "YWBasicTableViewCell.h"
#import "YWPersonNewsModel.h"
#import "YWPersonNewsDetailViewController.h"

@interface YWPersonNewsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation YWPersonNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"经营日报";
    [self dataSet];
    [self requestData];
}

- (void)dataSet{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YWBasicTableViewCell" bundle:nil] forCellReuseIdentifier:@"YWBasicTableViewCell"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWBasicTableViewCell * newsCell = [tableView dequeueReusableCellWithIdentifier:@"YWBasicTableViewCell"];
    YWPersonNewsModel * model = self.dataArr[indexPath.row];
    newsCell.nameLabel.text = model.newsTime;
    
    return newsCell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YWPersonNewsModel * model = self.dataArr[indexPath.row];
    YWPersonNewsDetailViewController * vc = [[YWPersonNewsDetailViewController alloc]init];
    vc.newsID = model.newsID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Http
- (void)requestData{
    //h33333333333门店日报
    //233333333333333要删
    for (int i = 0; i<7; i++) {
        YWPersonNewsModel * model = [[YWPersonNewsModel alloc]init];
        model.newsID = @"1";
        model.newsTime = @"2016-11-22";
        [self.dataArr addObject:model];
    }
    //233333333333333要删
    [self.tableView reloadData];
}

@end
