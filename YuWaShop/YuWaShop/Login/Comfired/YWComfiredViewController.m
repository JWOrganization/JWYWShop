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
#import "JWTagsCollectionView.h"
#import "YWStormSortTableView.h"
#import "YWStormSubSortCollectionView.h"
#import "YWAddressSortTableView.h"
#import "YWAddressSubSortCollectionView.h"
#import "YWComfiringViewController.h"
#import "JPUSHService.h"

#import <CoreLocation/CoreLocation.h>

@interface YWComfiredViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *upImageBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (nonatomic,assign)BOOL isAgree;
@property (nonatomic,strong)UIImage * cameraImage;
@property (nonatomic,copy)NSString * cameraImageURL;

@property (weak, nonatomic) IBOutlet UIView *chooseTagBGView;

@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@property (nonatomic,strong)YWStormSortTableView * sortTableView;
@property (nonatomic,strong)YWStormSubSortCollectionView * sortSubCollectionView;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,strong)NSMutableArray * tagIDArr;
@property (nonatomic,strong)JWTagsCollectionView * tagCollectionView;

@property (nonatomic,strong)YWAddressSortTableView * sortAddressTableView;
@property (nonatomic,strong)YWAddressSubSortCollectionView * sortAddressSubCollectionView;
@property (nonatomic,assign)NSInteger addressType;
@property (nonatomic,assign)NSInteger addressSubType;
@property (nonatomic,copy)NSString * addressName;
@property (nonatomic,copy)NSString * addressSubName;

@property (nonatomic,strong)CLGeocoder * geocoder;
@property (nonatomic,copy)NSString * latitudeStr;
@property (nonatomic,copy)NSString * longitudeStr;

@end

@implementation YWComfiredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavi];
    [self makeUI];
}
- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (void)makeNavi{
    self.title = @"商务会员签约";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTittle:@"退出登录" withTittleColor:[UIColor whiteColor] withTarget:self action:@selector(outLogion) forControlEvents:UIControlEventTouchUpInside withWidth:60.f];
    self.type = 1;
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
    
    [self addLineWithUI:self.idTextField];
    [self addLineWithUI:self.nameTextField];
    [self addLineWithUI:self.addressTextField];
    [self addLineWithUI:self.addressLabel];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAddressAction)];
    [self.addressLabel addGestureRecognizer:tap];
    
    self.tagIDArr = [NSMutableArray arrayWithCapacity:0];
    
    [self makeSortView];
    [self makeAddressSortView];
}

- (void)makeSortView{
    WEAKSELF;
    UICollectionViewFlowLayout * collectionFlow = [[UICollectionViewFlowLayout alloc]init];
    collectionFlow.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sortSubCollectionView = [[YWStormSubSortCollectionView alloc]initWithFrame:CGRectMake(kScreen_Width/3, NavigationHeight, kScreen_Width * 2/3, kScreen_Height - 64.f) collectionViewLayout:collectionFlow];
    [self.sortSubCollectionView dataSet];
    
    self.sortTableView = [[YWStormSortTableView alloc]initWithFrame:CGRectMake(0.f, NavigationHeight, kScreen_Width/3, self.sortSubCollectionView.height) style:UITableViewStylePlain];
    self.sortTableView.choosedTypeBlock = ^(NSInteger type,NSInteger subType,NSArray * subArr){
        weakSelf.type = type+1;
        weakSelf.sortSubCollectionView.allTypeIdx = type;
        weakSelf.sortSubCollectionView.dataArr = subArr;
    };
    self.sortTableView.hidden = YES;
    self.sortSubCollectionView.hidden = self.sortTableView.hidden;
    [self.view addSubview:self.sortTableView];
    [self.view addSubview:self.sortSubCollectionView];
}

- (void)makeAddressSortView{
    WEAKSELF;
    UICollectionViewFlowLayout * collectionAddressFlow = [[UICollectionViewFlowLayout alloc]init];
    collectionAddressFlow.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sortAddressSubCollectionView = [[YWAddressSubSortCollectionView alloc]initWithFrame:CGRectMake(kScreen_Width/3, NavigationHeight, kScreen_Width * 2/3, kScreen_Height - 64.f) collectionViewLayout:collectionAddressFlow];
    self.sortAddressSubCollectionView.choosedTypeBlock = ^(NSString * placeNmae,NSInteger subType){
        weakSelf.addressSubType = subType;
        weakSelf.sortAddressTableView.hidden = YES;
        weakSelf.sortAddressSubCollectionView.hidden = weakSelf.sortAddressTableView.hidden;
        weakSelf.addressSubName = placeNmae;
        weakSelf.addressLabel.textColor = [UIColor blackColor];
        weakSelf.addressLabel.text = [NSString stringWithFormat:@"%@/%@",weakSelf.addressName,placeNmae];
    };
    [self.sortAddressSubCollectionView dataSet];
    
    self.sortAddressTableView = [[YWAddressSortTableView alloc]initAddressWithFrame:CGRectMake(0.f, NavigationHeight, kScreen_Width/3, self.sortAddressSubCollectionView.height) style:UITableViewStylePlain];
    self.sortAddressTableView.choosedTypeBlock = ^(NSInteger type,NSString * name,NSArray * subArr){
        weakSelf.addressType = type;
        weakSelf.sortAddressSubCollectionView.allTypeIdx = type;
        weakSelf.sortAddressSubCollectionView.dataArr = subArr;
        weakSelf.addressName = name;
    };
    self.sortAddressTableView.hidden = YES;
    self.sortAddressSubCollectionView.hidden = self.sortAddressTableView.hidden;
    [self.view addSubview:self.sortAddressTableView];
    [self.view addSubview:self.sortAddressSubCollectionView];
}

- (void)addLineWithUI:(UIView *)sender{
    sender.layer.borderWidth = 1.f;
    sender.layer.borderColor = [UIColor colorWithHexString:@"#D6D6D6"].CGColor;
    sender.layer.cornerRadius = 5.f;
    sender.layer.masksToBounds = YES;
}

#pragma mark - Button Action
- (IBAction)submitBtnAction:(id)sender {
    [self requestComfired];
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
//    if (self.sortSubCollectionView.choosedTypeArr.count<=0)return;
    NSMutableArray * tagArr = [NSMutableArray arrayWithCapacity:0];
    [self.tagIDArr removeAllObjects];
    for (YWComfiredTypeModel * model in self.sortSubCollectionView.choosedTypeArr) {
        [tagArr addObject:model.tag_name];
        [self.tagIDArr addObject:model.typeID];
    }
    [self makeTagCollectionViewWithArr:tagArr];
}

- (void)chooseAddressAction{
    self.sortAddressTableView.hidden = NO;
    self.sortAddressSubCollectionView.hidden = self.sortAddressTableView.hidden;
}

- (void)makeTagCollectionViewWithArr:(NSArray *)tagArr{
    UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    if (!self.tagCollectionView) {
        self.tagCollectionView = [[JWTagsCollectionView alloc]initWithFrame:CGRectMake(0.f, 5.f, kScreen_Width-90.f, 30.f) collectionViewLayout:flowLayout];
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
    NSDictionary * pragram = @{@"img":@"img"};
    
    [[HttpObject manager]postPhotoWithType:YuWaType_IMG_UP withPragram:pragram success:^(id responsObj) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code is %@",responsObj);
        self.cameraImageURL = responsObj[@"data"];
        if (!self.cameraImageURL)self.cameraImageURL=@"";
        [self requestUpComfired];
    } failur:^(id errorData, NSError *error) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code error is %@",error);
    } withPhoto:UIImagePNGRepresentation(self.cameraImage)];//h3333333333333
}
- (void)requestComfired{
    if ([self.idTextField.text isEqualToString:@""]) {
        [self showHUDWithStr:@"请输入邀请人ID" withSuccess:NO];
        return;
    }else if ([self.nameTextField.text isEqualToString:@""]) {
        [self showHUDWithStr:@"请输入店铺名称" withSuccess:NO];
        return;
    }else if ([self.addressTextField.text isEqualToString:@""]) {
        [self showHUDWithStr:@"请输入店铺地址" withSuccess:NO];
        return;
    }else if (self.tagIDArr.count<=0) {
        [self showHUDWithStr:@"请选择所属分类" withSuccess:NO];
        return;
    }else if ([self.addressLabel.text isEqualToString:@"店铺商区"]) {
        [self showHUDWithStr:@"请选择商区" withSuccess:NO];
        return;
    }else if (self.tagIDArr.count<=0) {
        [self showHUDWithStr:@"请选择店铺分类" withSuccess:NO];
        return;
    }else if (!self.cameraImage) {
        [self showHUDWithStr:@"请上传营业执照" withSuccess:NO];
        return;
    }else if (!self.isAgree){
        [self showHUDWithStr:@"请阅读协议并同意" withSuccess:NO];
        return;
    }
    
    [self.geocoder geocodeAddressString:self.addressTextField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark * pl = [placemarks firstObject];
        if(!error){
            self.latitudeStr = @(pl.location.coordinate.latitude).stringValue;
            self.longitudeStr = @(pl.location.coordinate.longitude).stringValue;
            [self requestChangeIcon];
        }else{
            [self showHUDWithStr:@"地址有误,请重试" withSuccess:NO];
        }
    }];
}

- (void)requestUpComfired{
    //h3333333333提交审核
  
    //self.idTextField.text
    //self.nameTextField.text
    
    NSString * subTagIDStr = self.tagIDArr[0];
    for (int i = 1; i<self.tagIDArr.count; i++) {
        subTagIDStr = [NSString stringWithFormat:@"%@,%@",subTagIDStr,self.tagIDArr[i]];
    }
    /*
     device_id
     token
     user_id
     
     business_licence
     company_address
     cidtag_id
     coordinatex
     coordinatey
     company_near*/
    NSDictionary * pragram = @{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([UserSession instance].uid),@"business_licence":self.cameraImageURL,@"company_address":self.addressTextField.text,@"cid":@(self.type),@"tag_id":subTagIDStr,@"coordinatey":self.latitudeStr,@"coordinatex":self.longitudeStr,@"company_near":@(self.addressSubType)};//,@"":,@"":,@"":,@"":
    
    [[HttpObject manager]postDataWithType:YuWaType_Shoper_ShopAdmin_AddCheckStatus withPragram:pragram success:^(id responsObj) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code is %@",responsObj);
        YWComfiringViewController * vc = [[YWComfiringViewController alloc]init];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [JPUSHService setAlias:[UserSession instance].account callbackSelector:nil object:nil];
            [self.navigationController pushViewController:vc animated:YES];
        });
    } failur:^(id responsObj, NSError *error) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code error is %@",responsObj);
        [self showHUDWithStr:@"提交失败,请重试" withSuccess:NO];
    }]; //h333333333   
}


@end
