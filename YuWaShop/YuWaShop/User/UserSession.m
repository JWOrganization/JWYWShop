//
//  UserSession.m
//  NewVipxox
//
//  Created by 黄佳峰 on 16/8/31.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "UserSession.h"
#import "HttpObject.h"
#import "JPUSHService.h"
#import "JWTools.h"
#import "VIPTabBarController.h"
#import "YWHomeViewController.h"
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
        [[EMClient sharedClient].options setIsAutoLogin:NO];
        
        EMError *error = [[EMClient sharedClient] logout:YES];
        if (!error)MyLog(@"环信退出成功");
        
        [UserSession getDataFromUserDefault];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [JPUSHService setAlias:@"" callbackSelector:nil object:nil];
        });
        
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
        if ([accountDefault isEqualToString:@""]){
            [UserSession isLogion];
            return;
        }
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            EMError *errorLog = [[EMClient sharedClient] loginWithUsername:user.account password:user.hxPassword];
            if (!errorLog){
                [[EMClient sharedClient].options setIsAutoLogin:NO];
                [[EMClient sharedClient].chatManager getAllConversations];
                MyLog(@"环信登录成功");
            }
            
            [JPUSHService setAlias:user.account callbackSelector:nil object:nil];
        });
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
    [UserSession userShoperSalePhone];//商户信息
    
    user.password = dataDic[@"password"];
    [KUSERDEFAULT setValue:user.password forKey:AUTOLOGINCODE];
    user.nickName = dataDic[@"nickname"];
    user.birthDay = dataDic[@"birthday"];
    user.hxPassword = dataDic[@"mobile"];
    user.local = dataDic[@"address"];
    
    NSArray * SexArr = @[@"男",@"女",@"未知"];
    NSNumber* sexNum=dataDic[@"sex"];
    NSInteger sexInt=[sexNum integerValue];
    if (sexInt>0&&sexInt<=3)user.sex = [NSString stringWithFormat:@"%@",SexArr[sexInt-1]];
    
    user.money = dataDic[@"money"];
    user.inviteID = dataDic[@"invite_uid"];
    user.logo = dataDic[@"header_img"];
    user.personality = dataDic[@"mark"];
    user.aldumCount = dataDic[@"aldumcount"];
    user.collected = dataDic[@"collected"];
    user.praised = dataDic[@"praised"];
    user.attentionCount = dataDic[@"attentioncount"];
    user.fans = dataDic[@"fans"];
    user.isVIP = [dataDic[@"user_type"] integerValue];
    user.last_login_time = dataDic[@"last_login_time"];
    user.status = dataDic[@"status"];
    user.reg_time = dataDic[@"reg_time"];
    user.sale_id = dataDic[@"sale_id"];
    user.email = dataDic[@"email"];
    user.baobaoLV = [dataDic[@"level"] integerValue];
    user.baobaoEXP = [dataDic[@"energy"] integerValue];
    NSInteger needExp = [dataDic[@"update_level_energy"] integerValue];
    user.baobaoNeedEXP = needExp?needExp>0?needExp:13500:13500;
    
    user.note_nums=dataDic[@"note_nums"];
    user.album_nums=dataDic[@"album_nums"];
    user.comment_nums=dataDic[@"comment_nums"];
    user.today_money=dataDic[@"today_money"];
    
    
    user.isLogin = YES;
    
    NSString * isNewNoticafication = [KUSERDEFAULT valueForKey:IS_NEW_NOTICAFICATION];
    if (isNewNoticafication&&[isNewNoticafication isEqualToString:@"1"]) {
        user.isNewNoticafication = YES;
        [UserSession refreshNoticaficationWithIsNewNoticafication:YES];
    }
    
    //233333333暂定
    user.comfired_Status = 2;//实名认证,user.isVIP=3时成功
    user.serventPhone = @"18015885220";
    user.phone = @"18015885220";
    user.cut = 80;
    user.shopType = @"美食";
    user.shopSubTypeArr = @[@"火锅",@"生日蛋糕",@"自助餐",@"西餐"];
    user.shopTypeID = @"24";
    user.shopSubTypeIDArr = @[@"44",@"45",@"47",@"50"];
    //233333333暂定
    [UserSession userToComfired];
}

+ (void)userShoperSalePhone{
    NSDictionary * pragram = @{@"device_id":[JWTools getUUID],@"token":user.token,@"user_id":@(user.uid)};
    
    [[HttpObject manager]postNoHudWithType:YuWaType_Shoper_ShopAdmin_GetSalePhone withPragram:pragram success:^(id responsObj) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code is %@",responsObj);
        user.phone = responsObj[@"data"][@"phone"];
    } failur:^(id responsObj, NSError *error) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code error is %@",responsObj);
    }]; //h333333333
}


+ (void)userToComfired{//233333333是否实名认证0未认证1认证中2认证完成
    if (user.isVIP ==3||user.comfired_Status == 2)return;
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
        }else if (user.isVIP != 3){
            [UserSession userToComfired];
        }
    });
}

+ (void)refreshNoticaficationWithIsNewNoticafication:(BOOL)isNewNoticafication{
    [KUSERDEFAULT setValue:[NSString stringWithFormat:@"%@",isNewNoticafication?@"1":@"0"] forKey:IS_NEW_NOTICAFICATION];
    user.isNewNoticafication = isNewNoticafication;
    VIPTabBarController * rootTabBarVC = (VIPTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    VIPNavigationController * navigationView = rootTabBarVC.viewControllers[0];
    if ([navigationView.viewControllers[0] isKindOfClass:[YWHomeViewController class]]) {
        YWHomeViewController * vc = (YWHomeViewController *)navigationView.viewControllers[0];
        [vc isNewNotification:isNewNoticafication];
    }
}

@end
