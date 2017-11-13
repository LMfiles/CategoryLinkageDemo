//
//  ViewController.m
//  CategoryLinkageDemo
//
//  Created by 马朋飞 on 2017/11/11.
//  Copyright © 2017年 马朋飞. All rights reserved.
//

#import "ViewController.h"
#import "AllCategoryViewController.h"

#define kTopBarContentMarginTop (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")?statusBarHeight():0.f)
#define kTopBarHeight (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")?(kTopBarContentMarginTop+44.f):44.f)

@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation ViewController

#pragma mark 懒加载
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kScreenWidth, kScreenHeight - kTopBarHeight) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.backgroundColor = [UIColor lightGrayColor];
        if (@available(iOS 11.0, *)) {
            _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        _myTableView.rowHeight = 44.0f;
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iOS瞎搞😁";
    
    [self.view addSubview:self.myTableView];
   
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"点我啊";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AllCategoryViewController *next  = [[AllCategoryViewController alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


UIInterfaceOrientation interfaceOrientation(void) {
UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
return orientation;
}

CGFloat statusBarHeight(void) {
if ([[UIApplication sharedApplication] isStatusBarHidden]) return 0.0;
if (UIInterfaceOrientationIsLandscape(interfaceOrientation()))
return [[UIApplication sharedApplication] statusBarFrame].size.width;
else
return [[UIApplication sharedApplication] statusBarFrame].size.height;
}


@end
