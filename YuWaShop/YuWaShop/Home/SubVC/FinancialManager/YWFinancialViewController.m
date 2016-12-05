//
//  YWFinancialViewController.m
//  YuWaShop
//
//  Created by 黄佳峰 on 2016/12/5.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWFinancialViewController.h"
#import "FinancialTableViewCell.h"





#define CELL0     @"FinancialTableViewCell"
@interface YWFinancialViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)UISegmentedControl*typeSegmentView;

@property(nonatomic,assign)NSInteger type;  //0为结算   1为记录
@end

@implementation YWFinancialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:CELL0 bundle:nil] forCellReuseIdentifier:CELL0];
    [self makeTopView];
    
}

#pragma mark  --  UI
-(void)makeTopView{
  
    
    self.typeSegmentView=[[UISegmentedControl alloc]initWithItems:@[@"结算",@"记录"]];
    self.typeSegmentView.frame=CGRectMake(0, 0, 150, 35);
    self.typeSegmentView.selectedSegmentIndex=0;
    [self.typeSegmentView setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [self.typeSegmentView setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:CNaviColor} forState:UIControlStateSelected];
    self.typeSegmentView.layer.borderColor=[UIColor whiteColor].CGColor;
    self.typeSegmentView.layer.borderWidth=2;
    self.typeSegmentView.layer.cornerRadius = 17.f;
    self.typeSegmentView.layer.masksToBounds = YES;
    [self.typeSegmentView addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];

      self.navigationItem.titleView=self.typeSegmentView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.type==0) {
        //结算
        return 1;
    }else{
        //记录    如果没有数据 就显示空的
        return 7;
        
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type==0) {
        FinancialTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
      
        return cell;
        
        
    }else{
        UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            
        }
        cell.textLabel.text=@"2016.11.11";
        cell.detailTextLabel.text=@"500";
        
        return cell;
        
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type==0) {
        return 100;
    }else{
        return 44;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}



#pragma mark  --touch
- (void)segmentControlAction:(UISegmentedControl *)sender{
    self.type = sender.selectedSegmentIndex;
//    [self.tableView.mj_header beginRefreshing];
    [self.tableView reloadData];
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

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}


@end
