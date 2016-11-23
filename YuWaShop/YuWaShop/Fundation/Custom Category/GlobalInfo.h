//
//  GlobalInfo.h
//  NewVipxox
//
//  Created by 黄佳峰 on 16/8/30.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#ifndef GlobalInfo_h
#define GlobalInfo_h

#define HTTP_ADDRESS        @"http://114.215.252.104"    //地址

#pragma mark - Logion & Register
#define HTTP_REGISTER       @"/api.php/Login/reg/" //注册账号
#define HTTP_REGISTER_CODE   @"/api.php/Login/getRegisterCode/" //注册验证码
#define HTTP_LOGION_CODE   @"/api.php/Login/getRegisterCode/" //快捷登录验证码
#define HTTP_RESET_CODE   @"/api.php/Login/getRegisterCode/" //重置密码验证码
#define HTTP_LOGIN          @"/api.php/Login/login/" //登入
#define HTTP_LOGIN_Quick      @"/api.php/Login/phoneLogin/" //快捷登录
#define HTTP_LOGIN_FORGET_TEL @"/api.php/Login/resetPassword/" //找回密码

#pragma mark - Storm
#define HTTP_STORM_TAG @"/api.php/Shop/getTagNameByCid/" //子标签
#define HTTP_SHOP_GETCATEGORY     @"/api.php/Shop/getAllCatoryAndBusiness/"   //得到大分类和商圈

#pragma mark - IMG
#define HTTP_IMG_UP @"/api.php/Index/uploadImg/" //上传图片



#endif /* GlobalInfo_h */
