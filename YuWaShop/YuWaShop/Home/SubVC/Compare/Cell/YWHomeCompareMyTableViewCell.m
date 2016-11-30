//
//  YWHomeCompareMyTableViewCell.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/30.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWHomeCompareMyTableViewCell.h"
#import "NSString+JWAppendOtherStr.h"

@implementation YWHomeCompareMyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.showImageView.layer.cornerRadius = 5.f;
    self.showImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(YWHomeCompareMyModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
}
- (void)dataSet{//233333333
    //    self.showImageView.image;
    self.nameLabel.text = @"店23333";
    NSString * countStr;
    switch (self.model.status) {
        case 0:
            countStr = [NSString stringWithFormat:@"浏览人数:%@人",@"233333"];
            break;
        case 1:
            countStr = [NSString stringWithFormat:@"消费人数:%@人",@"2333"];
            break;
        case 2:
            countStr = [NSString stringWithFormat:@"消费金额%@元",@"23333"];
            break;
        case 3:
            countStr = [NSString stringWithFormat:@"总评分:%@分",@"5"];
            break;
            
        default:
            break;
    }
    self.countLabel.text = countStr;
    
    NSMutableAttributedString * compareStr= [NSString stringWithFirstStr:@"排名高于泉州其他" withFont:[UIFont systemFontOfSize:15.f] withColor:[UIColor colorWithHexString:@"#f7de46"] withSecondtStr:[NSString stringWithFormat:@"%@%%",@"99"] withFont:[UIFont systemFontOfSize:15.f] withColor:CNaviColor];
    [compareStr appendAttributedString:[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"的%@类同行",@"餐饮"] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#f7de46"],NSFontAttributeName:[UIFont systemFontOfSize:15.f]}]];
    self.compareLabel.attributedText = compareStr;
}

@end
