//
//  YWPersonShopModel.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPersonShopModel.h"

@implementation YWPersonShopModel

static YWPersonShopModel * shop =nil;

+ (YWPersonShopModel *)sharePersonShop{
    if (!shop) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            shop = [[YWPersonShopModel alloc]init];
            [YWPersonShopModel defaultInfoSet];
        });
    }
    return shop;
}

+ (void)defaultInfoSet{
    shop.dataArr = [NSMutableArray arrayWithArray:@[@[],@[@"",@"",@""],@[@"",@"",@""],@[@""]]];
}


@end
