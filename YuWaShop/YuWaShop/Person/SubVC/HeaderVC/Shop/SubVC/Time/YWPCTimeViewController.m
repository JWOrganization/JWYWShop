//
//  YWPCTimeViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPCTimeViewController.h"
#import "YWPCTimeTableViewCell.h"

@interface YWPCTimeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic,strong)NSMutableArray * timeArr;

@end

@implementation YWPCTimeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"营业时间";
    [self dataSet];
    [self requestData];
}

- (IBAction)submitBtnAction:(id)sender {
    [self addTimeAction];
}

- (void)dataSet{
    self.submitBtn.layer.cornerRadius = 5.f;
    self.submitBtn.layer.masksToBounds = YES;
    
    self.timeArr = [NSMutableArray arrayWithCapacity:0];
    [self.tableView registerNib:[UINib nibWithNibName:@"YWPCTimeTableViewCell" bundle:nil] forCellReuseIdentifier:@"YWPCTimeTableViewCell"];
}

- (void)addTimeAction{
    //2333333添加经营时间
    //2333333333删
    YWPCTimeModel * model = [[YWPCTimeModel alloc]init];
    model.timeID = @"1";
    [self.timeArr addObject:model];
    [self.tableView reloadData];
    //2333333333删
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.f;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle ==UITableViewCellEditingStyleDelete){
        UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            YWPCTimeModel * model = self.timeArr[indexPath.row];
            [self requestDelTimeWithID:model.timeID withIndexPath:indexPath];
        }];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除经营时间?" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:cancelAction];
        [alertVC addAction:OKAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.timeArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWPCTimeTableViewCell * timeCell = [tableView dequeueReusableCellWithIdentifier:@"YWPCTimeTableViewCell"];
    timeCell.model = self.timeArr[indexPath.row];
    return timeCell;
}

#pragma mark - Http
- (void)requestData{
    //h333333333333时间信息
    
    //2333333333删
    YWPCTimeModel * model = [[YWPCTimeModel alloc]init];
    model.timeID = @"1";
    [self.timeArr addObject:model];
    //2333333333删
    [self.tableView reloadData];
}

- (void)requestDelTimeWithID:(NSString *)timeID withIndexPath:(NSIndexPath *)indexPath{
    //h3333333333删除经营时间
    [self.timeArr removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

@end
