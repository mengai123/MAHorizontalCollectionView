//
//  MAItemCell.m
//  TairanTV
//
//  Created by mengai on 2017/5/13.
//  Copyright © 2017年 mengai. All rights reserved.
//

#import "MAItemCell.h"

@interface MAItemCell()

@property (nonatomic, strong) UIImageView *itemIcon;
@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation MAItemCell
@synthesize itemModel = _itemModel;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}


- (void)initView
{
    _itemIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_itemIcon];
    [_itemIcon makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(45, 45));
        make.top.equalTo(self.top).with.offset(2);
        make.centerX.equalTo(self.contentView);
    }];
    
    _itemLabel = [[UILabel alloc] init];
    _itemLabel.font = fontSystem(10);
    _itemLabel.textColor = [UIColor whiteColor];
    _itemLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_itemLabel];
    [_itemLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_itemIcon.bottom).with.offset(5);
        make.left.and.right.equalTo(self.contentView);
        make.height.equalTo(10);
    }];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = fontSystem(8);
    _priceLabel.textColor = RGBAHex(0xffffff, 0.5);
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_priceLabel];
    [_priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_itemLabel.bottom).with.offset(5);
        make.left.and.right.equalTo(self.contentView);
        make.height.equalTo(8);
    }];
}

- (MAApiItemItemModel *)itemModel
{
    return _itemModel;
}

- (void)setItemModel:(MAApiItemItemModel *)itemModel
{
    if (!itemModel) {
        return;
    }
    _itemModel = itemModel;
    
    [self setCellWithModel:_itemModel];
}

- (void)setCellWithModel:(MAApiItemItemModel *)itemModel
{
    if (!itemModel.isMock) {
        
        _itemIcon.image = [UIImage imageNamed:itemModel.imageName];
        _itemLabel.text = itemModel.itemName;
        _priceLabel.text = [NSString stringWithFormat:@"%ld",(long)itemModel.itemPrice];
    }else{
        [_itemIcon setImage:nil];
        _itemLabel.text = nil;
        _priceLabel.text = nil;
    }
}

@end
