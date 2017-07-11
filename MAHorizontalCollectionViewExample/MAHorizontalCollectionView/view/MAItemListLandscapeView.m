//
//  MAItemListLandscapeView.m
//  TairanTV
//
//  Created by mengai on 2017/7/5.
//  Copyright © 2017年 mengai. All rights reserved.
//

#import "MAItemListLandscapeView.h"
#import "MAItemCell.h"


static const CGFloat LandscapeItemListViewWidth = 250; // 横屏礼物菜单的宽度
static NSString *const ItemLandscapeCollectionCellIdentifier = @"ItemLandscapeCollectionCellIdentifier";

@interface MAItemListLandscapeView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIScrollView *bgScrollView;

@end

@implementation MAItemListLandscapeView
@synthesize listsData = _listsData;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
        _bgScrollView = [[UIScrollView alloc] init];
        _bgScrollView.delegate = self;
        _bgScrollView.pagingEnabled = YES;
        _bgScrollView.tag = 1000;
        _bgScrollView.alwaysBounceHorizontal = YES;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_bgScrollView];
        [_bgScrollView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self layoutIfNeeded];
    }
    return self;
}

- (void)setListsData:(NSArray *)listsData
{
    if (!listsData || listsData == _listsData) {
        return;
    }
    
    _listsData = listsData;
    
    [self initCollectionViews];
}

- (NSArray *)listsData
{
    return _listsData;
}

- (void)initCollectionViews
{
    _bgScrollView.contentSize = CGSizeMake(LandscapeItemListViewWidth * _listsData.count, self.height_t);
    

    CGFloat x_offset = 0;
    for (NSInteger i = 0; i < _listsData.count; i++) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(75, 75);
        flowLayout.minimumInteritemSpacing = 25/4;
        
        CGRect frame = CGRectMake(x_offset, 15, LandscapeItemListViewWidth, _bgScrollView.height_t - 15);
        UICollectionView *landscapeCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        landscapeCollectionView.tag = 100+i;
        landscapeCollectionView.dataSource = self;
        landscapeCollectionView.delegate = self;
        landscapeCollectionView.alwaysBounceHorizontal = NO;
        landscapeCollectionView.alwaysBounceVertical = YES;
        landscapeCollectionView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        landscapeCollectionView.showsHorizontalScrollIndicator = NO;
        landscapeCollectionView.showsVerticalScrollIndicator = NO;
        [_bgScrollView addSubview:landscapeCollectionView];
        
        NSString *identifier = [NSString stringWithFormat:@"ItemLandscapeCollectionCellIdentifier_%ld",landscapeCollectionView.tag];
        [landscapeCollectionView registerClass:[MAItemCell class] forCellWithReuseIdentifier:identifier];
        
        x_offset += LandscapeItemListViewWidth;
        [landscapeCollectionView reloadData];
    }
    [self layoutIfNeeded];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(75, 75);
}

#pragma mark - UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger groupIndex = collectionView.tag - 100;
    MAApiItemListModel *listModel = _listsData[groupIndex];
    
    return listModel.itemList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger groupIndex = collectionView.tag - 100;
    MAApiItemListModel *listModel = _listsData[groupIndex];
    MAApiItemItemModel *itemModel = listModel.itemList[indexPath.row];
    
    NSString *identifier = [NSString stringWithFormat:@"ItemLandscapeCollectionCellIdentifier_%ld",collectionView.tag];
    MAItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.itemModel = itemModel;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger groupIndex = collectionView.tag - 100;
    MAApiItemListModel *listModel = _listsData[groupIndex];
    
    MAApiItemItemModel *itemModel = listModel.itemList[indexPath.row];
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    CGRect cellRect = [collectionView convertRect:cell.frame toView:self.aimView];
    CGPoint cellPoint = [collectionView convertPoint:cell.center toView:self.aimView];
    
    if (self.landscapeActionBlock) {
        self.landscapeActionBlock(LandscapeActionTypeSelectItem, 0, itemModel, cellRect, cellPoint, NO);
    }
}

#pragma mark - ScrollView Actions
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.landscapeActionBlock) {
        self.landscapeActionBlock(LandscapeActionTypeDrag, 0, nil, CGRectZero , CGPointZero, NO);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag != 1000) {
        //只有滑动背景scrollView才能触发
        return;
    }
    NSInteger page = floor((scrollView.contentOffset.x - scrollView.width_t / 2) / scrollView.width_t) + 1; //round(scrollView.contentOffset.x / scrollView.width_t);
    if (page < 0) {
        page = 0;
    }
    else if (page >= _listsData.count) {
        page = _listsData.count - 1;
    }
    
    if (self.landscapeActionBlock) {
        self.landscapeActionBlock(LandscapeActionTypeScrollToPage, page, nil, CGRectZero, CGPointZero, NO);
    }
}

- (void)selectGroup:(NSInteger)groupIndex withAnimated:(BOOL)animated
{
    if(!_listsData) {
        return;
    }

    [_bgScrollView setContentOffset:CGPointMake(LandscapeItemListViewWidth * groupIndex, 0) animated:animated];
    
    if (self.landscapeActionBlock) {
        self.landscapeActionBlock(LandscapeActionTypeScrollToPage, groupIndex, nil, CGRectZero, CGPointZero, YES);
    }
}

- (void)locatedItem:(MAApiItemItemModel *)itemModel positionBlock:(void (^)(CGRect, CGPoint))block
{
    if (!itemModel) {
        return;
    }
    
    NSInteger groupIndex = 0;
    for (NSInteger i = 0; i < _listsData.count; i++) {
        
        MAApiItemListModel *listModel = _listsData[i];
        if (listModel.itemTypeId == itemModel.itemTypeId) {
            //找到大类
            groupIndex = i;
            break;
        }
    }
    
    UICollectionView *selectCollectionView = [_bgScrollView viewWithTag:100+groupIndex];
    
    MAApiItemListModel *listModel = _listsData[groupIndex];
    
    NSInteger rowIndex = 0;
    for (NSInteger j = 0; j < listModel.itemList.count; j++) {
        
        MAApiItemItemModel *item = listModel.itemList[j];
        if (item.itemInfoId == itemModel.itemInfoId) {
            //找到对应item
            rowIndex = j;
            break;
        }
    }
    
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:rowIndex inSection:0];
    [selectCollectionView scrollToItemAtIndexPath:selectIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
    [self layoutIfNeeded];
    UICollectionViewCell *selectedCell = [selectCollectionView cellForItemAtIndexPath:selectIndexPath];
    
    CGRect cellRect = [selectCollectionView convertRect:selectedCell.frame toView:self.aimView];
    CGPoint cellPoint = [selectCollectionView convertPoint:selectedCell.center toView:self.aimView];
    
    if (block) {
        block(cellRect,cellPoint);
    }
}

@end
