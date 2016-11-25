//
//  YWPersonNewsDetailViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/25.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPersonNewsDetailViewController.h"
#import "YWPersonNewsDetailModel.h"
#import "YWPNDetailView.h"
#import "YWPNRankView.h"
#import "YWPNPublicPraiseView.h"
#import "YWPNPopularityView.h"

@interface YWPersonNewsDetailViewController ()

@property (nonatomic,strong)YWPersonNewsDetailModel * model;

@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)YWPNDetailView * detailView;
@property (nonatomic,strong)YWPNRankView * rankView;
@property (nonatomic,strong)YWPNPublicPraiseView * publicPraiseView;
@property (nonatomic,strong)YWPNPopularityView * popularityView;

@end

@implementation YWPersonNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"门店日报";
    [self makeUI];
    [self requestData];
}

- (void)makeUI{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.f, 0.f, kScreen_Width, kScreen_Height)];
    self.scrollView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    self.detailView = [[[NSBundle mainBundle]loadNibNamed:@"YWPNDetailView" owner:nil options:nil]firstObject];
    self.detailView.frame = CGRectMake(0.f, 0.f, kScreen_Width, ACTUAL_WIDTH(165.f));
    [self.detailView setNeedsLayout];
    [self.scrollView addSubview:self.detailView];
    
    self.rankView = [[[NSBundle mainBundle]loadNibNamed:@"YWPNRankView" owner:nil options:nil]firstObject];
    self.rankView.frame = CGRectMake(0.f, CGRectGetMaxY(self.detailView.frame), kScreen_Width, ACTUAL_WIDTH(320.f));
    [self.rankView setNeedsLayout];
    [self.scrollView addSubview:self.rankView];
    
    self.publicPraiseView = [[[NSBundle mainBundle]loadNibNamed:@"YWPNPublicPraiseView" owner:nil options:nil]firstObject];
    self.publicPraiseView.frame = CGRectMake(0.f, CGRectGetMaxY(self.rankView.frame), kScreen_Width, ACTUAL_WIDTH(320.f));
    [self.publicPraiseView setNeedsLayout];
    [self.scrollView addSubview:self.publicPraiseView];
    
    self.popularityView = [[[NSBundle mainBundle]loadNibNamed:@"YWPNPopularityView" owner:nil options:nil]firstObject];
    self.popularityView.frame = CGRectMake(0.f, CGRectGetMaxY(self.publicPraiseView.frame), kScreen_Width, ACTUAL_WIDTH(320.f));
    [self.popularityView setNeedsLayout];
    [self.scrollView addSubview:self.popularityView];
    
    self.scrollView.contentSize = CGSizeMake(kScreen_Width, CGRectGetMaxY(self.popularityView.frame));
}

- (void)UIDataRefresh{
    
}

#pragma mark - Http
- (void)requestData{
    //h3333333333日报详情
    //2333333333333要删
    self.model = [[YWPersonNewsDetailModel alloc]init];
    //2333333333333要删
    [self UIDataRefresh];
}

@end
