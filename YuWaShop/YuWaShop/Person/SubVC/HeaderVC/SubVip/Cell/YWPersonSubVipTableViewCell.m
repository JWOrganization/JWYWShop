//
//  YWPersonSubVipTableViewCell.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPersonSubVipTableViewCell.h"
#import "NSString+JWAppendOtherStr.h"

@implementation YWPersonSubVipTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(YWPersonSubVipModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
}

- (void)dataSet{
    self.nameLabel.text = @"23333333";
    
    NSMutableAttributedString * costStr = [NSString stringWithFirstStr:@"共消费" withFont:[UIFont systemFontOfSize:14.f] withColor:[UIColor blackColor] withSecondtStr:@"2333333" withFont:[UIFont systemFontOfSize:14.f] withColor:[UIColor redColor]];
    [costStr appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@"元" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14.f]}]];
    self.costLabel.attributedText = costStr;
    
    
    NSMutableAttributedString * moneyStr = [NSString stringWithFirstStr:@"共为您带来:" withFont:[UIFont systemFontOfSize:14.f] withColor:[UIColor blackColor] withSecondtStr:@"2333333" withFont:[UIFont systemFontOfSize:14.f] withColor:CpriceColor];
    [moneyStr appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@"元" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14.f]}]];
    self.moneyLabel.attributedText = moneyStr;
    
    self.timeLabel.attributedText = [NSString stringWithFirstStr:@"最后登录:" withFont:[UIFont systemFontOfSize:14.f] withColor:[UIColor blackColor] withSecondtStr:@"2016-11-11" withFont:[UIFont systemFontOfSize:14.f] withColor:CNaviColor];//23333333333
}

@end
