//
//  YWPersonPointHeaderView.h
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWPersonPointHeaderModel.h"

@interface YWPersonPointHeaderView : UIView

@property (nonatomic,copy)void (^getMoneyBlock)();
@property (nonatomic,strong)YWPersonPointHeaderModel * model;

@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;


@end
