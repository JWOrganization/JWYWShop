//
//  YWHomeViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/17.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWHomeViewController.h"
#import "YWHomeCollectionViewCell.h"
#import "YWHomeCollectionHeaderView.h"

@interface YWHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSArray * nameArr;

@end

@implementation YWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavi];
    [self dataSet];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0.f];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}
- (void)makeNavi{
    self.title = @"首页";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:@"MessageNoChat" withSelectImage:@"MessageNoChat" withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside withWidth:30.f];
}

- (void)dataSet{
    self.nameArr = @[@"财务管理",@"商品管理",@"现金券",@"口碑品牌",@"门店管理",@"预定管理",@"节日管理",@"相册管理",@"同业排行"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"YWHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"YWHomeCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"YWHomeCollectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YWHomeCollectionHeaderView"];
}

- (void)messageAction{
    
}

#pragma mark - UICollectionViewDataSource
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    YWHomeCollectionHeaderView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YWHomeCollectionHeaderView" forIndexPath:indexPath];
    
    return header;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.nameArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YWHomeCollectionViewCell * homeCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YWHomeCollectionViewCell" forIndexPath:indexPath];
    homeCell.nameLabel.text = self.nameArr[indexPath.row];
    return homeCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreen_Width/3, ACTUAL_WIDTH(110.f));
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreen_Width, 175.f);
}

@end
