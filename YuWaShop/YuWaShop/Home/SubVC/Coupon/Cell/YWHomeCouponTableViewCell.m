//
//  YWHomeCouponTableViewCell.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/30.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWHomeCouponTableViewCell.h"

@implementation YWHomeCouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(YWHomeCouponModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
}
- (void)dataSet{//233333333
    self.cutNumberLabel.text = [NSString stringWithFormat:@"%@元",@"20"];
    self.conditionLabel.text = [NSString stringWithFormat:@"满%@减",@"100"];
    self.nameLabel.text = [NSString stringWithFormat:@"%@抵用券(本店专用)",@"上海派柯"];
    self.timeLabel.text = [NSString stringWithFormat:@"有效期%@至%@",@"2016-11-10",@"2016-11-20"];
}

@end
