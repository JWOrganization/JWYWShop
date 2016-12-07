//
//  DayDetailViewController.m
//  YuWaShop
//
//  Created by 黄佳峰 on 2016/12/7.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "DayDetailViewController.h"
#import "YWHomeQuickPayListTableViewCell.h"

#import "YWHomeQuickPayListModel.h"
#import "ForMoneyModel.h"

#define CELL0   @"YWHomeQuickPayListTableViewCell"

@interface DayDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,assign)NSInteger pagens;
@property (nonatomic,assign)NSInteger pages;
@property (nonatomic,strong)NSMutableArray * allDatasList;
@property(nonatomic,strong)NSMutableArray*allDatasMoney;

@end

@implementation DayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title=@"收入详情";
     [self dataSet];
     [self setupRefresh];
    
}

- (void)dataSet{
    self.pagens = 10;
    self.pages=0;
    self.allDatasList = [NSMutableArray arrayWithCapacity:0];
    self.allDatasMoney=[NSMutableArray arrayWithCapacity:0];
    
    [self.tableView registerNib:[UINib nibWithNibName:CELL0 bundle:nil] forCellReuseIdentifier:CELL0];
}

#pragma mark - TableView Refresh
- (void)setupRefresh{
    self.tableView.mj_header = [UIScrollView scrollRefreshGifHeaderWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
         self.pages=0;
        self.allDatasList = [NSMutableArray arrayWithCapacity:0];
        self.allDatasMoney=[NSMutableArray arrayWithCapacity:0];
        [self getDatas];

        
    }];
    self.tableView.mj_footer = [UIScrollView scrollRefreshGifFooterWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
        self.pages++;
        self.allDatasMoney=[NSMutableArray arrayWithCapacity:0];
        [self getDatas];
        
    }];
    
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark  -- setDatas
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.allDatasMoney.count<1) {
        return 1;
    }else{
        return 2;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.allDatasMoney.count<1) {
        return self.allDatasList.count;
        
    }else{
        if (section==0) {
            return self.allDatasMoney.count;
        }else{
            return self.allDatasList.count;
        }
        
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWHomeQuickPayListTableViewCell * listCell = [tableView dequeueReusableCellWithIdentifier:CELL0];

    
    if (self.allDatasMoney.count<1) {
       
       listCell.model = self.allDatasList[indexPath.row];
        return listCell;

    }else{
        if (indexPath.section==0) {
            listCell.cutLabel.text=@"";
            listCell.couponLabel.text=@"";
            
            //more
            if (indexPath.row==0) {
                listCell.nameLabel.text=@"介绍分红";
            }else{
                listCell.nameLabel.text=@"积分提现";
            }
            
            return listCell;
        }else{
         
            listCell.model = self.allDatasList[indexPath.row];
            return listCell;
 
            
        }
        
        
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}


#pragma mark  --setDatas
-(void)getDatas{
    NSArray*accord=@[@"",@"",@"",@"",@"",@"",@""];
    NSArray*money=@[@{},@{}];
    
    for (NSDictionary*dict in money) {
        ForMoneyModel*model=[ForMoneyModel yy_modelWithDictionary:dict];
        [self.allDatasMoney addObject:model];
    }
    
    self.allDatasList=[accord mutableCopy];
    
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
