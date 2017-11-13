//
//  AllCategoryViewController.m
//  CategoryLinkageDemo
//
//  Created by 马朋飞 on 2017/11/11.
//  Copyright © 2017年 马朋飞. All rights reserved.
//

#import "AllCategoryViewController.h"
#import "AllCaregoryLeftViewCell.h"
#import "DetailsCategoryViewController.h"
#import "AllCategoryModel.h"


#define kAllCaregoryLeftViewCell @"AllCaregoryLeftViewCell.h"

@interface AllCategoryViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate,
DetailsCategoryViewControllerDelegate
>
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) DetailsCategoryViewController *detailsCategoryViewControlle;
@property (nonatomic, strong) UIView *selectionView; // 选择标记
@property (nonatomic, strong) NSArray *dataSourceArr; // 数据源
@property (nonatomic, strong) NSIndexPath *selectionIndexPath; // 记录选中位置


@end

@implementation AllCategoryViewController

#pragma mark 懒加载
- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 90*kScreenScale, kScreenHeight - 64) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView.showsVerticalScrollIndicator = NO;
        [_leftTableView addSubview:self.selectionView];
        if (@available(iOS 11.0, *)) {
            _leftTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        [_leftTableView registerClass:[AllCaregoryLeftViewCell class] forCellReuseIdentifier:kAllCaregoryLeftViewCell];
        _leftTableView.backgroundColor = RGB(246, 246, 246);
    }
    return _leftTableView;
}

- (UIView *)selectionView {
    if (!_selectionView) {
        _selectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 15.5*kScreenHScale, 4.0*kScreenScale, 18*kScreenHScale)];
        _selectionView.backgroundColor = RGB(255,192,40);
    }
    return _selectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部品类";
    
    self.detailsCategoryViewControlle = [[DetailsCategoryViewController alloc] init];
    [self addChildViewController:self.detailsCategoryViewControlle];
    [self.view addSubview:self.detailsCategoryViewControlle.view];
    [self.view addSubview:self.leftTableView];
    self.detailsCategoryViewControlle.delegate = self;
    
    if (!_selectionIndexPath) {
        self.selectionIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    [self loadData];
    
}

#pragma mark 数据请求
- (void)loadData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DataSource" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error = nil;
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    self.dataSourceArr = [NSArray yy_modelArrayWithClass:[AllCategoryModel class] json:jsonArr];
    self.detailsCategoryViewControlle.listDetailsCategory = self.dataSourceArr;
    [self.leftTableView reloadData];
    /// 设置默认选中行
    [self.leftTableView selectRowAtIndexPath:self.selectionIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark UITableViewDelegate , UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AllCaregoryLeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAllCaregoryLeftViewCell forIndexPath:indexPath];
    if ([indexPath isEqual:self.selectionIndexPath]) {
        [self setLeftTablewCellSelected:YES withCell:cell rows:0];
    }else {
        [self setLeftTablewCellSelected:NO withCell:cell rows:0];
    }
    if (self.dataSourceArr.count!=0) {
        AllCategoryModel *model = self.dataSourceArr[indexPath.row];
        cell.titleStr = model.name;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50*kScreenHScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    AllCaregoryLeftViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self setLeftTablewCellSelected:NO withCell:cell rows:-1];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectionIndexPath != indexPath) {
        AllCaregoryLeftViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self setLeftTablewCellSelected:YES withCell:cell rows:indexPath.row-self.selectionIndexPath.row];
        self.selectionIndexPath = indexPath;
        self.detailsCategoryViewControlle.chooseIndexPath = indexPath;
    }
}


- (void)setLeftTablewCellSelected:(BOOL)selected withCell:(AllCaregoryLeftViewCell *)cell rows:(NSInteger)rows {
    if (selected) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect oldFrame = self.selectionView.frame;
            cell.backgroundColor = RGB(255,255,255);
            CGRect newFrame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y + rows*50*kScreenHScale, oldFrame.size.width, oldFrame.size.height);
            self.selectionView.frame = newFrame;
        }];
        [UIView animateWithDuration:1.0 animations:^{
            cell.titleLable.font = [UIFont boldSystemFontOfSize:15.0];
        }];
        
    }else{
        [UIView animateWithDuration:1.0 animations:^{
            cell.backgroundColor = RGB(246,246,246);
            cell.titleLable.font = [UIFont systemFontOfSize:14.0];
        }];
        
    }
    
    
}

#pragma mark DetailsCategoryViewControllerDelegate
- (void)callMeScrollViewDirection:(LMScrollViewDirection)scrollViewDirection indexPath:(NSIndexPath *)indexPath {
    AllCaregoryLeftViewCell *seleactCell = [self.leftTableView cellForRowAtIndexPath:indexPath];
    [self setLeftTablewCellSelected:NO withCell:seleactCell rows:0];
    if (scrollViewDirection==LMScrollViewDirectionDown) {
        NSIndexPath *tempIndex = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
        AllCaregoryLeftViewCell *cell = [self.leftTableView cellForRowAtIndexPath:tempIndex];
        [self setLeftTablewCellSelected:YES withCell:cell rows:-1];
        [self.leftTableView selectRowAtIndexPath:tempIndex animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self.leftTableView scrollToRowAtIndexPath:tempIndex atScrollPosition:UITableViewScrollPositionNone animated:YES];
        self.selectionIndexPath = tempIndex;
    }else {
        NSIndexPath *tempIndex = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
        AllCaregoryLeftViewCell *cell = [self.leftTableView cellForRowAtIndexPath:tempIndex];
        [self setLeftTablewCellSelected:YES withCell:cell rows:1];
        [self.leftTableView selectRowAtIndexPath:tempIndex animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self.leftTableView scrollToRowAtIndexPath:tempIndex atScrollPosition:UITableViewScrollPositionNone animated:YES];
        self.selectionIndexPath = tempIndex;
    }
    //    [self.leftTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
