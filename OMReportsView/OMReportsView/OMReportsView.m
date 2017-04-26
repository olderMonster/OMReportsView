//
//  OMReportsView.m
//  BorgwardSMS
//
//  Created by 印聪 on 2017/4/20.
//  Copyright © 2017年 BORGWARD. All rights reserved.
//

#import "OMReportsView.h"

@interface OMReportsView()

//存储列标题Label(第一行标题)
@property (nonatomic , strong)NSMutableArray *rowsLabelArray;
//存储列subtitle的label（第一行标题）
@property (nonatomic , strong)NSMutableArray *rowsSubtitleLabelArray;
//存储行标题label（第一列标题）
@property (nonatomic , strong)NSMutableArray *colsLabelArray;


@property (nonatomic , strong)NSArray *dataLabelArray;


//当设置某行的字体文本颜色的时候需要这些变量去记录用户设置的row以及font和textColor数据
//如：用户需要设置第1行的数据文本的字体为15，颜色为红色
@property (nonatomic , assign)NSInteger row;
@property (nonatomic , strong)UIFont *font;
@property (nonatomic , strong)UIColor *textColor;


//判断是以行绘制还是以列绘制，YES为以行绘制，否则以列绘制
@property (nonatomic , assign)BOOL isHorizontal;

@end

@implementation OMReportsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    if (self.dataLabelArray.count == 0) {
        //没有设置数据
        NSLog(@"没有设置数据");
        return;
    }
    
    if (self.dataLabelArray.count == self.rowsDataArray.count) {
        if (self.rowsDataArray.count != self.colNames.count) {
            NSLog(@"以行为单位设置数据，但是数据的行数与列标题不一致");
            return;
        }
    }else if (self.dataLabelArray.count == self.colsDataArray.count){
        if (self.colsDataArray.count != self.rowNames.count) {
            NSLog(@"以列为单位设置数据，但是数据的列数与行标题不一致");
            return;
        }
    }
    
    
    
    
    NSInteger colCount = self.rowsLabelArray.count + 1; //列数
    NSInteger rowCount = self.colsLabelArray.count + 1; //行数
    
    CGFloat colTitleHeight = self.bounds.size.height/rowCount; //列标题的高度(可自行修改)
    CGFloat itemWidth = self.bounds.size.width/colCount;  //数据文本的宽度
    CGFloat itemHeight = (self.bounds.size.height - colTitleHeight)/(rowCount - 1); //数据文本的高度
    //保证副标题与主标题的高度之和是等于数据行的高度
    CGFloat rowTitleHeight = self.rowsSubtitleLabelArray.count == 0?colTitleHeight:(colTitleHeight * 0.65); //第一行标题的高度
    CGFloat rowSubTitleLabelHeight = colTitleHeight - rowTitleHeight; //第一行副标题的高度
    
    
    //判断最长文本长度
    CGFloat rowTitleWidth = itemWidth; //行标题的宽度
    NSString *colText = nil;
    for (NSString *str in self.colNames) { //找出列头中最长的字符串
        if (colText.length < str.length) {
            colText = str;
        }
    }
    if (colText != nil) {
        UIFont *font = [UIFont systemFontOfSize:12];
        if (self.colsLabelArray.count > 0) {
            UILabel *label = (UILabel *)self.colsLabelArray[0];
            font = label.font;
        }
        CGSize colSize = [colText sizeWithAttributes:@{NSFontAttributeName:font}];
        if (colSize.width > rowTitleWidth) {
            rowTitleWidth = colSize.width;
            //当根据文本的宽度来设置第一列标题的宽度的时候，数据的宽度则需要根据剩下的宽度去计算；
            if(colCount > 1){
                itemWidth = (self.bounds.size.width -rowTitleWidth )/(colCount - 1);
            }
        }
    }
    
    
    //设置第一行标题
    for (NSInteger index = 0 ; index < self.rowsLabelArray.count; index++) {
        
        UILabel *label = (UILabel *)self.rowsLabelArray[index];
        label.frame = CGRectMake(rowTitleWidth + itemWidth * index, 0, itemWidth, rowTitleHeight);
        [self.rowsLabelArray replaceObjectAtIndex:index withObject:label];
        
        
        //当用户设置了字体颜色
        if (self.rowTitleColor != nil) {
            label.textColor = self.rowTitleColor;
        }
        
        //当用户设置了字体大小
        if (self.rowTitleFont != nil) {
            label.font = self.rowTitleFont;
        }
        
    }
    
    //当副标题的个数与主标题的个数一致时才显示
    if (self.rowsSubtitleLabelArray.count > 0 && (self.rowsSubtitleLabelArray.count == self.rowsLabelArray.count)) {
        for (NSInteger index = 0; index < self.rowsSubtitleLabelArray.count; index++) {
            UILabel *label = (UILabel *)self.rowsSubtitleLabelArray[index];
            label.frame = CGRectMake(rowTitleWidth + itemWidth * index, rowTitleHeight, itemWidth, rowSubTitleLabelHeight);
            [self.rowsSubtitleLabelArray replaceObjectAtIndex:index withObject:label];
            
            //用户设置了第一行副标题颜色
            if (self.rowSubtitleColor != nil) {
                label.textColor = self.rowSubtitleColor;
            }
            //用户设置了第一列副标题颜色
            if (self.rowSubtitleFont != nil) {
                label.font = self.rowSubtitleFont;
            }
            
        }
    }
    
    
    //设置行头(第一列标题)
    for (NSInteger index = 0 ; index < self.colsLabelArray.count; index++) {

        UILabel *label = (UILabel *)self.colsLabelArray[index];
        label.frame = CGRectMake(0, colTitleHeight + itemHeight * index, rowTitleWidth, itemHeight);
        [self.colsLabelArray replaceObjectAtIndex:index withObject:label];
        
        //当用户在设置了字体颜色
        if (self.colTitleColor != nil) {
            label.textColor = self.colTitleColor;
        }
        
        //当用户设置了字体大小
        if (self.colTitleFont != nil) {
            label.font = self.colTitleFont;
        }
    }
    
    
    //以行为单位绘制数据,默认以行为单位绘制数据
    if (self.isHorizontal) {
                
        NSMutableArray *dataLabelMArray = [[NSMutableArray alloc]initWithArray:self.dataLabelArray];
        for (NSInteger i = 0; i < self.dataLabelArray.count; i++) {
            
            //对第i行的label进行设置frame
            NSMutableArray *rowDataLabelArray = [[NSMutableArray alloc]initWithArray:self.dataLabelArray[i]];
            for (NSInteger j = 0; j < rowDataLabelArray.count; j++) {
                UILabel *label = rowDataLabelArray[j]; //第i行j列的label
                label.frame = CGRectMake(rowTitleWidth +  itemWidth * j, colTitleHeight + itemHeight * i, itemWidth, itemHeight);
                [rowDataLabelArray replaceObjectAtIndex:j withObject:label];
            }
            [dataLabelMArray replaceObjectAtIndex:i withObject:rowDataLabelArray];
        }
        self.dataLabelArray = [[NSArray alloc]initWithArray:dataLabelMArray];

    }else{ //以列位单位绘制数据

        NSMutableArray *dataLabelMArray = [[NSMutableArray alloc]initWithArray:self.dataLabelArray];
        for (NSInteger i = 0; i < self.dataLabelArray.count; i++) {
            //对第i行的label进行设置frame
            NSMutableArray *rowDataLabelArray = [[NSMutableArray alloc]initWithArray:self.dataLabelArray[i]];
            for (NSInteger j = 0; j < rowDataLabelArray.count; j++) {
                UILabel *label = rowDataLabelArray[j]; //第i列j行的label
                label.frame = CGRectMake(rowTitleWidth +  itemWidth * i, colTitleHeight + itemHeight * j, itemWidth, itemHeight);
                [rowDataLabelArray replaceObjectAtIndex:j withObject:label];
            }
            [dataLabelMArray replaceObjectAtIndex:i withObject:rowDataLabelArray];
        }
        self.dataLabelArray = [[NSArray alloc]initWithArray:dataLabelMArray];
        
    }

}



#pragma mark -- private method
//根据给定的行名称数据以及列名称数据绘制表格
- (void)setTable{
    
    
    
    //清除数组内的数据（label），然后重新添加
    self.rowsLabelArray = [[NSMutableArray alloc]init];
    self.rowsSubtitleLabelArray = [[NSMutableArray alloc]init];
    self.colsLabelArray = [[NSMutableArray alloc]init];
    
    
    
    //绘制第一行的标题
    for (NSInteger index = 0; index < self.rowNames.count; index++) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = self.rowNames[index];
        label.numberOfLines = 0;
        [self addSubview:label];
        
        [self.rowsLabelArray addObject:label];
    }
    
    //绘制第一行的副标题
    for (NSInteger index = 0; index < self.rowSubtitleNames.count; index++) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = self.rowSubtitleNames[index];
        [self addSubview:label];
        
        [self.rowsSubtitleLabelArray addObject:label];
    }
    
    //绘制第一列的标题
    for (NSInteger index = 0; index < self.colNames.count; index++) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = self.colNames[index];
        [self addSubview:label];
        
        [self.colsLabelArray addObject:label];
    }
    
}


//清除数据文本
- (void)clearDataLabel{
    
    for (NSArray *array in self.dataLabelArray) {
        for (UILabel *label in array) {
            [label removeFromSuperview];
        }
    }
    self.dataLabelArray = [[NSMutableArray alloc]init];
}



#pragma mark -- public method
- (void)row:(NSInteger)row font:(UIFont *)font textColor:(UIColor *)textColor{
    
    self.row = row;
    self.font = font;
    self.textColor = textColor;
    
    
    //以行绘制
    if (self.isHorizontal) {
        
        if (row > self.dataLabelArray.count - 1 || self.dataLabelArray.count == 0) {
            NSLog(@"设置颜色的行数超过了总行数");
            return;
        }
        
        NSMutableArray *dateLabelMArray = [[NSMutableArray alloc]initWithArray:self.dataLabelArray];
        NSMutableArray *rowLabelMArray = dateLabelMArray[row];
        for (NSInteger index = 0; index < rowLabelMArray.count; index++) {
            UILabel *label = (UILabel *)rowLabelMArray[index];
            label.font = font;
            label.textColor = textColor;
            [rowLabelMArray replaceObjectAtIndex:index withObject:label];
        }
        [dateLabelMArray replaceObjectAtIndex:row withObject:rowLabelMArray];
        self.dataLabelArray = [[NSArray alloc]initWithArray:dateLabelMArray];
        
    }else{
        
        if (self.dataLabelArray.count == 0 ) {
            NSLog(@"设置颜色的行数超过了总行数");
            return;
        }else if (row > ([self.dataLabelArray[0] count] - 1)){
            NSLog(@"设置颜色的行数超过了总行数");
            return;
        }
        
        //以列绘制
        NSMutableArray *dateLabelMArray = [[NSMutableArray alloc]initWithArray:self.dataLabelArray];
        for (NSInteger index = 0; index < dateLabelMArray.count; index++) {
            NSMutableArray *rowLabelMArray = dateLabelMArray[index];
            UILabel *label = (UILabel *)rowLabelMArray[row];
            label.font = font;
            label.textColor = textColor;
            [rowLabelMArray replaceObjectAtIndex:row withObject:label];
        }
        self.dataLabelArray = [[NSArray alloc]initWithArray:dateLabelMArray];
        
        
    }
    
}



#pragma mark -- getters and setters
- (NSMutableArray *)rowsLabelArray{
    if (_rowsLabelArray == nil) {
        _rowsLabelArray = [[NSMutableArray alloc]init];
    }
    return _rowsLabelArray;
}

- (NSMutableArray *)rowsSubtitleLabelArray{
    if (_rowsSubtitleLabelArray == nil) {
        _rowsSubtitleLabelArray = [[NSMutableArray alloc]init];
    }
    return _rowsSubtitleLabelArray;
}

- (NSMutableArray *)colsLabelArray{
    if (_colsLabelArray == nil) {
        _colsLabelArray = [[NSMutableArray alloc]init];
    }
    return _colsLabelArray;
}


//设置第一行标题
- (void)setRowNames:(NSArray *)rowNames{
    _rowNames = rowNames;
    [self setTable];
}
//设置第一行副标题
- (void)setRowSubtitleNames:(NSArray *)rowSubtitleNames{
    _rowSubtitleNames = rowSubtitleNames;
    [self setTable];
}
//设置第一列标题
- (void)setColNames:(NSArray *)colNames{
    _colNames = colNames;
    [self setTable];
}


//设置第一行标题颜色
- (void)setRowTitleColor:(UIColor *)rowTitleColor{
    _rowTitleColor = rowTitleColor;
    
    if (self.rowsLabelArray.count > 0) {
        for (UILabel *label in self.rowsLabelArray) {
            label.textColor = rowTitleColor;
        }
    }
    
}
//设置第一行副标题颜色
- (void)setRowSubtitleColor:(UIColor *)rowSubtitleColor{
    _rowSubtitleColor = rowSubtitleColor;
    if (self.rowsSubtitleLabelArray.count > 0) {
        for (UILabel *label in self.rowsSubtitleLabelArray) {
            label.textColor = rowSubtitleColor;
        }
    }
}
//设置第一列标题颜色
- (void)setColTitleColor:(UIColor *)colTitleColor{
    _colTitleColor = colTitleColor;
    if (self.colsLabelArray.count > 0) {
        for (UILabel *label in self.colsLabelArray) {
            label.textColor = colTitleColor;
        }
    }
}


//设置第一行标题字体
- (void)setRowTitleFont:(UIFont *)rowTitleFont{
    _rowTitleFont = rowTitleFont;
    
    if (self.rowsLabelArray.count > 0) {
        for (UILabel *label in self.rowsLabelArray) {
            label.font = rowTitleFont;
        }
    }
    
}
//设置第一行副标题字体
- (void)setRowSubtitleFont:(UIFont *)rowSubtitleFont{
    _rowSubtitleFont = rowSubtitleFont;
    if (self.rowsSubtitleLabelArray.count > 0) {
        for (UILabel *label in self.rowsSubtitleLabelArray) {
            label.font = rowSubtitleFont;
        }
    }
}
//设置第一列标题字体
- (void)setColTitleFont:(UIFont *)colTitleFont{
    _colTitleFont = colTitleFont;
    if (self.colsLabelArray.count > 0) {
        for (UILabel *label in self.colsLabelArray) {
            label.font = _colTitleFont;
        }
    }
}


//以行为单位设置数据
- (void)setRowsDataArray:(NSArray<NSArray *> *)rowsDataArray{
    
    _rowsDataArray = rowsDataArray;
    self.isHorizontal = YES;
    
    [self clearDataLabel];
    
    NSMutableArray *allLabelArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < rowsDataArray.count; i++) {
        
        NSArray *array = rowsDataArray[i];
        
        NSMutableArray *rowLabelArray = [[NSMutableArray alloc]init];
        for (NSInteger j = 0 ; j < array.count; j++) {
            
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:11];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = array[j];
            [self addSubview:label];  //添加第i行第j列的数据文本
            
            
            //当用户设置了某行的字体和颜色的时候
            if (self.font != nil && self.textColor != nil) {
                if (i == self.row) {
                    label.font = self.font;
                    label.textColor = self.textColor;
                }
            }
            
            [rowLabelArray addObject:label];
        }
        
        [allLabelArray addObject:rowLabelArray];
    }
    self.dataLabelArray = [[NSArray alloc]initWithArray:allLabelArray];
}
//以列位单位设置数据
- (void)setColsDataArray:(NSArray<NSArray *> *)colsDataArray{
    _colsDataArray = colsDataArray;
    self.isHorizontal = NO;
    
    [self clearDataLabel];
    
    NSMutableArray *allLabelArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < colsDataArray.count; i++) {
        
        NSArray *array = colsDataArray[i];
        
        NSMutableArray *rowLabelArray = [[NSMutableArray alloc]init];
        for (NSInteger j = 0 ; j < array.count; j++) {
            
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:11];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = array[j];
            [self addSubview:label];  //添加第i列第j行的数据文本
            
            //当用户设置了某行的字体和颜色的时候
            if (self.font != nil && self.textColor != nil) {
                if (j == self.row) {
                    label.font = self.font;
                    label.textColor = self.textColor;
                }
            }
            
            [rowLabelArray addObject:label];
        }
        [allLabelArray addObject:rowLabelArray];
    }
    self.dataLabelArray = [[NSArray alloc]initWithArray:allLabelArray];
}

@end
