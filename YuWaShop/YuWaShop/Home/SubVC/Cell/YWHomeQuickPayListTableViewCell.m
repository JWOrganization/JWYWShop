//
//  YWHomeQuickPayListTableViewCell.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/29.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWHomeQuickPayListTableViewCell.h"
#import "NSString+JWAppendOtherStr.h"
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
    [self layoutSet];
}
- (void)dataSet{//233333333
    self.nameLabel.text = @"客户";
    self.timeLabel.text = @"2016-10-23";
    self.couponLabel.text = @"优惠券:满100减10元";
    self.couponLabel.hidden = [self.couponLabel.text isEqualToString:@""];
    NSMutableAttributedString * priceStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"原价:%@",@"23333"] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#cccccc"],NSFontAttributeName:[UIFont systemFontOfSize:15.f]}];
    [priceStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, priceStr.length)];
    self.priceLabel.attributedText = priceStr;
    self.cutLabel.text = [NSString stringWithFormat:@"折扣:%@折",@"1"];
    self.payPriceLabel.text = [NSString stringWithFormat:@"现价:%@元",@"2333.3"];
}

- (void)layoutSet{
    if (self.couponLabel.hidden)return;
    self.couponWidth.constant = [JWTools labelWidthWithLabel:self.couponLabel];
    [self setNeedsLayout];
}

@end
