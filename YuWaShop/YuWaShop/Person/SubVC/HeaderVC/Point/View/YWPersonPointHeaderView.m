
//
//  YWPersonPointHeaderView.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPersonPointHeaderView.h"

@implementation YWPersonPointHeaderView

- (void)setModel:(YWPersonPointHeaderModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
    [self layoutSet];
}

- (void)dataSet{//233333333
    
    
}

- (void)layoutSet{
    
    [self setNeedsLayout];
}

- (IBAction)getMoneyBtnAtion:(UIButton *)sender {
    self.getMoneyBlock();
}


@end
