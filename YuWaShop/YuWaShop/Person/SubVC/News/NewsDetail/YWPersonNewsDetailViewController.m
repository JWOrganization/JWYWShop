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

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.publicPraiseView.height<300.f) {
        self.publicPraiseView.frame = CGRectMake(0.f, 165.f, kScreen_Width, 320.f);
        self.rankView.frame = CGRectMake(0.f, 485.f, kScreen_Width, 320.f);
        self.popularityView.frame = CGRectMake(0.f, 805.f, kScreen_Width, 320.f);
    }
}

- (void)makeUI{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.f, 0.f, kScreen_Width, kScreen_Height)];
    self.scrollView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    self.detailView = [[[NSBundle mainBundle]loadNibNamed:@"YWPNDetailView" owner:nil options:nil]firstObject];
    self.detailView.frame = CGRectMake(0.f, 0.f, kScreen_Width, 165.f);
    [self.detailView setNeedsLayout];
    [self.scrollView addSubview:self.detailView];
    
    self.publicPraiseView = [[[NSBundle mainBundle]loadNibNamed:@"YWPNPublicPraiseView" owner:nil options:nil]firstObject];
    self.publicPraiseView.frame = CGRectMake(0.f, 165.f, kScreen_Width, 320.f);
    [self.publicPraiseView setNeedsDisplay];
    [self.scrollView addSubview:self.publicPraiseView];
    
    self.rankView = [[[NSBundle mainBundle]loadNibNamed:@"YWPNRankView" owner:nil options:nil]firstObject];
    self.rankView.frame = CGRectMake(0.f, 485.f, kScreen_Width, 320.f);
    [self.rankView setNeedsLayout];
    [self.scrollView addSubview:self.rankView];
    
    self.popularityView = [[[NSBundle mainBundle]loadNibNamed:@"YWPNPopularityView" owner:nil options:nil]firstObject];
    self.popularityView.frame = CGRectMake(0.f, 805.f, kScreen_Width, 320.f);
    [self.popularityView setNeedsLayout];
    [self.scrollView addSubview:self.popularityView];
    
    self.scrollView.contentSize = CGSizeMake(kScreen_Width, 1125.f);
}

- (void)UIDataRefresh{//23333333333日报内容self.model设置
    self.detailView.nameLabel.text = @"Drink me咖啡店";
    self.detailView.timeLabel.text = @"2016-11-11";
    self.detailView.conLabel.text = @"您的门店经营状况平稳,超过同城99%的同业商家";
    self.detailView.compareLabel.text = @"数据为昨日单日数据,增长下降趋势为上周同日";
    
    
    NSInteger goodCount = 4;//2333333好评数根据接口换
    NSInteger badCount = 4;//2333333差评数根据接口换
    //tag1-5为好评11-15为差评
    for (int i = 1; i <= goodCount; i++) {
        UIImageView * imageView = [self.publicPraiseView viewWithTag:i];
        imageView.image = [UIImage imageNamed:@"PublicPraise-star-0"];
    }
    for (int i = 1; i <= badCount; i++) {
        UIImageView * imageView = [self.publicPraiseView viewWithTag:(i+10)];
        imageView.image = [UIImage imageNamed:@"PublicUnPraise-star-0"];
    }
    
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
