//
//  RightCategoryViewCell.m
//  CategoryLinkageDemo
//
//  Created by 马朋飞 on 2017/11/11.
//  Copyright © 2017年 马朋飞. All rights reserved.
//

#import "RightCategoryViewCell.h"
#import "DetailsCategoryViewCell.h"

NSString *const myKeyPathContentOffset = @"contentOffset";


#define kDetailsCategoryViewCell @"DetailsCategoryViewCell.h"


@interface RightCategoryViewCell ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MJRefreshNormalHeader *refreshHeader;
@property (nonatomic, strong) MJRefreshBackNormalFooter *refreshFooter;


@end

@implementation RightCategoryViewCell

#pragma mark 懒加载

- (UIView *)backGroundView {
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc] init];
    }
    return _backGroundView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        [_tableView registerClass:[DetailsCategoryViewCell class] forCellReuseIdentifier:kDetailsCategoryViewCell];
    }
    return _tableView;
}

- (MJRefreshNormalHeader *)refreshHeader {
    if (!_refreshHeader) {
        _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeaderOfPreviousPage)];
        _refreshHeader.lastUpdatedTimeLabel.hidden = YES;
        _refreshHeader.arrowView.hidden = YES;
        // 设置文字
        [_refreshHeader setTitle:@"下拉进入上一页" forState:MJRefreshStateIdle];
        [_refreshHeader setTitle:@"松开进入上一页" forState:MJRefreshStatePulling];
        [_refreshHeader setTitle:@"正在进入上一页" forState:MJRefreshStateRefreshing];
    }
    return _refreshHeader;
}

- (MJRefreshBackNormalFooter *)refreshFooter {
    if (!_refreshFooter) {
        _refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooterOfNextPage)];
        _refreshFooter.arrowView.hidden = YES;
        // 设置文字
        [_refreshFooter setTitle:@"上拉进入下一页" forState:MJRefreshStateIdle];
        [_refreshFooter setTitle:@"松开进入下一页" forState:MJRefreshStatePulling];
        [_refreshFooter setTitle:@"正在进入下一页" forState:MJRefreshStateRefreshing];
    }
    return _refreshFooter;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.backGroundView];
        [self.backGroundView addSubview:self.tableView];
        self.backGroundView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    if (indexPath.row!=0) {
        [self.refreshHeader setHidden:NO];
        self.tableView.mj_header = self.refreshHeader;
    }else {
        [self.refreshHeader setHidden:YES];
    }
    if (indexPath.row!=self.maxCount-1) {
        [self.refreshFooter setHidden:NO];
        self.tableView.mj_footer = self.refreshFooter;
    }else {
        [self.refreshFooter setHidden:YES];
    }
    
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listDetailsCategory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailsCategoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDetailsCategoryViewCell forIndexPath:indexPath];
    if (self.listDetailsCategory.count>0) {
        cell.detailsCategoryModel = self.listDetailsCategory[indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailsCategoryModel *model = self.listDetailsCategory[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"detailsCategoryModel" cellClass:[DetailsCategoryViewCell class] contentViewWidth:self.contentView.size.width];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)refreshHeaderOfPreviousPage {
    if ([self.delegate respondsToSelector:@selector(callMeScrollViewDirection:indexPath:)] && self.indexPath.row!=0) {
        [self.tableView.mj_header endRefreshing];
        [self.delegate callMeScrollViewDirection:LMScrollViewDirectionDown indexPath:self.indexPath];
    }else {
        [self.tableView.mj_header endRefreshing];
    }
}

- (void)refreshFooterOfNextPage {
    if ([self.delegate respondsToSelector:@selector(callMeScrollViewDirection:indexPath:)] && self.indexPath.row!=self.maxCount-1) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
        [self.delegate callMeScrollViewDirection:LMScrollViewDirectionTop indexPath:self.indexPath];
    }else {
        [self.tableView.mj_footer endRefreshing];
    }
    
}

- (void)setListDetailsCategory:(NSArray *)listDetailsCategory {
    _listDetailsCategory = listDetailsCategory;
    
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
