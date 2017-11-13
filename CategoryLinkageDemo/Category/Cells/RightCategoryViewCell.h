//
//  RightCategoryViewCell.h
//  CategoryLinkageDemo
//
//  Created by 马朋飞 on 2017/11/11.
//  Copyright © 2017年 马朋飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RightCategoryViewCellDelegate;

@interface RightCategoryViewCell : UITableViewCell
@property (nonatomic, weak) id<RightCategoryViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) NSInteger maxCount;
@property (nonatomic, strong) NSArray *listDetailsCategory;


@end

@protocol RightCategoryViewCellDelegate <NSObject>
- (void)callMeScrollViewDirection:(LMScrollViewDirection)scrollViewDirection indexPath:(NSIndexPath *)indexPath;

@end
