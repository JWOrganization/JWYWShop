//
//  YWHomeQuickPayListTableViewCell.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/29.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWHomeQuickPayListTableViewCell.h"
#import "JWTools.h"

@implementation YWHomeQuickPayListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(YWHomeQuickPayListModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
}
- (void)dataSet{//233333333
    self.nameLabel.text = @"客户";
    self.timeLabel.text = @"2016-10-23 15:00";
    self.priceLabel.text = [NSString stringWithFormat:@"+%@元",@"38.77"];
    self.cutLabel.text = [NSString stringWithFormat:@"原价:%@ 实付:%@ 折扣:%@折",@"300",@"250",@"8.8"];
    self.couponLabel.text = [NSString stringWithFormat:@"优惠券减%@元",@"23"];
}

@end
