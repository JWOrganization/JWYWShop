//
//  JWTools.h
//  JW百思
//
//  Created by scjy on 16/3/21.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface JWTools : NSObject
/**
 *  通过文字来计算文字所占的区域大小
 *
 *  @param label Label
 *
 *  @return 文字所占的区域大小
 */
+ (CGFloat)labelHeightWithLabel:(UILabel *)label;

/**
 *  实现数组的排序功能
 *
 *  @param arr 将要被排序的数组
 *
 *  @param des 是升序还是降序，如果是降序为YES，反之为升序
 *
 *  @return 返回排序之后的数组
 */
+ (id)sortWithArray:(NSArray *)arr des:(BOOL)des;

/**
 *  通过文字来计算文字所占的区域大小
 *
 *  @param text 文字
 *  @param font 字体大小
 *  @param size 控件最大大小
 *
 *  @return 文字所占的区域大小
 */
+ (CGSize)sizeForText:(NSString *)text withFont:(UIFont *)font withSize:(CGSize)size;

/**
 *  通过文字来计算文字所占的区域大小
 *
 *  @param label Label
 *
 *  @return 文字所占的区域大小
 */
+ (CGFloat)labelHeightWithLabel:(UILabel *)label withWidth:(CGFloat)width;

/**
 *  通过文字来计算文字所占的区域大小
 *
 *  @param label Label
 *
 *  @return 文字所占的区域大小
 */
+ (CGFloat)labelWidthWithLabel:(UILabel *)label;

/**
 *  通过文字来计算文字所占的区域大小
 *
 *  @param label Label
 *
 *  @return 文字所占的区域大小
 */
+ (CGFloat)labelWidthWithLabel:(UILabel *)label withHeight:(CGFloat)height;

#pragma mark - FileRead
/**
 *  根据文件名获取本地Json文件
 *
 *  @param fileName 文件名
 *
 *  @return Json字典
 */
+ (NSDictionary *)jsonWithFileName:(NSString *)fileName;

#pragma mark - FilePath

/**
 *  获取文件路径
 *
 *  @param fileName 文件名
 *  @param type     文件类型
 *
 *  @return 文件路径
 */
+ (NSString *)filePathWithFileName:(NSString *)fileName ofType:(NSString *)type;
/**
 *  获取文件路径
 *
 *  @param fileName 文件名
 *
 *  @return 文件路径
 */
+ (NSString *)filePathWithFileName:(NSString *)fileName;
/**
 *  通过文件名获取文本文件内容
 *
 *  @param fileName 文件名
 *
 *  @return 文件
 */
+ (NSString *)fileWithFileName:(NSString *)fileName;
/**
 *  通过文件名获取文件内容
 *
 *  @param fileName Array文件名
 *
 *  @return Array文件
 */
+ (NSArray *)contentArrayForFileName:(NSString *)fileName;
/**
 *  通过文件名获取文件内容
 *
 *  @param fileName Dictionary文件名
 *
 *  @return Dictionary文件
 */
+ (NSDictionary *)contentDictForFileName:(NSString *)fileName;

/**
 *  保存图片到本地
 *
 *  @param image 图片
 *
 *  @return 存储地址
 */
+ (NSString *)saveJImage:(UIImage *)image;

#pragma mark - NSDate
/**
 *  传一个日期字符串，判断是否是昨天，或者是今天的日期
 *
 *  @param dateStr 日期字符串
 *
 *  @return 修改完的日期字符串
 */
+ (NSString *)dateStr:(NSString *)dateStr;

/**
 *  传一个日期字符串，判断是否是昨天，或者是多少小时、分钟前
 *
 *  @param dateStr 日期字符串
 *
 *  @return 修改完的日期字符串
 */
+ (NSString *)dateWithStr:(NSString *)dateStr;

/**
 *  传一个日期字符串，判断是否是今天(无年)
 *
 *  @param dateStr 日期字符串
 *
 *  @return 修改完的日期字符串
 */
+ (NSString *)dateWithOutYearStr:(NSString *)dateStr;

/**
 *  传一个日期字符串，判断是否是今天(无年)
 *
 *  @param dateStr 日期字符串
 *
 *  @return 修改完的日期字符串
 */
+ (NSString *)dateWithOutYearDate:(NSDate *)date;

#pragma mark - Json
/**
 *  单个数组组成Json文件
 *
 *  @param key 接口关键字
 *  @param arr 接口数组
 *
 *  @return json字符串
 */
+ (NSString *)jsonStrWithKey:(NSString *)key withArr:(NSArray *)arr;
/**
 *  单个数组组成Json文件
 *
 *  @param key 接口关键字
 *  @param arr 接口数组
 *
 *  @return json字符串
 */
+ (NSString *)jsonStrWithArr:(NSArray *)arr;

/**
 *  字符串组成UTF8文件
 *
 *  @param key 接口关键字
 *  @param arr 接口数组
 *
 *  @return json字符串
 */
+ (NSString *)UTF8WithStringJW:(NSString *)str;
/**
 *  字符串解析UTF8
 *
 *  @param UTF8String UTF8
 *
 *  @return 字符串
 */
+ (NSString *)stringWithUTF8JW:(NSString *)UTF8String;

#pragma mark - RegEx
/**
 *  密码长度至少6
 *
 *  @param password 密码
 *
 *  @return 密码长度是否大于等于6
 */
+ (BOOL)isRightPassWordWithStr:(NSString *)password;
/**
 *  纯数字验证码
 *
 *  @param comfireCode 验证码
 *
 *  @return 验证码纯数字
 */
+ (BOOL)isComfireCodeWithStr:(NSString *)comfireCode;
/**
 *  邮箱验证
 *
 *  @param email 邮箱
 *
 *  @return 是否是邮箱
 */
+ (BOOL)isEmailWithStr:(NSString *)email;
/**
 *  验证手机号
 *
 *  @param phoneNumber 手机号
 *
 *  @return 是否是手机号
 */
+ (BOOL)isPhoneIDWithStr:(NSString *)phoneNumber;
/**
 *  验证国内手机号
 *
 *  @param telNumber 手机号
 *
 *  @return 是否是手机号
 */
+ (BOOL)checkTelNumber:(NSString*)telNumber;

/**
 *  判断是否含表情字符串
 *
 *  @param string 字符串
 *
 *  @return 是否含有
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

#pragma mark - NSString
/**
 *  数字时间转格式时间
 *
 *  @param number 数字时间,如:123456789
 *
 *  @return 格式时间,如:2016-01-01
 */
+ (NSString *)stringNumberTurnToDateWithNumber:(NSString *)number;

/**
 *  获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
 *
 *  @param str 传入汉字字符串
 *
 *  @return 获取首字母
 */
+ (NSString *)stringWithFirstCharactor:(NSString *)str;

/**
 *  32进制转10进制
 *
 *  @param str 32进制str
 *
 *  @return 10进制
 */
+ (NSString *)stringWithNumberThirtyTwoBase:(NSString *)str;

/**
 *  10进制转32进制
 *
 *  @param str 10进制str
 *
 *  @return 32进制
 */
+ (NSString *)stringThirtyTwoWithNumberTenBase:(NSString *)numberStr;

#pragma mark - QR Code 二维码
/**
 *  创建二维码
 *  @param QRStr 二维码链接
 */
+ (UIImage *)makeQRCodeWithStr:(NSString *)QRStr;

#pragma mark - 图片转Str
/**
 *  图片转Str
 *
 *  @param image 图片
 *
 *  @return 图片转Str
 */
+ (NSString *)imageToStr:(UIImage *)image;

#pragma mark - 图片大小
/**
 *  图片适应屏幕大小
 *
 *  @param image  图片
 *  @param height 适应高度
 *  @param width  适应宽度
 *
 *  @return 图片大小
 */
+ (CGSize)getScaleImageSizeWithImageView:(UIImage *)image withHeight:(CGFloat)height withWidth:(CGFloat)width;

#pragma mark - 图片压缩
/**
 *  图片压缩到指定大小
 *
 *  @param image      图片
 *  @param targetSize 大小
 *
 *  @return 压缩后图片
 */
+ (UIImage*)imageByScalingAndCropping:(UIImage *)image ForSize:(CGSize)targetSize;


/**
 *  微信分享图片32K限制
 *
 *  @param imageUrl 图片URL
 *
 *  @return 压缩后图片
 */
+ (UIImage *)zipImageWithImage:(UIImage *)image;

#pragma mark - 图片滤镜
/**
 *  图片加滤镜
 *
 *  @param image      修改图片
 *  @param filterName 滤镜效果名称
 *
 *  @return 修改后图片
 */
+ (UIImage*)filteredImage:(UIImage*)image withFilterName:(NSString*)filterName;

/**
 *  滤镜效果数组
 *
 *  @return 滤镜效果数组
 */
+ (NSArray *)imageFilterArr;

#pragma mark - UUID
/**
 *  获取UUDID
 *
 *  @return 获取UUDID
 */
+ (NSString *)getUUID;


/**
 时间戳
 
 */
+(NSString*)getTime:(NSString*)number;


/*
 * 加上loading图
 
 */
+(UIView*)addLoadingViewWithframe:(CGRect)frame;

/*
 *移除loading图
 */
+(void)removeLoadingView:(UIView*)view;

/*
 *显示
 */
+(UIView*)addFailViewWithFrame:(CGRect)frame withTouchBlock:(void(^)())touchBlock;

@end
