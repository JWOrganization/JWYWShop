//
//  YWComfiredViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/22.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWComfiredViewController.h"
#import "YWLoginViewController.h"
#import "YWComfiredAgreeViewController.h"
#import "JWTagCollectionView.h"
#import "YWStormSortTableView.h"
#import "YWStormSubSortCollectionView.h"

@interface YWComfiredViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *upImageBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (nonatomic,assign)BOOL isAgree;
@property (nonatomic,strong)UIImage * cameraImage;
@property (weak, nonatomic) IBOutlet UIView *chooseTagBGView;
@property (nonatomic,strong)JWTagCollectionView * tagCollectionView;
@property (nonatomic,strong)NSMutableArray * tagIDArr;



@property (nonatomic,strong)YWStormSortTableView * sortTableView;
@property (nonatomic,strong)YWStormSubSortCollectionView * sortSubCollectionView;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,assign)NSInteger subType;

@end

@implementation YWComfiredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavi];
    [self makeUI];
}
- (void)makeNavi{
    self.title = @"商务会员签约";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTittle:@"退出登录" withTittleColor:[UIColor whiteColor] withTarget:self action:@selector(outLogion) forControlEvents:UIControlEventTouchUpInside withWidth:60.f];
}

- (void)outLogion{
    [UserSession clearUser];
    YWLoginViewController * vc = [[YWLoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)makeUI{
    self.isAgree = YES;
    [self.upImageBtn setBackgroundImage:[JWTools imageWithSize:CGSizeMake(170.f, 50.f) borderColor:[UIColor lightGrayColor] borderWidth:4.f withCornerRadius:5.f] forState:UIControlStateNormal];
    self.submitBtn.layer.cornerRadius = 5.f;
    self.submitBtn.layer.masksToBounds = YES;
    
    self.tagIDArr = [NSMutableArray arrayWithCapacity:0];
    
    WEAKSELF;
    UICollectionViewFlowLayout * collectionFlow = [[UICollectionViewFlowLayout alloc]init];
    collectionFlow.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sortSubCollectionView = [[YWStormSubSortCollectionView alloc]initWithFrame:CGRectMake(kScreen_Width/3, NavigationHeight, kScreen_Width * 2/3, kScreen_Height - 64.f) collectionViewLayout:collectionFlow];
    [self.sortSubCollectionView dataSet];
    
    self.sortTableView = [[YWStormSortTableView alloc]initWithFrame:CGRectMake(0.f, NavigationHeight, kScreen_Width/3, self.sortSubCollectionView.height) style:UITableViewStylePlain];
    self.sortTableView.choosedTypeBlock = ^(NSInteger type,NSInteger subType,NSArray * subArr){
        weakSelf.type = type;
        weakSelf.sortSubCollectionView.allTypeIdx = type;
        weakSelf.sortSubCollectionView.dataArr = subArr;
    };
    self.sortTableView.hidden = YES;
    self.sortSubCollectionView.hidden = self.sortTableView.hidden;
    [self.view addSubview:self.sortTableView];
    [self.view addSubview:self.sortSubCollectionView];
}

#pragma mark - Button Action
- (IBAction)submitBtnAction:(id)sender {
}
- (IBAction)upImageBtnAction:(UIButton *)sender {
    [self makeLocalImagePicker];
}
- (IBAction)agreeBtnAction:(UIButton *)sender {
    self.isAgree = !self.isAgree;
    [sender setImage:[UIImage imageNamed:self.isAgree?@"photo_sel_photoPickerVc":@"photo_def_previewVc"] forState:UIControlStateNormal];
}
- (IBAction)seeAgreeBtnAction:(id)sender {
    YWComfiredAgreeViewController * vc = [[YWComfiredAgreeViewController alloc]init];
    vc.agreeBlock = ^(){
        self.isAgree = YES;
        [self.agreeBtn setImage:[UIImage imageNamed:@"photo_sel_photoPickerVc"] forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)chooseTagBtn:(id)sender {
    self.sortTableView.hidden = NO;
    self.sortSubCollectionView.hidden = self.sortTableView.hidden;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTittle:@"完成" withTittleColor:[UIColor whiteColor] withTarget:self action:@selector(tagChoosedFinish) forControlEvents:UIControlEventTouchUpInside withWidth:30.f];
}

- (void)tagChoosedFinish{
    self.navigationItem.rightBarButtonItem = nil;
    self.sortTableView.hidden = YES;
    self.sortSubCollectionView.hidden = self.sortTableView.hidden;
    NSMutableArray * tagArr = [NSMutableArray arrayWithCapacity:0];
    [self.tagIDArr removeAllObjects];
    for (YWComfiredTypeModel * model in self.sortSubCollectionView.choosedTypeArr) {
        [tagArr addObject:model.tag_name];
        [self.tagIDArr addObject:model.typeID];
    }
    [self makeTagCollectionViewWithArr:tagArr];
}

- (void)makeTagCollectionViewWithArr:(NSArray *)tagArr{
    UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    if (!self.tagCollectionView) {
        self.tagCollectionView = [[JWTagCollectionView alloc]initWithFrame:CGRectMake(0.f, 5.f, kScreen_Width-90.f, 30.f) collectionViewLayout:flowLayout];
        [self.chooseTagBGView addSubview:self.tagCollectionView];
    }
    self.tagCollectionView.tagArr = tagArr;
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
    [self.upImageBtn setImage:nil forState:UIControlStateNormal];
    [self.upImageBtn setTitle:@"" forState:UIControlStateNormal];
    [self.upImageBtn setBackgroundImage:self.cameraImage forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Http
- (void)requestChangeIcon{
    //h33333333333上传头像
}
- (void)requestComfired{
    //h3333333333提交审核
    [self requestChangeIcon];
//    self.type选择商务大类
//    self.tagIDArr 选择商务子类
}


@end
