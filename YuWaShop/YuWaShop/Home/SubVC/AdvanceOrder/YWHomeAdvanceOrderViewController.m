//
//  YWHomeAdvanceOrderViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/12/1.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWHomeAdvanceOrderViewController.h"
#import "YWHomeAdvanceOrderTableViewCell.h"
#import "NSDictionary+Attributes.h"

@interface YWHomeAdvanceOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)UIView * headerView;
@property (nonatomic,strong)UISegmentedControl * typeSegmentView;
@property (nonatomic,copy)NSString * pagens;
@property (nonatomic,assign)NSInteger pages;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong)UIAlertController * alertVC;
@property (nonatomic,strong)UITapGestureRecognizer * tap;

@end

@implementation YWHomeAdvanceOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约订单";
    [self makeUI];
    [self dataSet];
    [self setupRefresh];
    [self requestDataWithPages:0];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication].keyWindow removeGestureRecognizer:self.tap];
}

- (void)makeUI{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, kScreen_Width, 50.f)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    
    self.typeSegmentView = [[UISegmentedControl alloc]initWithItems:@[@"待处理",@"已接受",@"已取消"]];
    self.typeSegmentView.frame = CGRectMake(20.f, 10.f, kScreen_Width - 40.f, 30.f);
    self.typeSegmentView.selectedSegmentIndex = 0;
    [self.typeSegmentView setTitleTextAttributes:[NSDictionary dicOfTextAttributeWithFont:[UIFont systemFontOfSize:15.f] withTextColor:[UIColor colorWithHexString:@"#25C0E9"]] forState:UIControlStateNormal];
    [self.typeSegmentView setTitleTextAttributes:[NSDictionary dicOfTextAttributeWithFont:[UIFont systemFontOfSize:15.f] withTextColor:[UIColor whiteColor]] forState:UIControlStateSelected];
    self.typeSegmentView.tintColor = CNaviColor;
    self.typeSegmentView.layer.borderColor = CNaviColor.CGColor;
    [self.typeSegmentView setDividerImage:[UIImage imageNamed:@"segmentLine"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.typeSegmentView.layer.borderWidth = 2.f;
    self.typeSegmentView.layer.cornerRadius = 5.f;
    self.typeSegmentView.layer.masksToBounds = YES;
    [self.typeSegmentView addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    [self.headerView addSubview:self.typeSegmentView];
    
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [[UIApplication sharedApplication].keyWindow addGestureRecognizer:self.tap];
}

- (void)dataSet{
    self.pagens = @"10";
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YWHomeAdvanceOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"YWHomeAdvanceOrderTableViewCell"];
}

- (void)segmentControlAction:(UISegmentedControl *)sender{
    self.status = sender.selectedSegmentIndex;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWHomeAdvanceOrderTableViewCell * advanceOrderCell = [tableView dequeueReusableCellWithIdentifier:@"YWHomeAdvanceOrderTableViewCell"];
    advanceOrderCell.model = self.dataArr[indexPath.row];
    advanceOrderCell.status = self.status;
    if (self.status <= 0) {
        advanceOrderCell.rePlayBlock = ^(){
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"Hello Boss" message:@"请输入您对客户的回复" preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.placeholder = @"请输入您对客户的回复";
                textField.secureTextEntry = NO;
            }];
            UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField * replayTextField = alertVC.textFields.firstObject;
                [self requestDelOrderWithReplay:replayTextField.text withIndexPath:indexPath];
            }];
            UIAlertAction * delAction = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField * replayTextField = alertVC.textFields.firstObject;
                [self requestCancelOrderWithReplay:replayTextField.text withIndexPath:indexPath];
            }];
            [alertVC addAction:delAction];
            [alertVC addAction:OKAction];
            self.alertVC = alertVC;
            [self presentViewController:self.alertVC animated:YES completion:nil];
        };
    }
    return advanceOrderCell;
}

- (void)tapAction{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.alertVC dismissViewControllerAnimated:NO completion:nil];
    });
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(RefreshTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cancelRefreshWithIsHeader:(page==0?YES:NO)];
    });
    //    self.status
    if (page == 0)[self.dataArr removeAllObjects];
    
    //233333333要删
    for (int i = 0; i<3; i++) {
        YWHomeAdvanceOrderModel * model =[[YWHomeAdvanceOrderModel alloc]init];
        model.orderID = @"233333333";
        [self.dataArr addObject:model];
    }
    //233333333要删
    [self.tableView reloadData];
}

- (void)requestDelOrderWithReplay:(NSString *)rePlay withIndexPath:(NSIndexPath *)indexPath{
    //h3333333333删除回复了的订单,并提交回复
    //    rePlay//回复信息
    YWHomeAdvanceOrderModel * model = self.dataArr[indexPath.row];
//    model.orderID
    [self.dataArr removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

- (void)requestCancelOrderWithReplay:(NSString *)rePlay withIndexPath:(NSIndexPath *)indexPath{
    //h3333333333删除拒绝了的订单,并提交回复
    //    rePlay//回复信息
    YWHomeAdvanceOrderModel * model = self.dataArr[indexPath.row];
    //    model.orderID
    [self.dataArr removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

@end