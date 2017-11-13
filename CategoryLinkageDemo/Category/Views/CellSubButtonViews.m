//
//  CellSubButtonViews.m
//  CategoryLinkageDemo
//
//  Created by 马朋飞 on 2017/11/11.
//  Copyright © 2017年 马朋飞. All rights reserved.
//

#import "CellSubButtonViews.h"
#import "ThirdCategoryModel.h"
@implementation CellSubButtonViews

{
    NSMutableArray *_btnViewsArray;
    CGFloat _font;
    NSString *name;
    NSString *ids;
}

- (instancetype)initWithMaxItemsCount:(NSInteger)count btnTextFont:(CGFloat)font
{
    if (self = [super init]) {
        self.maxItemsCount = count;
        _font = font;
    }
    return self;
}

- (void)setTitleNamesArray:(NSArray *)titleNamesArray
{
    _titleNamesArray = titleNamesArray;
    
    if (!_btnViewsArray) {
        _btnViewsArray = [NSMutableArray new];
    }
    
    int needsToAddItemsCount = (int)(_titleNamesArray.count - _btnViewsArray.count);
    
    if (needsToAddItemsCount > 0) {
        for (int i = 0; i < needsToAddItemsCount; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.font = [UIFont systemFontOfSize:_font];
            [button setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
            [button setBackgroundColor:RGB(248, 248, 248)];
            button.tag = 10000+i;
            [button addTarget:self action:@selector(handleDownAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [_btnViewsArray addObject:button];
        }
    }
    
    NSMutableArray *temp = [NSMutableArray new];
    
    [_btnViewsArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        if (idx < _titleNamesArray.count) {
            button.hidden = NO;
            button.sd_layout.autoHeightRatio(self.autoHeightRatio);
            [button setTitle:_titleNamesArray[idx] forState:UIControlStateNormal];
            [temp addObject:button];
        } else {
            [button sd_clearAutoLayoutSettings];
            button.hidden = YES;
        }
    }];
    
    [self setupAutoWidthFlowItems:[temp copy] withPerRowItemsCount:3 verticalMargin:7*kScreenHScale horizontalMargin:7*kScreenScale verticalEdgeInset:8*kScreenHScale horizontalEdgeInset:15*kScreenScale];
}

- (void)handleDownAction:(UIButton *)sender {
#pragma mark 这里自定义点击事件，也可以使用代理将事件传递出去
}

@end
