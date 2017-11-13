//
//  DetailsCategoryViewCell.m
//  CategoryLinkageDemo
//
//  Created by 马朋飞 on 2017/11/11.
//  Copyright © 2017年 马朋飞. All rights reserved.
//

#import "DetailsCategoryViewCell.h"
#import "CellSubButtonViews.h"
#import "DetailsCategoryModel.h"
#import "ThirdCategoryModel.h"

@interface DetailsCategoryViewCell ()
@property (nonatomic, strong) UILabel *titleLabel; // 标题
@property (nonatomic, strong) CellSubButtonViews *cellSubButtonViews; // 按钮集合


@end

@implementation DetailsCategoryViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:13.0];
    titleLabel.textColor = RGB(51,51,51);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    [self.contentView addSubview:titleLabel];
    
    CellSubButtonViews *cellSubButtonViews = [[CellSubButtonViews alloc] initWithMaxItemsCount:27 btnTextFont:12.0];
    // 宽高比
    cellSubButtonViews.autoHeightRatio = 30/76.0;
    self.cellSubButtonViews = cellSubButtonViews;
    [self.contentView addSubview:cellSubButtonViews];
    
    // 开始布局
    self.titleLabel.sd_layout.topSpaceToView(self.contentView, 14.5*kScreenHScale).leftSpaceToView(self.contentView, 15*kScreenScale).autoHeightRatio(0);
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:190];
    self.cellSubButtonViews.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).topSpaceToView(titleLabel, 10.5*kScreenHScale);
    
    
    
}

- (void)setDetailsCategoryModel:(DetailsCategoryModel *)detailsCategoryModel {
    _detailsCategoryModel = detailsCategoryModel;
    self.titleLabel.text = detailsCategoryModel.name;
    NSMutableArray *tempArr = [NSMutableArray array];
    NSMutableArray *IDArr = [NSMutableArray array];
    for (ThirdCategoryModel *model in detailsCategoryModel.infoList) {
        [tempArr addObject:model.name];
    }
    _cellSubButtonViews.skillName = detailsCategoryModel.name;
    _cellSubButtonViews.infoList = detailsCategoryModel.infoList;
    _cellSubButtonViews.IDsArr = IDArr;
    _cellSubButtonViews.titleNamesArray = tempArr;
    if (tempArr.count > 0) {
        _cellSubButtonViews.hidden = NO;
    } else {
        _cellSubButtonViews.hidden = YES;
        _cellSubButtonViews.sd_layout.heightIs(0);
    }
    
    [self setupAutoHeightWithBottomView:self.cellSubButtonViews bottomMargin:0];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
