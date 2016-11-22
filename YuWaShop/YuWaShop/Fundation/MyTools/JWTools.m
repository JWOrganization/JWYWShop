//
//  JWTools.m
//  JW百思
//
//  Created by scjy on 16/3/21.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWTools.h"
#import <CoreImage/CoreImage.h>

#import "HUDFailureShowView.h"

@implementation JWTools

/**
 *  实现数组的排序功能
 *
 *  @param arr 将要被排序的数组
 *
 *  @param des 是升序还是降序，如果是降序为YES，反之为升序
 *
 *  @return 返回排序之后的数组
 */
+ (id)sortWithArray:(NSArray *)arr des:(BOOL)des{
    
    NSMutableArray *resultArr = [arr mutableCopy];
    
    [resultArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if (des) {
            return obj1 > obj2;
        }else{
            return obj1 < obj2;
        }
        
    }];
    
    return [resultArr mutableCopy];
}

/**
 *  通过文字来计算文字所占的区域大小
 *
 *  @param text 文字
 *  @param font 字体大小
 *  @param size 控件最大大小
 *
 *  @return 文字所占的区域大小
 */
+ (CGSize)sizeForText:(NSString *)text withFont:(UIFont *)font withSize:(CGSize)size{
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    
    //通过文字来获取文字所占的大小
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rect.size;
}
/**
 *  通过文字来计算文字所占的区域大小
 *
 *  @param label Label
 *
 *  @return 文字所占的区域大小
 */
+ (CGFloat)labelHeightWithLabel:(UILabel *)label{
    NSDictionary * attributes = @{NSFontAttributeName:label.font};
    CGRect conRect = [label.text boundingRectWithSize:CGSizeMake(label.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    return conRect.size.height + 5.f;
}
/**
 *  通过文字来计算文字所占的区域大小
 *
 *  @param label Label
 *
 *  @return 文字所占的区域大小
 */
+ (CGFloat)labelHeightWithLabel:(UILabel *)label withWidth:(CGFloat)width{
    NSDictionary * attributes = @{NSFontAttributeName:label.font};
    CGRect conRect = [label.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    return conRect.size.height;
}

/**
 *  通过文字来计算文字所占的区域大小
 *
 *  @param label Label
 *
 *  @return 文字所占的区域大小
 */
+ (CGFloat)labelWidthWithLabel:(UILabel *)label{
    NSDictionary * attributes = @{NSFontAttributeName:label.font};
    CGRect conRect = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT,label.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    return conRect.size.width + 5.f;
}
/**
 *  通过文字来计算文字所占的区域大小
 *
 *  @param label Label
 *
 *  @return 文字所占的区域大小
 */
+ (CGFloat)labelWidthWithLabel:(UILabel *)label withHeight:(CGFloat)height{
    NSDictionary * attributes = @{NSFontAttributeName:label.font};
    CGRect conRect = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT,height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    return conRect.size.width;
}

#pragma mark - FileRead
/**
 *  根据文件名获取本地Json文件
 *
 *  @param fileName 文件名
 *
 *  @return Json字典
 */
+ (NSDictionary *)jsonWithFileName:(NSString *)fileName{
    NSData * data = [[NSData alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fileName ofType:@"json"]];
    
    NSError*error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    return (NSDictionary *)jsonObject;
}


#pragma mark - FilePath

/**
 *  获取文件路径
 *
 *  @param fileName 文件名（需要类型）
 *
 *  @return 文件路径
 */
+ (NSString *)filePathWithFileName:(NSString *)fileName ofType:(NSString *)type{
    NSFileManager * fileManger = [NSFileManager defaultManager];
    
    NSArray * urlsArray = [fileManger URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL * pathURL = [urlsArray firstObject];
    NSString * path = [pathURL path];
    
    NSString * filePath;
    filePath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@.%@",fileName,type]];
    
    if (![fileManger fileExistsAtPath:filePath]) {
        [fileManger createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    return filePath;
}

/**
 *  获取文件路径
 *
 *  @param fileName 文件名
 *
 *  @return 文件路径
 */
+ (NSString *)filePathWithFileName:(NSString *)fileName{
    NSFileManager * fileManger = [NSFileManager defaultManager];
    
    NSArray * urlsArray = [fileManger URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL * pathURL = [urlsArray firstObject];
    NSString * path = [pathURL path];
    
    NSString * filePath;
    filePath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
    
    if (![fileManger fileExistsAtPath:filePath]) {
        [fileManger createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    return filePath;
}


/**
 *  通过文件名获取文本文件内容
 *
 *  @param fileName 文件名
 *
 *  @return 文件
 */
+ (NSString *)fileWithFileName:(NSString *)fileName{
    //获取数据所在的文件路径
    NSString *file = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    return file;
}


/**
 *  通过文件名获取文件内容
 *
 *  @param fileName Array文件名
 *
 *  @return Array文件
 */
+ (NSArray *)contentArrayForFileName:(NSString *)fileName{
    //将文件的内容转化为数组
    NSArray *dataArr = [NSArray arrayWithContentsOfFile:[self filePathWithFileName:fileName]];
    
    return dataArr;
}

/**
 *  通过文件名获取文件内容
 *
 *  @param fileName Dictionary文件名
 *
 *  @return Dictionary文件
 */
+ (NSDictionary *)contentDictForFileName:(NSString *)fileName{
    //将文件的内容转化为数组
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[self filePathWithFileName:fileName]];
    
    return dict;
}

/**
 *  保存图片到本地
 *
 *  @param image 图片
 *
 *  @return 存储地址
 */
+ (NSString *)saveJImage:(UIImage *)image{
    NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate * date = [NSDate date];
    dateFormatter.dateFormat = @"yyyyMMddHHmmss";
    NSString * imgPath = [NSString stringWithFormat:@"%@.png",[dateFormatter stringFromDate:date]];
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString * imagePath = [NSString stringWithFormat:@"%@/%@",docs[0],imgPath];
    [imageData writeToFile:imagePath atomically:YES];
    return imgPath;
}
#pragma mark - NSDate
/**
 *  传一个日期字符串，判断是否是昨天，或者是今天的日期
 *
 *  @param dateStr 日期字符串
 *
 *  @return 修改完的日期字符串
 */
+ (NSString *)dateStr:(NSString *)dateStr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:dateStr];

    //创建一个日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    if (!date) {
        date = [NSDate dateWithTimeIntervalSince1970:[dateStr doubleValue]];
    }
    
    if (!date) {
        return nil;
    }
    //通过日历对象，判断date是否是昨天的日期
    if ([calendar isDateInYesterday:date]) {
        dateFormatter.dateFormat = @"HH:mm:ss";
        return [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:date]];
    }
    //通过日历对象，判断date是否是今天的日期
    if ([calendar isDateInToday:date]) {
        dateFormatter.dateFormat = @"HH:mm:ss";
        return [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:date]];
    }
    
    dateFormatter.dateFormat = @"MM-dd HH:mm:ss";
    return [dateFormatter stringFromDate:date];
}

/**
 *  传一个日期字符串，判断是否是昨天，或者是多少小时、分钟前
 *
 *  @param dateStr 日期字符串
 *
 *  @return 修改完的日期字符串
 */
+ (NSString *)dateWithStr:(NSString *)dateStr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    //创建一个日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    if (!date) {
        date = [NSDate dateWithTimeIntervalSince1970:[dateStr doubleValue]];
    }
    
    if (!date) {
        return nil;
    }
    //通过日历对象，判断date是否是昨天的日期
    if ([calendar isDateInYesterday:date]) {
        dateFormatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:date]];
    }
    //通过日历对象，判断date是否是今天的日期
    if ([calendar isDateInToday:date]) {
        dateFormatter.dateFormat = @"HH";
        NSInteger time = [[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]] integerValue];
        NSInteger timeNow = [[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]] integerValue];
        if (timeNow - time == 1){
            dateFormatter.dateFormat = @"mm";
            time = [[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]] integerValue];
            timeNow = [[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]] integerValue];
            if (timeNow - time >= 0) {
                //超过1H置返
                return [NSString stringWithFormat:@"1小时前"];
            }else{
                return [NSString stringWithFormat:@"%zi分钟前",timeNow - time + 60];
            }
        }
        if (timeNow - time == 0) {
            dateFormatter.dateFormat = @"mm";
            time = [[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]] integerValue];
            timeNow = [[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]] integerValue];
            return [NSString stringWithFormat:@"%zi分钟前",timeNow - time];
        }
        return [NSString stringWithFormat:@"%zi小时前",timeNow - time];
    }
    
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    return [dateFormatter stringFromDate:date];
}

/**
 *  传一个日期字符串，判断是否是今天(无年)
 *
 *  @param dateStr 日期字符串
 *
 *  @return 修改完的日期字符串
 */
+ (NSString *)dateWithOutYearStr:(NSString *)dateStr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    //创建一个日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    if (!date) {
        date = [NSDate dateWithTimeIntervalSince1970:[dateStr doubleValue]];
    }
    
    if (!date) {
        return nil;
    }
    //通过日历对象，判断date是否是今天的日期
    if ([calendar isDateInToday:date]) {
        dateFormatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    }
    
    dateFormatter.dateFormat = @"MM-dd HH:mm";
    return [dateFormatter stringFromDate:date];
}

/**
 *  传一个日期字符串，判断是否是今天(无年)
 *
 *  @param dateStr 日期字符串
 *
 *  @return 修改完的日期字符串
 */
+ (NSString *)dateWithOutYearDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    //创建一个日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    if (!date) {
        return nil;
    }
    //通过日历对象，判断date是否是今天的日期
    if ([calendar isDateInToday:date]) {
        dateFormatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    }
    
    dateFormatter.dateFormat = @"MM-dd HH:mm";
    return [dateFormatter stringFromDate:date];
}

#pragma mark - Json
/**
 *  单个数组组成Json文件
 *
 *  @param key 接口关键字
 *  @param arr 接口数组
 *
 *  @return json字符串
 */
+ (NSString *)jsonStrWithKey:(NSString *)key withArr:(NSArray *)arr{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:arr forKey:key];
    NSData *data=[NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:nil];
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return jsonStr;
}
/**
 *  单个数组组成Json文件
 *
 *  @param key 接口关键字
 *  @param arr 接口数组
 *
 *  @return json字符串
 */
+ (NSString *)jsonStrWithArr:(NSArray *)arr{
    NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:kNilOptions error:nil];
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return jsonStr;
}
/**
 *  字符串组成UTF8文件
 *
 *  @param key 接口关键字
 *  @param arr 接口数组
 *
 *  @return json字符串
 */
+ (NSString *)UTF8WithStringJW:(NSString *)str{
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
/**
 *  字符串解析UTF8
 *
 *  @param UTF8String UTF8
 *
 *  @return 字符串
 */
+ (NSString *)stringWithUTF8JW:(NSString *)UTF8String{
    return [UTF8String stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - RegEx
/**
 *  密码长度至少6
 *
 *  @param password 密码
 *
 *  @return 密码长度是否大于等于6
 */
+ (BOOL)isRightPassWordWithStr:(NSString *)password{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:password];
}

/**
 *  纯数字验证码
 *
 *  @param comfireCode 验证码
 *
 *  @return 验证码纯数字
 */
+ (BOOL)isComfireCodeWithStr:(NSString *)comfireCode{
    NSString *codeRegex = @"^[0-9]{1,10}+$";
    NSPredicate *codePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",codeRegex];
    return [codePredicate evaluateWithObject:comfireCode];
}


/**
 *  邮箱验证
 *
 *  @param email 邮箱
 *
 *  @return 是否是邮箱
 */
+ (BOOL)isEmailWithStr:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 *  验证手机号
 *
 *  @param phoneNumber 手机号
 *
 *  @return 是否是手机号
 */
+ (BOOL)isPhoneIDWithStr:(NSString *)phoneNumber{
    NSString * phoneNumberRegex = @"^[0-9]{10,11}+$";
    NSPredicate * phoneNumberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneNumberRegex];
    return [phoneNumberPredicate evaluateWithObject:phoneNumber];
}
/**
 *  验证国内手机号
 *
 *  @param telNumber 手机号
 *
 *  @return 是否是手机号
 */
+ (BOOL)checkTelNumber:(NSString*)telNumber{
    NSString * pattern =@"^1+[3578]+\\d{9}";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:telNumber];
}

/**
 *  判断是否含表情字符串
 *
 *  @param string 字符串
 *
 *  @return 是否含有
 */
+ (BOOL)stringContainsEmoji:(NSString *)string{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    
    return returnValue;
}


#pragma mark - NSString
/**
 *  数字时间转格式时间
 *
 *  @param number 数字时间,如:123456789
 *
 *  @return 格式时间,如:2016-01-01
 */
+ (NSString *)stringNumberTurnToDateWithNumber:(NSString *)number{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[number intValue]];
    return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:confromTimesp]];
}
/**
 *  获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
 *
 *  @param str 传入汉字字符串
 *
 *  @return 获取首字母
 */
+ (NSString *)stringWithFirstCharactor:(NSString *)str{
    NSMutableString *strFir = [NSMutableString stringWithString:str];
    CFStringTransform((CFMutableStringRef)strFir,NULL, kCFStringTransformMandarinLatin,NO);//先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)strFir,NULL, kCFStringTransformStripDiacritics,NO);//再转换为不带声调的拼音
    
    return [[strFir capitalizedString] substringToIndex:1];//转化为大写拼音&获取并返回首字母
//    return [strFir capitalizedString];
}

/**
 *  32进制转10进制
 *
 *  @param str 32进制str
 *
 *  @return 10进制
 */
+ (NSString *)stringWithNumberThirtyTwoBase:(NSString *)str{
    NSString * temp10 = [NSString stringWithFormat:@"%lu",strtoul([str UTF8String],0,32)];
    return temp10;
}

/**
 *  10进制转32进制
 *
 *  @param str 10进制str
 *
 *  @return 32进制
 */
+ (NSString *)stringThirtyTwoWithNumberTenBase:(NSString *)numberStr{
    NSString *nLetterValue;
    NSString *str =@"";
    NSInteger tmpid = [numberStr integerValue];
    NSInteger ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig= tmpid%32;
        tmpid= tmpid/32;
        switch (ttmpig){
            case 10:
                nLetterValue =@"a";break;
            case 11:
                nLetterValue =@"b";break;
            case 12:
                nLetterValue =@"c";break;
            case 13:
                nLetterValue =@"d";break;
            case 14:
                nLetterValue =@"e";break;
            case 15:
                nLetterValue =@"f";break;
            case 16:
                nLetterValue =@"g";break;
            case 17:
                nLetterValue =@"h";break;
            case 18:
                nLetterValue =@"i";break;
            case 19:
                nLetterValue =@"j";break;
            case 20:
                nLetterValue =@"k";break;
            case 21:
                nLetterValue =@"l";break;
            case 22:
                nLetterValue =@"m";break;
            case 23:
                nLetterValue =@"n";break;
            case 24:
                nLetterValue =@"o";break;
            case 25:
                nLetterValue =@"p";break;
            case 26:
                nLetterValue =@"q";break;
            case 27:
                nLetterValue =@"r";break;
            case 28:
                nLetterValue =@"s";break;
            case 29:
                nLetterValue =@"t";break;
            case 30:
                nLetterValue =@"u";break;
            case 31:
                nLetterValue =@"v";break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%zi",ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    return str;
}

#pragma mark - QR Code 二维码
/**
 *  创建二维码
 *  @param QRStr 二维码链接
 */
+ (UIImage *)makeQRCodeWithStr:(NSString *)QRStr{
    //创建一个过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复默认(因为滤镜有可能保存了上一次的属性)
    [filter setDefaults];
    //给过滤器添加数据
    NSData *data = [QRStr dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    //获取输出的二维码
    CIImage *outputimage = [filter outputImage];
    //    return [UIImage imageWithCIImage:outputimage];
    return [JWTools createNonInterpolatedUIImageFormCIImage:outputimage withSize:100.f];
}

/**
 *  模糊二维码处理
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
#pragma mark - 图片转Str
/**
 *  图片转Str
 *
 *  @param image 图片
 *
 *  @return 图片转Str
 */
+ (NSString *)imageToStr:(UIImage *)image{
    NSData * data = [UIImagePNGRepresentation(image) base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
//    return (NSString *)[data base64EncodedStringWithOptions:0];
}

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
+ (CGSize)getScaleImageSizeWithImageView:(UIImage *)image withHeight:(CGFloat)height withWidth:(CGFloat)width{
    float heightScale = height/image.size.height/1.0;
    float widthScale = width/image.size.width/1.0;
    float scale = MIN(heightScale, widthScale);
    float h = image.size.height*scale;
    float w = image.size.width*scale;
    return CGSizeMake(w, h);
}

#pragma mark - 图片压缩
/**
 *  图片压缩到指定大小
 *
 *  @param image      图片
 *  @param targetSize 大小
 *
 *  @return 压缩后图片
 */
+ (UIImage*)imageByScalingAndCropping:(UIImage *)image ForSize:(CGSize)targetSize{
   //缩图片大小，“缩” 文件的尺寸变小，也就是像素数减少。长宽尺寸变小，文件体积同样会减小
    UIGraphicsBeginImageContext(targetSize);
    [image drawInRect:CGRectMake(0,0,targetSize.width,targetSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
    //压图片大小，“压” 文件体积变小，但是像素数不变，长宽尺寸不变，那么质量可能下降
//    return [UIImage imageWithData:UIImageJPEGRepresentation(newImage, 0.5f)];
}

/**
 *  微信分享图片32K限制
 *
 *  @param imageUrl 图片URL
 *
 *  @return 压缩后图片
 */
+ (UIImage *)zipImageWithImage:(UIImage *)image{
    while (UIImageJPEGRepresentation(image, 1.f).length/1024 > 30) {
        image = [JWTools imageByScalingAndCropping:image ForSize:CGSizeMake(image.size.width * 0.7f, image.size.height * 0.7f)];
    }
    return image;
}

#pragma mark - 图片滤镜
/**
 *  图片加滤镜
 *
 *  @param image      修改图片
 *  @param filterName 滤镜效果名称
 *
 *  @return 修改后图片
 */
+ (UIImage*)filteredImage:(UIImage*)image withFilterName:(NSString*)filterName{
    if([filterName isEqualToString:@"Original"])return image;
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setDefaults];
    
    //部分阴影
//        if([filterName isEqualToString:@"CIVignetteEffect"]){
//            CGFloat R = MIN(image.size.width, image.size.height)/2;
//            CIVector *vct = [[CIVector alloc] initWithX:image.size.width/2 Y:image.size.height/2];
//            [filter setValue:vct forKey:@"inputCenter"];
//            [filter setValue:[NSNumber numberWithFloat:0.9] forKey:@"inputIntensity"];
//            [filter setValue:[NSNumber numberWithFloat:R] forKey:@"inputRadius"];
//        }
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return result;
}
/**
 *  滤镜效果数组
 *
 *  @return 滤镜效果数组
 */
+ (NSArray *)imageFilterArr{
//    return @[
//      @{@"name":@"Original",@"title":@"原图"},
//      @{@"name":@"CISRGBToneCurveToLinear",@"title":@"挪威的森林"},
//      @{@"name":@"CIPhotoEffectChrome",@"title":@"迷失京东"},
//      @{@"name":@"CIPhotoEffectInstant",@"title":@"一页台北"},
//      @{@"name":@"CIPhotoEffectProcess",@"title":@"罗马假日"},
//      @{@"name":@"CIPhotoEffectTransfer",@"title":@"恋战冲绳"},
//      @{@"name":@"CISepiaTone",@"title":@"情迷翡冷翠"},
//      @{@"name":@"CILinearToSRGBToneCurve",@"title":@"布拉格之恋"},
//      @{@"name":@"CIPhotoEffectFade",@"title":@"旺角卡门"},
//      @{@"name":@"CIVignetteEffect",@"title":@"广岛之恋"},
//      @{@"name":@"CIPhotoEffectTonal",@"title":@"冰岛之梦"},
//      @{@"name":@"CIPhotoEffectNoir",@"title":@"挪威风情"},
//      @{@"name":@"CIPhotoEffectMono",@"title":@"夏威夷海滩"}];
    return @[
             @{@"name":@"Original",@"title":@"原图"},
             @{@"name":@"CISRGBToneCurveToLinear",@"title":@"挪威的森林"},
             @{@"name":@"CIPhotoEffectChrome",@"title":@"迷失京东"},
             @{@"name":@"CIPhotoEffectInstant",@"title":@"一页台北"},
             @{@"name":@"CIPhotoEffectProcess",@"title":@"罗马假日"},
             @{@"name":@"CIPhotoEffectTransfer",@"title":@"恋战冲绳"},
             @{@"name":@"CISepiaTone",@"title":@"情迷翡冷翠"},
             @{@"name":@"CILinearToSRGBToneCurve",@"title":@"布拉格之恋"},
             @{@"name":@"CIPhotoEffectFade",@"title":@"旺角卡门"},
             @{@"name":@"CIPhotoEffectNoir",@"title":@"挪威风情"},
             @{@"name":@"CIPhotoEffectMono",@"title":@"广岛之恋"},
           @{@"name":@"CIPhotoEffectTonal",@"title":@"冰岛之梦"}];
}

#pragma mark - UUID
/**
 *  获取UUDID
 *
 *  @return 获取UUDID
 */
+(NSString *)getUUID{
    NSString * strUUID = [KUSERDEFAULT valueForKey:KEY_USERNAME_PASSWORD];
    if (strUUID)return strUUID;
    strUUID = (NSString *)[JWTools load:@"com.company.app.usernamepassword"];
    
    if ([strUUID isEqualToString:@""] || !strUUID){//首次执行该方法时，uuid为空
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));//生成一个uuid的方法
        
        [JWTools save:KEY_USERNAME_PASSWORD data:strUUID];//将该uuid保存到keychain,KEY_USERNAME_PASSWORD为全局
        [[NSUserDefaults standardUserDefaults] setObject:strUUID forKey:KEY_USERNAME_PASSWORD];
    }
    return strUUID;
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)deleteKeyData:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}


+(NSString*)getTime:(NSString *)number{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    @"yyyy-MM-dd HH:mm"
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [dateFormatter dateFromString:number];
    
    
    if (!date) {
        date = [NSDate dateWithTimeIntervalSince1970:[number doubleValue]];
    }

    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return [dateFormatter stringFromDate:date];
    
}


+(UIView*)addLoadingViewWithframe:(CGRect)frame{
    UIView*loadingView=[[NSBundle mainBundle]loadNibNamed:@"HUDLoadingShowView" owner:nil options:nil].firstObject;
    loadingView.frame=frame;
     return loadingView;
}

+(void)removeLoadingView:(UIView*)view{
    [view removeFromSuperview];
    
}

+(UIView*)addFailViewWithFrame:(CGRect)frame withTouchBlock:(void (^)())touchBlock{
    HUDFailureShowView*failView=[[NSBundle mainBundle]loadNibNamed:@"HUDFailureShowView" owner:nil options:nil].firstObject;
    failView.frame=CGRectMake(0, 64, kScreen_Width, kScreen_Height-64);
    failView.reloadBlock=touchBlock;
  
    
    return failView;
}

@end
