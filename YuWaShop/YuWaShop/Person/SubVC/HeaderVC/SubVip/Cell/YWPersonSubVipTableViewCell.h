//
//  YWPersonSubVipTableViewCell.h
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWPersonSubVipModel.h"

@interface YWPersonSubVipTableViewCell : UITableViewCell

@property (nonatomic,strong)YWPersonSubVipModel * model;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
