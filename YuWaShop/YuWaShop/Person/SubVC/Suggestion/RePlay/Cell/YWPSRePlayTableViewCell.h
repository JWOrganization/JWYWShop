//
//  YWPSRePlayTableViewCell.h
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/28.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWPSRePlayModel.h"

@interface YWPSRePlayTableViewCell : UITableViewCell

@property (nonatomic,strong)YWPSRePlayModel * model;

@property (weak, nonatomic) IBOutlet UILabel *qShowLabel;
@property (weak, nonatomic) IBOutlet UILabel *aShowLabel;

@property (weak, nonatomic) IBOutlet UILabel *questLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *questLabelHeigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *answerLabelHeigh;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *answerShowLabelHeigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewTopHeight;

@end
