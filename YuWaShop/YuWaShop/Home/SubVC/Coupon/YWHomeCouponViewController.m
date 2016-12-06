//
//  YWHomeCouponViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/30.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWHomeCouponViewController.h"
#import "YWHomeAddCouponViewController.h"
#import "YWHomeCouponHeaderView.h"
#import "YWHomeCouponTableViewCell.h"
#import "YJSegmentedControl.h"

@interface YWHomeCouponViewController ()<UITableViewDelegate,UITableViewDataSource,YJSegmentedControlDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)YWHomeCouponHeaderView * headerView;
@property (nonatomic,copy)NSString * pagens;
@property (nonatomic,assign)NSInteger pages;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong)YJSegmentedControl * segmentControl;

@end

@implementation YWHomeCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠促销";
    [self makeUI];
    [self dataSet];
    [self setupRefresh];
    [self requestDataWithPages:0];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0.f];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    if (self.dataArr.count>0)[self.tableView.mj_header beginRefreshing];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.f];
}

- (void)makeUI{
    self.segmentControl = [YJSegmentedControl segmentedControlFrame:CGRectMake(0.f, 0.f, kScreen_Width, 40.f) titleDataSource:@[@"可用",@"不可用"] backgroundColor:[UIColor clearColor] titleColor:CNaviColor titleFont:[UIFont boldSystemFontOfSize:15.f] selectColor:CNaviColor buttonDownColor:CNaviColor Delegate:self];
    self.segmentControl.backgroundColor = [UIColor whiteColor];
}

- (void)dataSet{
    self.status = 1;
    self.pagens = @"10";
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YWHomeCouponTableViewCell" bundle:nil] forCellReuseIdentifier:@"YWHomeCouponTableViewCell"];
}

- (IBAction)addCouponBtnAction:(id)sender {
    YWHomeAddCouponViewController * vc = [[YWHomeAddCouponViewController alloc]init];
    //23333333若新加优惠券返回数据不全则接口请求，否则Block新加
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - YJSegmentedControlDelegate
-(void)segumentSelectionChange:(NSInteger)selection{
    self.status = selection+1;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.segmentControl;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWHomeCouponTableViewCell * couponCell = [tableView dequeueReusableCellWithIdentifier:@"YWHomeCouponTableViewCell"];
    couponCell.model = self.dataArr[indexPath.row];
    return couponCell;
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
    
    NSDictionary * pragram = @{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([UserSession instance].uid),@"type":@(self.status),@"pagen":@([self.pagens integerValue]),@"pages":@(page)};
    
    [[HttpObject manager]postNoHudWithType:YuWaType_Shoper_ShopAdmin_CouponList withPragram:pragram success:^(id responsObj) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code is %@",responsObj);
        if (page == 0)[self.dataArr removeAllObjects];
        
        //233333333要删
        for (int i = 0; i<3; i++) {
            [self.dataArr addObject:[[YWHomeCouponModel alloc]init]];
        }
        //233333333要删
        [self.tableView reloadData];
    } failur:^(id responsObj, NSError *error) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code error is %@",responsObj);
    }]; //h333333333
}

@end
