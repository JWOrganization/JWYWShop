//
//  YWPersonViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/17.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPersonViewController.h"
#import "YWPersonTableViewCell.h"
#import "YWPersonHeaderView.h"

#define PERSONCCELL @"YWPersonTableViewCell"

@interface YWPersonViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)YWPersonHeaderView * headerView;
@property (nonatomic,strong)NSArray * countArr;
@property (nonatomic,strong)UIImage * cameraImage;

@end

@implementation YWPersonViewController

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

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.f];
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
}

- (void)makeNavi{
    self.navigationItem.title = @"";
}

- (void)dataSet{
    self.countArr = @[@0,@3,@5,@1];
    
    [self.tableView registerNib:[UINib nibWithNibName:PERSONCCELL bundle:nil] forCellReuseIdentifier:PERSONCCELL];
}

- (void)makeLocalImagePicker{
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVC.allowPickingVideo = NO;
    [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
        self.cameraImage = photos[0];
        self.headerView.iconImageView.image = self.cameraImage;
    }];
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0?(90.f + ACTUAL_WIDTH(250.f)):10.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section != 0)return nil;
    if (!self.headerView) {
        WEAKSELF;
        self.headerView = [[[NSBundle mainBundle]loadNibNamed:@"YWPersonHeaderView" owner:nil options:nil]firstObject];
        self.headerView.chooseBtnBlock = ^(NSInteger choosedBtn){//1门店2会员3分红
            //2333333
        };
        self.headerView.iconBtnBlock = ^(){
            [weakSelf makeLocalImagePicker];
        };
    }
    if ([UserSession instance].isLogin) {
        //233333
//        self.headerView.nameLabel.text = ;
//        self.headerView.signatureLabel.text = ;
//        self.headerView.iconImageView = ;
    }
    return self.headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.countArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.countArr[section] integerValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWPersonTableViewCell * personCell = [tableView dequeueReusableCellWithIdentifier:PERSONCCELL forIndexPath:indexPath];
    
    
    return personCell;
}


@end
