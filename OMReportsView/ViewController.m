//
//  ViewController.m
//  OMReportsView
//
//  Created by 印聪 on 2017/4/21.
//  Copyright © 2017年 tima. All rights reserved.
//

#import "ViewController.h"
#import "OMReportsView.h"
@interface ViewController ()

@property (nonatomic , strong)OMReportsView *reportsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.reportsView];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.reportsView.frame = CGRectMake(0, 100, self.view.bounds.size.width, 150);
}

#pragma mark -- getters and setters
- (OMReportsView *)reportsView{
    if (_reportsView == nil) {
        _reportsView = [[OMReportsView alloc]init];
        _reportsView.rowNames = @[@"订单",@"PDI入库",@"批发",@"零售"];
        _reportsView.rowSubtitleNames = @[@"Order",@"Instock",@"Wholesale",@"Resale"];
        _reportsView.colNames = @[@"当日",@"当月",@"当年"];
        _reportsView.colSubTitleNames = @[@"DTD",@"MTD",@"YTD"];
        NSArray *array = @[@[@"00",@"01",@"02",@"03"],@[@"10",@"11",@"12",@"13"],@[@"20",@"21",@"22",@"23"]];
        _reportsView.rowsDataArray = array;
        [_reportsView row:0 font:[UIFont systemFontOfSize:15] textColor:[UIColor redColor]];
    }
    return _reportsView;
}

@end
