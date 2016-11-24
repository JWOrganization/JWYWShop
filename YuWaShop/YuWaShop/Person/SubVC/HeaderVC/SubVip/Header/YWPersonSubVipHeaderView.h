//
//  YWPersonSubVipHeaderView.h
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWPersonSubVipHeaderModel.h"
#import "NSString+JWAppendOtherStr.h"

@interface YWPersonSubVipHeaderView : UIView
@property (nonatomic,copy)void (^changeShowBlock)(NSInteger);
@property (nonatomic,copy)void (^getMoneyBlock)();

@property (nonatomic,strong)YWPersonSubVipHeaderModel * model;

@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegmentControl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyRestLabel;

@property (weak, nonatomic) IBOutlet UIButton *getMoneyBtn;


@end
