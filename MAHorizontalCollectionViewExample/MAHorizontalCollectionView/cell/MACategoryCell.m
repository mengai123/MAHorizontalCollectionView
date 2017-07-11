//
//  MACategoryCell.m
//  TairanTV
//
//  Created by mengai on 2017/5/13.
//  Copyright © 2017年 mengai. All rights reserved.
//

#import "MACategoryCell.h"

@interface MACategoryCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MACategoryCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initLabel];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    }
    return self;
}

- (void)initLabel
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = RGBAHex(0xffffff, 0.6);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = fontSystem(10);
    [self addSubview:_titleLabel];
    
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(10);
        make.left.equalTo(self).with.offset(5);
        make.right.equalTo(self).with.offset(-5);
        make.centerY.equalTo(self);
    }];
    
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        _titleLabel.textColor = [UIColor whiteColor];
    }else{
        _titleLabel.textColor = RGBAHex(0xffffff, 0.6);
    }
}

- (void)setCell:(MAApiItemListModel *)listModel
{
    _titleLabel.text = listModel.itemTypeName;
}

@end
