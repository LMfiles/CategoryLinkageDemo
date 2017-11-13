//
//  DetailsCategoryViewCell.h
//  CategoryLinkageDemo
//
//  Created by 马朋飞 on 2017/11/11.
//  Copyright © 2017年 马朋飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailsCategoryModel;

@interface DetailsCategoryViewCell : UITableViewCell
@property (nonatomic, strong) NSArray *dataSourceArr;
@property (nonatomic, strong) DetailsCategoryModel *detailsCategoryModel;


@end
