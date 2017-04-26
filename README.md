# OMReportsView

报表控件，目前样式比较单一。

使用方法：
rowNames属性设置第一行标题，colNames设置第一列标题。
rowSubtitleNames设置第一行的副标题，该属性可选。
rowsDataArray是以行为单位设置数据，即该数组中得数据数量必须与colNames一致
同理也可通过colsDataArray设置数据。
```
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.reportsView];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

    self.reportsView.frame = CGRectMake(0, 100, self.view.bounds.size.width, 150);
}


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

```
![image](https://github.com/olderMonster/OMReportsView/blob/master/Simulator%20Screen%20Shot%202017%E5%B9%B44%E6%9C%8824%E6%97%A5%20%E4%B8%8B%E5%8D%881.46.48.png)

