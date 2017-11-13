//
//  AllCaregoryLeftViewCell.m
//  CategoryLinkageDemo
//
//  Created by 马朋飞 on 2017/11/11.
//  Copyright © 2017年 马朋飞. All rights reserved.
//

#import "AllCaregoryLeftViewCell.h"


@interface AllCaregoryLeftViewCell ()

@end

@implementation AllCaregoryLeftViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(15*kScreenScale, 0, 100*kScreenScale, 50*kScreenHScale)];
        self.titleLable.font = [UIFont systemFontOfSize:14.0];
        self.titleLable.textColor = RGB(51, 51, 51);
        self.titleLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.titleLable];
        self.backgroundColor = RGB(246, 246, 246);
    }
    return self;
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLable.text = titleStr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
