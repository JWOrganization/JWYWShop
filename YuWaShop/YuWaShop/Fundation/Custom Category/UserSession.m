//
//  UserSession.m
//  NewVipxox
//
//  Created by 黄佳峰 on 16/8/31.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "UserSession.h"
#import "HttpObject.h"
#import "JWTools.h"
#import "VIPTabBarController.h"
#import "VIPNavigationController.h"
#import "YWComfiredViewController.h"
#import "YWComfiringViewController.h"
#import "YWLoginViewController.h"

@implementation UserSession
static UserSession * user=nil;

+ (UserSession*)instance{
    if (!user) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            user=[[UserSession alloc]init];
        });
        user.token=@"";
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [UserSession getDataFromUserDefault];
        });
    }
    
    return user;
}


+ (void)clearUser{
    [UserSession saveUserLoginWithAccount:@"" withPassword:@""];
    user = nil;
    user=[[UserSession alloc]init];
    user.token=@"";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [UserSession getDataFromUserDefault];
        
        NSMutableArray * friendsRequest = [NSMutableArray arrayWithArray:[KUSERDEFAULT valueForKey:FRIENDSREQUEST]];
        friendsRequest = [NSMutableArray arrayWithCapacity:0];
        [KUSERDEFAULT setObject:friendsRequest forKey:FRIENDSREQUEST];
    });
}

+ (void)saveUserLoginWithAccount:(NSString *)account withPassword:(NSString *)password{
    user.account = account;
    [KUSERDEFAULT setValue:account forKey:AUTOLOGIN];
    user.password = password;
    [KUSERDEFAULT setValue:password forKey:AUTOLOGINCODE];
}

//get local saved data
+ (void)getDataFromUserDefault{
    NSString * accountDefault = [KUSERDEFAULT valueForKey:AUTOLOGIN];
    if (accountDefault) {
        if ([accountDefault isEqualToString:@""])return;
        user.account = accountDefault;
        user.password = [KUSERDEFAULT valueForKey:AUTOLOGINCODE];
        [UserSession autoLoginRequestWithPragram:@{@"phone":user.account,@"password":user.password,@"is_md5":@1}];
    }else{
        [UserSession isLogion];
    }
}

//auto login
+ (void)autoLoginRequestWithPragram:(NSDictionary *)pragram{
    [[HttpObject manager]postNoHudWithType:YuWaType_Logion withPragram:pragram success:^(id responsObj) {
        MyLog(@"Pragram is %@",pragram);
        MyLog(@"Data is %@",responsObj);
        [UserSession saveUserInfoWithDic:responsObj[@"data"]];
    } failur:^(id responsObj, NSError *error) {
        MyLog(@"Pragram is %@",pragram);
        MyLog(@"Data Error error is %@",responsObj);
        MyLog(@"Error is %@",error);
        [UserSession isLogion];
    }];
}

//解析登录返回数据
+ (void)saveUserInfoWithDic:(NSDictionary *)dataDic{
    user.token = dataDic[@"token"];
    user.uid = [dataDic[@"id"] integerValue];
    user.password = dataDic[@"password"];
    [KUSERDEFAULT setValue:user.password forKey:AUTOLOGINCODE];
    
    user.isLogin = YES;
    user.comfired_Status = 2;//2333333333实名认证
    [UserSession userToComfired];
}

+ (void)userToComfired{//233333333是否实名认证0未认证1认证中2认证完成
    if (user.comfired_Status == 2)return;
    VIPTabBarController * rootTabBarVC = (VIPTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController * vc;
    if (user.comfired_Status == 0) {
        vc = [[YWComfiredViewController alloc]init];
    }else if (user.comfired_Status == 1){
        vc = [[YWComfiringViewController alloc]init];
    }
    [rootTabBarVC.selectedViewController pushViewController:vc animated:YES];
}

+ (void)isLogion{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!user.isLogin) {
            VIPTabBarController * rootTabBarVC = (VIPTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            YWLoginViewController * vc = [[YWLoginViewController alloc]init];
            [rootTabBarVC.selectedViewController pushViewController:vc animated:NO];
        }else if (user.comfired_Status != 2){//2333333未审核||审核中
            [UserSession userToComfired];
        }
    });
}

@end
