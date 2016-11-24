//
//  YWPersonSubVipHeaderView.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPersonSubVipHeaderView.h"
#import "NSDictionary+Attributes.h"

@implementation YWPersonSubVipHeaderView
- (void)awakeFromNib{
    [super awakeFromNib];
    self.getMoneyBtn.layer.cornerRadius = 5.f;
    self.getMoneyBtn.layer.masksToBounds = YES;
    [self.typeSegmentControl setTitleTextAttributes:[NSDictionary dicOfTextAttributeWithFont:[UIFont systemFontOfSize:15.f] withTextColor:[UIColor colorWithHexString:@"#25C0E9"]] forState:UIControlStateNormal];
    [self.typeSegmentControl setTitleTextAttributes:[NSDictionary dicOfTextAttributeWithFont:[UIFont systemFontOfSize:15.f] withTextColor:[UIColor whiteColor]] forState:UIControlStateSelected];
}

- (void)setModel:(YWPersonSubVipHeaderModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
}

- (void)dataSet{//233333333
    NSMutableAttributedString * moneyStr = [NSString stringWithFirstStr:@"分红历史总收入:" withFont:[UIFont systemFontOfSize:14.f] withColor:[UIColor blackColor] withSecondtStr:@"2333333" withFont:[UIFont systemFontOfSize:14.f] withColor:CNaviColor];
    [moneyStr appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@"元" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14.f]}]];
    self.moneyLabel.attributedText = moneyStr;
    
    NSMutableAttributedString * moneyRestStr = [NSString stringWithFirstStr:@"分红账户余额:" withFont:[UIFont systemFontOfSize:14.f] withColor:[UIColor blackColor] withSecondtStr:@"2333333" withFont:[UIFont systemFontOfSize:14.f] withColor:CpriceColor];
    [moneyRestStr appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@"元" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14.f]}]];
    self.moneyRestLabel.attributedText = moneyRestStr;
}


- (IBAction)typeSegmentControlAction:(UISegmentedControl *)sender {
    self.changeShowBlock(sender.selectedSegmentIndex);
}

- (IBAction)getMoneyBtnAction:(UIButton *)sender {
    self.getMoneyBlock();
}


@end
