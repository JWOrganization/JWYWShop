//
//  YWPSRePlayTableViewCell.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/28.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPSRePlayTableViewCell.h"
#import "JWTools.h"

@implementation YWPSRePlayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.qShowLabel.layer.cornerRadius = 10.f;
    self.qShowLabel.layer.masksToBounds = YES;
    self.aShowLabel.layer.cornerRadius = 10.f;
    self.aShowLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(YWPSRePlayModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
    [self layoutSet];
}

- (void)dataSet{//233333333
//    self.questLabel.text = self.model.problem;
//    self.answerLabel.text = self.model.reply;
    self.questLabel.text = @"23333333333天气转冷？";
    self.answerLabel.text = @"天气转冷，有很多网友曝出iPhone自动关机的情况，苹果工作人员表示只要在保修期内，都可以返厂维修。";
}

- (void)layoutSet{
    self.questLabelHeigh.constant = [JWTools labelHeightWithLabel:self.questLabel];
    if (![self.answerLabel.text isEqualToString:@""]) {
        self.answerLabelHeigh.constant = [JWTools labelHeightWithLabel:self.answerLabel];
    }else{
        self.answerLabelHeigh.constant = 0.f;
        self.answerShowLabelHeigh.constant = 0.f;
        self.bottomViewTopHeight.constant = 0.f;
    }
    [self setNeedsLayout];
}

@end
