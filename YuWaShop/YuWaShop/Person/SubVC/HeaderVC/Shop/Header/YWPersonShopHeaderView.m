//
//  YWPersonShopHeaderView.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPersonShopHeaderView.h"
#import "JWTools.h"

@implementation YWPersonShopHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.imageCountLabBGView.layer.cornerRadius = 9.f;
    self.imageCountLabBGView.layer.masksToBounds = YES;
}

- (void)setModel:(YWPersonShopHeaderModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
    [self layoutSet];
}

- (void)dataSet{//233333333
    CGFloat point = 4.3f;//评分Temp
    NSInteger countTime = point/1;
    if (point >= 0.5f && point < 1.f) {
        UIImageView * imageView = [self viewWithTag:1];
//        imageView.image //image设置半个
    }else{
        for (int i = 0; i < countTime; i++) {
            UIImageView * imageView = [self viewWithTag:(i+1)];
            if (!imageView)break;
            if (i > point && i <= point + 0.5f) {
//                imageView.image //image设置半个
            }else{
                imageView.image = [UIImage imageNamed:@"home-hotel-star-0"];
            }
        }
    }
}

- (void)refreshUI{
    self.nameLabel.text = [UserSession instance].nickName;
    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:[UserSession instance].logo] placeholderImage:[UIImage imageNamed:@"btn-Upload-Avatar"] completed:nil];
    self.signatureLabel.text = [UserSession instance].personality;
}

- (void)layoutSet{
    self.imageCountBGWidth.constant = [JWTools labelWidthWithLabel:self.imageCountLabel];
    [self setNeedsLayout];
}

@end
