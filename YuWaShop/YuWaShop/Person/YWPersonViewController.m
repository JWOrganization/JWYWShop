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

@interface YWPersonViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)YWPersonHeaderView * headerView;
@property (nonatomic,strong)NSArray * countArr;
@property (nonatomic,strong)NSMutableArray * showArr;
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
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:@"Person_13" withSelectImage:@"Person_13" withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTarget:self action:@selector(settingBtnAction) forControlEvents:UIControlEventTouchUpInside withSize:CGSizeMake(30.f, 30.f)];
}

- (void)dataSet{
    self.showArr = [NSMutableArray arrayWithArray:@[@[@{@"name":@"经营日报",@"image":@"Person_12"},@{@"name":@"银行账户管理",@"image":@"Person_5"},@{@"name":@"结算周期管理",@"image":@"Person_9"}],@[@{@"name":@"联系商务会员",@"image":@"Person_3"},@{@"name":@"业务合作",@"image":@"Person_2"},@{@"name":@"帮助中心",@"image":@"Person_1"},@{@"name":@"商务热线",@"image":@"Person_0"},@{@"name":@"意见反馈",@"image":@"Person_10"}],@[@{@"name":@"设置",@"image":@"Person_11"}]]];
    for (int i = 0; i < self.showArr.count; i++) {
        NSMutableArray * showArrTemp = [NSMutableArray arrayWithArray:self.showArr[i]];
        for (int j = 0; j < showArrTemp.count; j++) {
            [showArrTemp replaceObjectAtIndex:j withObject:[YWPersonCenterModel yy_modelWithDictionary:showArrTemp[j]]];
        }
        [self.showArr replaceObjectAtIndex:i withObject:showArrTemp];
    }
    
    self.countArr = @[@0,@([self.showArr[0] count]),@([self.showArr[1] count]),@([self.showArr[2] count])];
    
    [self.tableView registerNib:[UINib nibWithNibName:PERSONCCELL bundle:nil] forCellReuseIdentifier:PERSONCCELL];
}

- (void)makeLocalImagePicker{
    WEAKSELF;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {//take photo
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [weakSelf myImagePickerWithType:UIImagePickerControllerSourceTypeCamera];
        } else {
            MyLog(@"照片源不可用");
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {//to localPhotos
        [weakSelf myImagePickerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)myImagePickerWithType:(UIImagePickerControllerSourceType)sourceType{
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        [picker setSourceType:sourceType];
        [picker setAllowsEditing:YES];
        [picker setDelegate:self];
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        MyLog(@"照片源不可用");
    }
}

#pragma mark - ImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.cameraImage = info[@"UIImagePickerControllerEditedImage"];
    self.headerView.iconImageView.image = self.cameraImage;
    [self requestChangeIcon];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - BtnAction
- (void)settingBtnAction{
    
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
    personCell.model = self.showArr[indexPath.section - 1][indexPath.row];
    
    return personCell;
}

#pragma mark - Http
- (void)requestChangeIcon{
    //h33333333333上传头像
}


@end
