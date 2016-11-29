//
//  YWHomeCommoditiesTableViewCell.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/29.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWHomeCommoditiesTableViewCell.h"

@implementation YWHomeCommoditiesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(YWHomeCommoditiesModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
}
- (void)dataSet{//233333333
//    self.showImageView
    self.nameLabel.text = @"绝味鸭脖";
    self.conLabel.text = @"绝味鸭脖是绝味食品股份有限公司的核心品牌";
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",@"35.5"];
}

@end
