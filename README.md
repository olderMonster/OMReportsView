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

![Image text](https://github.com/olderMonster/OMReportsView/blob/master/Simulator%20Screen%20Shot%202017%E5%B9%B44%E6%9C%8824%E6%97%A5%20%E4%B8%8B%E5%8D%881.46.48.png)

