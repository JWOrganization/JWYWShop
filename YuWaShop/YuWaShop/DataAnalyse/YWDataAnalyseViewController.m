//
//  YWDataAnalyseViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/17.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWDataAnalyseViewController.h"
#import "CFLineChartView.h"
#import "NSDictionary+Attributes.h"

@interface YWDataAnalyseViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)UIScrollView * scrollView;

@property (nonatomic,strong)CFLineChartView * pageviewView;
@property (nonatomic,strong)CFLineChartView * customersView;
@property (nonatomic,strong)CFLineChartView * consumptionView;

@end

@implementation YWDataAnalyseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"数据分析";
    [self makeUI];
}

- (void)makeUI{
    [self.segmentControl setTitleTextAttributes:[NSDictionary dicOfTextAttributeWithFont:[UIFont systemFontOfSize:15.f] withTextColor:[UIColor colorWithHexString:@"#25C0E9"]] forState:UIControlStateNormal];
    [self.segmentControl setTitleTextAttributes:[NSDictionary dicOfTextAttributeWithFont:[UIFont systemFontOfSize:15.f] withTextColor:[UIColor whiteColor]] forState:UIControlStateSelected];
    self.segmentControl.tintColor = CNaviColor;
    self.segmentControl.layer.borderColor = CNaviColor.CGColor;
    [self.segmentControl setDividerImage:[UIImage imageNamed:@"segmentLine"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.segmentControl.layer.borderWidth = 2.f;
    self.segmentControl.layer.cornerRadius = 5.f;
    self.segmentControl.layer.masksToBounds = YES;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.f, 105.f, kScreen_Width, kScreen_Height - 105.f - 49.f)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    [self doWithCreateUI];
    [self requestData];
}

- (void)doWithCreateUI{
    CGFloat chartViewHeight = ACTUAL_WIDTH(200.f);
    self.pageviewView = [CFLineChartView lineChartViewWithFrame:CGRectMake(10, 45.f, kScreen_Width - 20, chartViewHeight)];
    self.pageviewView.isShowLine = YES;
    self.pageviewView.isShowPoint = YES;
    self.pageviewView.isShowValue = YES;
    self.pageviewView.isShowLineChart = YES;
    [self.scrollView addSubview:self.pageviewView];
    
    self.customersView = [CFLineChartView lineChartViewWithFrame:CGRectMake(10, 45.f+CGRectGetMaxY(self.pageviewView.frame), kScreen_Width - 20, chartViewHeight)];
    self.customersView.isShowLine = YES;
    self.customersView.isShowPillar = YES;
    self.customersView.isShowValue = YES;
    [self.scrollView addSubview:self.customersView];
    
    self.consumptionView = [CFLineChartView lineChartViewWithFrame:CGRectMake(10, 45.f+CGRectGetMaxY(self.customersView.frame), kScreen_Width - 20, chartViewHeight)];
    self.consumptionView.isShowLine = YES;
    self.consumptionView.isShowPoint = YES;
    self.consumptionView.isShowValue = YES;
    self.consumptionView.isShowLineChart = YES;
    [self.scrollView addSubview:self.consumptionView];
    
    NSArray * nameArr = @[@"店铺的浏览量",@"消费客户数",@"消费总金额"];
    NSArray * imgNameArr = @[@"chart_line01",@"chart_line11",@"chart_line01"];
    NSArray * pointNameArr = @[@" 点击量",@" 单位:个",@" 单位:k"];
    for (int i = 0; i<nameArr.count; i++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10.f, i*(45.f+chartViewHeight), kScreen_Width - 20.f, 45.f)];
        label.text = nameArr[i];
        label.textColor = [UIColor colorWithHexString:@"#97979c"];
        label.font = [UIFont boldSystemFontOfSize:14.f];
        [self.scrollView addSubview:label];
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0.f, 0.f, 110.f, 30.f)];
        btn.center = CGPointMake(kScreen_Width/2, CGRectGetMaxY(label.frame));
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [btn setImage:[UIImage imageNamed:imgNameArr[i]] forState:UIControlStateNormal];
        [btn setTitle:pointNameArr[i] forState:UIControlStateNormal];
        btn.tag = 1000+i;
        [btn setUserInteractionEnabled:NO];
        [self.scrollView addSubview:btn];
    }
    
    self.scrollView.contentSize = CGSizeMake(kScreen_Width, CGRectGetMaxY(self.consumptionView.frame)+10.f);
}

- (void)setupConditions{
    [self.pageviewView drawChartWithLineChartType:LineChartType_Straight pointType:PointType_Circel];
    [self.customersView drawChartWithLineChartType:LineChartType_Curve pointType:PointType_Circel];
    [self.consumptionView drawChartWithLineChartType:LineChartType_Curve pointType:PointType_Circel];
}

- (void)reDrawChart{
    [self setupConditions];
}

#pragma mark - UIControl Action
- (IBAction)segmentControlaction:(UISegmentedControl *)sender {
    self.status = sender.selectedSegmentIndex;
    [self requestData];
}

#pragma mark - Http
- (void)requestData{
    //h333333333消费分析
//    self.status
    self.pageviewView.xValues = @[@"1日", @"2日", @"3日", @"4日", @"5日", @"6日", @"7日"];
    self.pageviewView.yValues = @[@35, @5, @80, @40, @50, @13, @50];
    
    self.customersView.xValues = @[@1, @2, @3, @4, @5, @6, @7];
    self.customersView.yValues = @[@35, @5, @80, @40, @50, @13, @50];
    
    self.consumptionView.xValues = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
    self.consumptionView.yValues = @[@350, @1000, @800, @400, @500, @130, @50, @750,@250, @100, @640, @950, @333, @510];
    
    [self reDrawChart];
}

@end
