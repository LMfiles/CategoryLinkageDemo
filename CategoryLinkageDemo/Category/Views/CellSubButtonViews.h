//
//  CellSubButtonViews.h
//  CategoryLinkageDemo
//
//  Created by 马朋飞 on 2017/11/11.
//  Copyright © 2017年 马朋飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ThirdCategoryModel;

@protocol CellSubButtonViewsDelegate;


@interface CellSubButtonViews : UIView
- (instancetype)initWithMaxItemsCount:(NSInteger)count btnTextFont:(CGFloat)font;

@property (nonatomic, strong) NSArray *titleNamesArray;

@property (nonatomic, assign) NSInteger maxItemsCount;

@property (nonatomic, assign) CGFloat autoHeightRatio;

@property (nonatomic, strong) NSArray *IDsArr;
@property (nonatomic, assign) NSInteger type; //0 发需求  1 发技能 3全部品类

@property (nonatomic, strong) NSArray<ThirdCategoryModel *> *infoList;
@property (nonatomic, copy) NSString *skillID; // 二级类目ID
@property (nonatomic, copy) NSString *skillName; // 二级类目名字


@property (nonatomic, weak) id<CellSubButtonViewsDelegate> delegate;

@end

@protocol CellSubButtonViewsDelegate <NSObject>
- (void)eventTouchUpInsideWithTag:(NSInteger)tag;

@end
