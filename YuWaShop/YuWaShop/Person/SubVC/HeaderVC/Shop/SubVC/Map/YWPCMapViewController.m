//
//  YWPCMapViewController.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPCMapViewController.h"
#import "YWStormAnnotationModel.h"
#import "YWStormPinAnnotationView.h"
#import <MapKit/MapKit.h>

@interface YWPCMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,assign)CLLocationCoordinate2D touchMapCoordinate;
@property (nonatomic,assign)BOOL isSearch;
@property (nonatomic,strong)CLGeocoder * geocoder;
@property (nonatomic,copy)NSString * locationStr;

@end

@implementation YWPCMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"门店地图";
    [self makeUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self pleaseSetMap];
}
- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (void)makeUI{
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(self.location.coordinate, 5000, 5000) animated:YES];//设置地图的默认显示区域
    UITapGestureRecognizer *mTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
    [self.mapView addGestureRecognizer:mTap];
}

- (void)pleaseSetMap{
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways &&[CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse && [CLLocationManager authorizationStatus] !=kCLAuthorizationStatusNotDetermined) {
        UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"暂不" style:UIAlertActionStyleDefault handler:nil];
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"定位服务未开启" message:@"请在系统设置中开启定位服务" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:cancelAction];
        [alertVC addAction:OKAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.touchMapCoordinate.latitude == 0.f) {
            self.touchMapCoordinate = self.location.coordinate;
            [self addAnnotationData];
        }
    });
}

- (IBAction)submitBtnAction:(id)sender {
    [self isSendLocation];
}

- (void)isSendLocation{
    UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self requestUpDateLocation];
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"确认上传?" message:[NSString stringWithFormat:@"选定位置:%@\n经纬度(%f,%f)",self.locationStr,self.touchMapCoordinate.latitude,self.touchMapCoordinate.longitude] preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:cancelAction];
    [alertVC addAction:OKAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)tapPress:(UIGestureRecognizer*)gestureRecognizer {
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];//这里touchPoint是点击的某点在地图控件中的位置
    self.touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    self.location.lat = self.touchMapCoordinate.latitude;
    [YWLocation saveLat:self.touchMapCoordinate.latitude];
    self.location.lon = self.touchMapCoordinate.longitude;
    [YWLocation saveLon:self.touchMapCoordinate.longitude];
    [self addAnnotationData];
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocation * location = [[CLLocation alloc]initWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
    if (!self.isSearch) {
        self.touchMapCoordinate = location.coordinate;
        [self addAnnotationData];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(nonnull id<MKAnnotation>)annotation{
    YWStormPinAnnotationView * annotationView = (YWStormPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"STORM_PINANNOTATION"];
    if (!annotationView)annotationView = [[YWStormPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"STORM_PINANNOTATION"];
    
    annotationView.model = (YWStormAnnotationModel *)annotation;
    return annotationView;
}

- (void)addAnnotationData{
    WEAKSELF;
    [self.mapView removeAnnotations:self.mapView.annotations];
    if (!self.isSearch) {
        self.mapView.showsUserLocation = NO;
        self.isSearch = YES;
    }
    YWStormAnnotationModel * model = [[YWStormAnnotationModel alloc]init];
    model.coordinate = self.touchMapCoordinate;//纬经度
    [self.mapView addAnnotation:model];
    
    CLLocation * location = [[CLLocation alloc]initWithLatitude:self.touchMapCoordinate.latitude longitude:self.touchMapCoordinate.longitude];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull placemark, NSUInteger idx, BOOL * _Nonnull stop) {
            weakSelf.locationStr = [NSString stringWithFormat:@"%@",(placemark.name?placemark.name:@"泉州市")];
        }];
    }];
}

#pragma mark - Http
- (void)requestUpDateLocation{
    //h3333333333333上传当前位置,经纬度
}

@end
