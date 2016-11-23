//
//  YWPersonWeekCountViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPersonWeekCountViewController.h"
#import "YWPersonWeekCountTableViewCell.h"

@interface YWPersonWeekCountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation YWPersonWeekCountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结算周期";
    [self dataSet];
}

- (void)dataSet{
    [self.tableView registerNib:[UINib nibWithNibName:@"YWPersonWeekCountTableViewCell" bundle:nil] forCellReuseIdentifier:@"YWPersonWeekCountTableViewCell"];
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWPersonWeekCountTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"YWPersonWeekCountTableViewCell"];
    [cell.showBtn setTitle:indexPath.row==0?@"团":@"惠" forState:UIControlStateNormal];
    cell.nameLabel.text = indexPath.row==0?@"团购":@"闪惠";
    return cell;
}


@end
