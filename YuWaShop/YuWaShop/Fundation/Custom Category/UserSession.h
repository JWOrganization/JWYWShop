//
//  UserSession.h
//  NewVipxox
//
//  Created by 黄佳峰 on 16/8/31.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSession : NSObject

@property (nonatomic,assign)NSInteger uid;//uid
@property (nonatomic,copy)NSString * token;   //用户登录后标识
@property (nonatomic,copy)NSString * account;  //账户
@property (nonatomic,copy)NSString * password;   //密码
@property (nonatomic,copy)NSString * inviteID;  //邀请ID

@property (nonatomic,copy)NSString * logo;//头像
@property (nonatomic,copy)NSString * nickName;//昵称
@property (nonatomic,copy)NSString * local;   //常驻地
@property (nonatomic,copy)NSString * personality;   //个人签名

@property (nonatomic,copy)NSString * money; //钱
@property (nonatomic,copy)NSString * last_login_time;
@property (nonatomic,copy)NSString * reg_time;
@property (nonatomic,copy)NSString * status;
@property (nonatomic,copy)NSString * sale_id;

@property (nonatomic,assign)NSInteger isVIP;//是否是会员 1普通用户2销售3商家

@property(nonatomic,assign)BOOL isLogin;   //是否登录
//233333333暂定
@property(nonatomic,assign)NSInteger comfired_Status;   //是否实名认证0未认证1认证中2认证完成
@property (nonatomic,copy)NSString * phone;
@property (nonatomic,copy)NSString * serventPhone;//客服电话
//233333333暂定


+ (UserSession*)instance;  //创建单例
+ (void)clearUser;   //退出登录 删除数据

+ (void)saveUserLoginWithAccount:(NSString *)account withPassword:(NSString *)password;  //save login data

+ (void)saveUserInfoWithDic:(NSDictionary *)dataDic;//save user data
+ (void)autoLoginRequestWithPragram:(NSDictionary *)pragram;

+ (void)userToComfired;

@end
