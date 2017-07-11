//
//  MAItemListPortraitView.h
//  TairanTV
//
//  Created by mengai on 2017/7/5.
//  Copyright © 2017年 mengai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAApiItemListModel.h"

typedef NS_ENUM(NSInteger, PortraitActionType) {
    PortraitActionTypeDrag = 1, //滑动
    PortraitActionTypeSelectMock, //点击假数据
    PortraitActionTypeSelectItem, //选中某个item
    PortraitActionTypeScrollToPage, //滑动到某页
};

/**
 竖屏礼物回调

 @param currentGroupIndex 当前组索引
 @param currentGroupPageCount 当前组页面数
 @param pageIndexInCurrentGroup 当前页面在当前组的位置
 */
typedef void(^PortraitPageBlock)(NSInteger currentGroupIndex, NSInteger currentGroupPageCount,NSInteger pageIndexInCurrentGroup);

/**
 竖屏礼物动作回调

 @param actionType 动作类型
 @param selectIndexRow 动作触发结果
 */
typedef void(^PortraitActionBlock)(PortraitActionType actionType, NSInteger selectIndexRow, MAApiItemItemModel *itemModel, CGRect aimRect, CGPoint aimPoint, BOOL isSystemAuto);

//竖屏礼物列表
@interface MAItemListPortraitView : UIView

@property (nonatomic, weak) UIView *aimView;
@property (nonatomic, strong) NSArray *listsData;
@property (nonatomic, strong) PortraitPageBlock portraitPageBlock;
@property (nonatomic, strong) PortraitActionBlock portraitActionBlock;

/**
 选中某一组

 @param groupIndex 组索引
 */
- (void)selectGroup:(NSInteger)groupIndex withAnimated:(BOOL)animated;

/**
 根据itemModel，找到当前cell相对于bgView的位置
 
 @param itemModel 目标item
 @param block 回参
 */
- (void)locatedItem:(MAApiItemItemModel *)itemModel positionBlock:(void(^)(CGRect frame,CGPoint point))block;

@end
