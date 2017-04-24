//
//  OMReportsView.h
//  BorgwardSMS
//
//  Created by 印聪 on 2017/4/20.
//  Copyright © 2017年 BORGWARD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMReportsView : UIView


@property (nonatomic , strong)NSArray *rowNames; //第一行的行标题
@property (nonatomic , strong)NSArray *rowSubtitleNames; //第一行的副标题
@property (nonatomic , strong)NSArray *colNames; //第一列的列标题


//数据源,一下两种方式任选一种设置即可。以最后一种赋值方式为准
/**
 * 以行为单位，按照每一行给出数据
 * 00 01 02 03
 * 10 11 12 13
 * 20 21 22 23
 *
 * 如上数据排列时，此时rowsDataArray = @[@[@"00",@"01",@"02",@"03"],@[@"10",@"11",@"12",@"13"],@[@"20",@"21",@"22",@"23"]]
 */
@property (nonatomic , strong)NSArray <NSArray *>*rowsDataArray; //按行给出数据


/**
 * 以列为单位，按照每一列给出数据
 * 00 01 02 03
 * 10 11 12 13
 * 20 21 22 23
 *
 * 如上数据排列时，此时rowsDataArray = @[@[@"00",@"10",@"20"],@[@"01",@"11",@"21"],@[@"02",@"12",@"22"],@[@"03",@"13",@"23"]]
 */
@property (nonatomic , strong)NSArray <NSArray *>*colsDataArray; //按列给出数据


//第一行标题的颜色
@property (nonatomic , strong)UIColor *rowTitleColor;
//第一行副标题的颜色
@property (nonatomic , strong)UIColor *rowSubtitleColor;
//第一列标题的颜色
@property (nonatomic , strong)UIColor *colTitleColor;

//第一行标题的字体
@property (nonatomic , strong)UIFont *rowTitleFont;
//第一行副标题的字体
@property (nonatomic , strong)UIFont *rowSubtitleFont;
//第一列标题的字体
@property (nonatomic , strong)UIFont *colTitleFont;


/**
 设置某行的数据文本的字体、文本颜色

 @param row 行数
 @param font 字体
 @param textColor 字体颜色
 */
- (void)row:(NSInteger)row font:(UIFont *)font textColor:(UIColor *)textColor;

@end
