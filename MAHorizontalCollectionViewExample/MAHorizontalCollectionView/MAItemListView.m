//
//  MAItemListView.m
//  TairanTV
//
//  Created by mengai on 2017/5/13.
//  Copyright © 2017年 mengai. All rights reserved.
//

#import "MAItemListView.h"

#import "MACategoryCell.h"
#import "MAPageControl.h"

#import "MAItemListViewModel.h"

#import "MAItemListPortraitView.h"
#import "MAItemListLandscapeView.h"

static const CGFloat ItemListViewHeight = 229; // 礼物菜单的高度
static const CGFloat RightItemListViewWidth = 250; // 横屏礼物菜单的宽度

static NSString *const ItemCategoryCollectionCellIdentifier = @"ItemCategoryCollectionCellIdentifier";

@interface MAItemListView()<UICollectionViewDelegate>
//--------------------view----------------------
//顶部背景条
@property (nonatomic, strong) UIView *itemBarBGView;
//顶部类别
@property (nonatomic, strong) UICollectionView *barCollectionView;
//透明背景按钮
@property (nonatomic, strong) UIButton *bgButton;
//礼物面板背景
@property (nonatomic, strong) UIView *itemBgView;
//竖屏礼物
@property (nonatomic, strong) MAItemListPortraitView *itemListPortraitView;
//横屏礼物
@property (nonatomic, strong) MAItemListLandscapeView *itemListLandscapeView;
//分页
@property (nonatomic, strong) MAPageControl *pageControl;

//--------------------数据----------------------
//当前选中的礼物分类索引
@property (nonatomic, assign) NSInteger currentSelectedGroupIndex;
//分类collectionView viewModel
@property (nonatomic, strong) MAItemListViewModel *barListViewModel;
//当前选中的礼物
@property (nonatomic, strong) MAApiItemItemModel *currentSelectedItemModel;

@end

@implementation MAItemListView
@synthesize itemListLayoutType = _itemListLayoutType;

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //背景按钮
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton.backgroundColor = [UIColor clearColor];
        [self addSubview:_bgButton];
        
        [_bgButton makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        _itemBgView = [[UIView alloc] init];
        _itemBgView.userInteractionEnabled = YES;
        [_bgButton addSubview:_itemBgView];
        
        [_itemBgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.and.bottom.equalTo(_bgButton);
            make.height.equalTo(ItemListViewHeight);
        }];
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        [_itemBgView addSubview:effectView];
        [effectView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_itemBgView);
        }];
        
        self.userInteractionEnabled = YES;
        
        [self createViews];
    }
    return self;
}

- (void)createViews
{
    //顶部背景
    _itemBarBGView = [[UIView alloc] init];
    _itemBarBGView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [_itemBgView addSubview:_itemBarBGView];
    
    [_itemBarBGView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.right.equalTo(_itemBgView);
        make.height.equalTo(35);
    }];
    
    //横线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGBAHex(0xffffff, 1);
    [_itemBarBGView addSubview:line];
    
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_itemBgView);
        make.bottom.equalTo(_itemBarBGView.bottom).with.offset(-0.5);
        make.height.equalTo(0.5);
    }];
    
    //顶部分类
    [self initParentCollention];
    
    //分页
    _pageControl = [[MAPageControl alloc] init];
    _pageControl.currentPage = 0;
    _pageControl.hidesForSinglePage = YES;
    _pageControl.normalImage = [UIImage imageNamed:@"pageControl_normal"];
    _pageControl.selectedImage = [UIImage imageNamed:@"pageControl_selected"];
    [_itemBgView addSubview:_pageControl];
    
    [_pageControl makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_itemBgView);
        make.height.equalTo(5);
        make.bottom.equalTo(_itemBgView).with.offset(-5);
    }];
    
    [self layoutIfNeeded];
    [self itemListPortraitView];
}

- (MAItemListPortraitView *)itemListPortraitView
{
    if (!_itemListPortraitView) {
        _itemListPortraitView = [[MAItemListPortraitView alloc] init];
        _itemListPortraitView.aimView = self.itemBgView;
        WEAKSELF
        _itemListPortraitView.portraitPageBlock = ^(NSInteger currentGroupIndex, NSInteger currentGroupPageCount, NSInteger pageIndexInCurrentGroup) {
            [weakSelf.pageControl setNumberOfPages:currentGroupPageCount];
            [weakSelf.pageControl setCurrentPage:pageIndexInCurrentGroup];
        };
        _itemListPortraitView.portraitActionBlock = ^(PortraitActionType actionType, NSInteger selectIndexRow, MAApiItemItemModel *itemModel, CGRect aimRect, CGPoint aimPoint, BOOL isSystemAuto) {
            
            switch (actionType) {
                case PortraitActionTypeDrag:
                case PortraitActionTypeSelectMock:
                {
                    //隐藏sendView
                }
                    break;
                case PortraitActionTypeSelectItem:
                {
                    //选中某个item
                    if (!itemModel) {
                        return ;
                    }
                    
                    
                    weakSelf.currentSelectedItemModel = itemModel;
                }
                    break;
                case PortraitActionTypeScrollToPage:
                {
                    NSIndexPath *aimIndexPath = [NSIndexPath indexPathForRow:selectIndexRow inSection:0];
                    [weakSelf.barCollectionView selectItemAtIndexPath:aimIndexPath
                                                             animated:YES
                                                       scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
                    weakSelf.currentSelectedGroupIndex = selectIndexRow;
                }
                    break;
                    
                default:
                    break;
            }
        };
        
        [_itemBgView addSubview:_itemListPortraitView];
        [_itemListPortraitView makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(_itemBgView);
            make.height.equalTo(150);
            make.top.equalTo(_itemBarBGView.bottom).with.offset(20);
        }];
        [self layoutIfNeeded];
    }
    return _itemListPortraitView;
}

- (MAItemListLandscapeView *)itemListLandscapeView
{
    if (!_itemListLandscapeView) {
        _itemListLandscapeView = [[MAItemListLandscapeView alloc] init];
        _itemListLandscapeView.aimView = self.itemBgView;
        WEAKSELF
        _itemListLandscapeView.landscapeActionBlock = ^(LandscapeActionType actionType, NSInteger selectIndexRow ,MAApiItemItemModel *itemModel, CGRect aimRect, CGPoint aimPoint, BOOL isSystemAuto) {
            
            switch (actionType) {
                case LandscapeActionTypeDrag:
                case LandscapeActionTypeSelectMock:
                {
                    
                }
                    break;
                case LandscapeActionTypeSelectItem:
                {
                    //选中某个item
                    if (!itemModel) {
                        return ;
                    }
                    
                    weakSelf.currentSelectedItemModel = itemModel;
                }
                    break;
                case LandscapeActionTypeScrollToPage:
                {
                    NSIndexPath *aimIndexPath = [NSIndexPath indexPathForRow:selectIndexRow inSection:0];
                    [weakSelf.barCollectionView selectItemAtIndexPath:aimIndexPath
                                                             animated:YES
                                                       scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
                    weakSelf.currentSelectedGroupIndex = selectIndexRow;
                }
                    break;
                default:
                    break;
            }
            
        };
        [_itemBgView addSubview:_itemListLandscapeView];
        [_itemListLandscapeView makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(_itemBgView);
            make.top.equalTo(_barCollectionView.bottom);
            make.bottom.equalTo(_itemBgView.bottom).with.offset(-22);
        }];
        [self layoutIfNeeded];
    }
    return _itemListLandscapeView;
}

- (void)initParentCollention
{
    _barListViewModel = [[MAItemListViewModel alloc] initWithDataSource:self.listsData cellIdentifier:ItemCategoryCollectionCellIdentifier block:^(id cell, MAApiItemListModel *item) {
        MACategoryCell *categoryCell = (MACategoryCell *)cell;
        
        if (![item isKindOfClass:[MAApiItemListModel class]]) {
            return ;
        }
        
        [categoryCell setCell:item];
    }];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(80, 35);
    flowLayout.minimumInteritemSpacing = 0;
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _barCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _barCollectionView.tag = 100;
    _barCollectionView.dataSource = _barListViewModel;
    _barCollectionView.delegate = self;
    _barCollectionView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    _barCollectionView.showsVerticalScrollIndicator = NO;
    _barCollectionView.showsHorizontalScrollIndicator = NO;
    [_itemBarBGView addSubview:_barCollectionView];
    [_barCollectionView registerClass:[MACategoryCell class] forCellWithReuseIdentifier:ItemCategoryCollectionCellIdentifier];
    
    [_barCollectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_itemBarBGView.left);
        make.right.equalTo(_itemBarBGView.right);
        make.height.equalTo(30);
        make.centerY.equalTo(_itemBarBGView.centerY);
    }];
}

#pragma mark - setter & getter
- (void)setListsData:(NSArray *)listsData
{
    if (!listsData) {
        return;
    }
    if (listsData.count <= 0) {
        return;
    }
    
    _listsData = listsData;
    
    if (self.itemListLayoutType == ItemListLayoutTypeLandscape) {
        self.itemListLandscapeView.listsData = _listsData;
    }else{
        self.itemListPortraitView.listsData = _listsData;
    }
    [self barCollectionReload];
}

#pragma mark - reload
- (void)barCollectionReload
{
    _barListViewModel.dataSource = _listsData;
    [self.barCollectionView reloadData];
    [_barCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    self.currentSelectedGroupIndex = 0;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 100) {
        MACategoryCell *cell = (MACategoryCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if (!cell.isSelected) {
            [cell setSelected:!cell.isSelected];
            
            if (self.itemListLayoutType == ItemListLayoutTypeLandscape) {
                [self.itemListLandscapeView selectGroup:indexPath.row withAnimated:YES];
            }else{
                [self.itemListPortraitView selectGroup:indexPath.row withAnimated:YES];
            }
            
            self.currentSelectedGroupIndex = indexPath.row;
        }
    }
}

#pragma mark - 横竖屏切换

- (ItemListViewLayoutType)itemListLayoutType
{
    return _itemListLayoutType;
}

- (void)setItemListLayoutType:(ItemListViewLayoutType)itemListLayoutType
{
    _itemListLayoutType = itemListLayoutType;
    [self itemListChangeDirection];
}

- (void)itemListChangeDirection
{
    if (self.itemListLayoutType == ItemListLayoutTypeLandscape) {
        [self.itemBgView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.and.right.equalTo(self.bgButton);
            make.width.equalTo(RightItemListViewWidth);
        }];
    }else{
        [self.itemBgView remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.and.bottom.equalTo(_bgButton);
            make.height.equalTo(ItemListViewHeight);
        }];
    }
    [self layoutIfNeeded];
    [self subCollectionViewChangeLayout];
}

- (void)subCollectionViewChangeLayout
{
//    WEAKSELF
    if (self.itemListLayoutType == ItemListLayoutTypeLandscape) {
        self.itemListLandscapeView.listsData = _listsData;
        self.itemListPortraitView.hidden = YES;
        self.itemListLandscapeView.hidden = NO;
        _pageControl.hidden = YES;
        [self.itemListLandscapeView selectGroup:self.currentSelectedGroupIndex withAnimated:NO];
        
        /*
         1.拿到当前的item[已完成]
         2.遍历出当前item所在的cell
         3.将cell转换，获取point和frame
         4.设置sendView Point
         */
//        if (self.itemSendView) {
//            
//            [self.itemSendView.superview insertSubview:self.itemSendView aboveSubview:self.itemListLandscapeView];
//            [self.itemListLandscapeView locatedItem:self.currentSelectedItemModel positionBlock:^(CGRect frame, CGPoint point) {
//                [weakSelf.itemSendView setCenter:[weakSelf caculateSendViewPositionWithCellRect:frame cellPoint:point]];
//                [weakSelf layoutIfNeeded];
//            }];
//        }
    }else{
        self.itemListPortraitView.listsData = _listsData;
        self.itemListPortraitView.hidden = NO;
        self.itemListLandscapeView.hidden = YES;
        _pageControl.hidden = NO;
        [self.itemListPortraitView selectGroup:self.currentSelectedGroupIndex withAnimated:NO];
        
//        if (self.itemSendView) {
//            [self.itemListPortraitView locatedItem:self.currentSelectedItemModel positionBlock:^(CGRect frame, CGPoint point) {
//                [weakSelf.itemSendView setCenter:[weakSelf caculateSendViewPositionWithCellRect:frame cellPoint:point]];
//                [weakSelf layoutIfNeeded];
//            }];
//        }
    }
    [self layoutIfNeeded];
}

@end
