//
//  DetailsCategoryViewController.m
//  CategoryLinkageDemo
//
//  Created by 马朋飞 on 2017/11/11.
//  Copyright © 2017年 马朋飞. All rights reserved.
//

#import "DetailsCategoryViewController.h"
#import "RightCategoryViewCell.h"
#import "DetailsCategoryViewCell.h"
#import "AllCategoryModel.h"

#define kRightCategoryViewCell @"RightCategoryViewCell.h"
#define kDetailsCategoryViewCell @"DetailsCategoryViewCell.h"

@interface DetailsCategoryViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
RightCategoryViewCellDelegate
>
@property (nonatomic, strong) UITableView *myTableView;


@end

@implementation DetailsCategoryViewController

#pragma mark 懒加载

- (UITableView *)myTableView {
    if (!_myTableView) {
        CGFloat leftSpace = 90*kScreenScale; // 左边距离
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(leftSpace, 64, kScreenWidth-leftSpace, kScreenHeight - 64) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
#pragma mark 设置不能滑动，否则会滑动的乱七八糟
        _myTableView.scrollEnabled = NO;
        if (@available(iOS 11.0, *)) {
            _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        [_myTableView registerClass:[RightCategoryViewCell class] forCellReuseIdentifier:kRightCategoryViewCell];
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部品类";
    
    [self.view addSubview:self.myTableView];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listDetailsCategory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RightCategoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRightCategoryViewCell forIndexPath:indexPath];
    cell.delegate = self;
    cell.maxCount = self.listDetailsCategory.count;
    cell.indexPath = indexPath;
    if (self.listDetailsCategory.count>0) {
        AllCategoryModel *model = self.listDetailsCategory[indexPath.row];
        cell.listDetailsCategory = model.infoList;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenHeight - 64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)setListDetailsCategory:(NSArray *)listDetailsCategory {
    _listDetailsCategory = listDetailsCategory;
    [self.myTableView reloadData];
}

- (void)setChooseIndexPath:(NSIndexPath *)chooseIndexPath {
    _chooseIndexPath = chooseIndexPath;
    if (chooseIndexPath.row!=self.listDetailsCategory.count-1) {
        [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chooseIndexPath.row inSection:chooseIndexPath.section] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    }else if (chooseIndexPath.row!=0) {
        [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chooseIndexPath.row inSection:chooseIndexPath.section] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    }
}

#pragma mark RightCategoryViewCellDelegate
- (void)callMeScrollViewDirection:(LMScrollViewDirection)scrollViewDirection indexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(callMeScrollViewDirection:indexPath:)]) {
        [self.delegate callMeScrollViewDirection:scrollViewDirection indexPath:indexPath];
    }
    if (scrollViewDirection == LMScrollViewDirectionTop && indexPath.row!=self.listDetailsCategory.count-1) {
        [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }else if (scrollViewDirection == LMScrollViewDirectionDown && indexPath.row!=0) {
        [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

