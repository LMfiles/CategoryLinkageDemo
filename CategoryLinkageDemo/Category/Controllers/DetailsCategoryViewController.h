//
//  DetailsCategoryViewController.h
//  CategoryLinkageDemo
//
//  Created by 马朋飞 on 2017/11/11.
//  Copyright © 2017年 马朋飞. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DetailsCategoryViewControllerDelegate;

@interface DetailsCategoryViewController : UIViewController
@property (nonatomic, weak) id<DetailsCategoryViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *listDetailsCategory;
@property (nonatomic, copy) NSString *topBarTitle;
@property (nonatomic, strong) NSIndexPath *chooseIndexPath; // 选中的位置


@end

@protocol DetailsCategoryViewControllerDelegate <NSObject>
- (void)callMeScrollViewDirection:(LMScrollViewDirection)scrollViewDirection indexPath:(NSIndexPath *)indexPath;

@end
