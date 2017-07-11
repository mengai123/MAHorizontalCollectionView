//
//  MAItemListLandscapeView.h
//  TairanTV
//
//  Created by mengai on 2017/7/5.
//  Copyright © 2017年 mengai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAApiItemListModel.h"

typedef NS_ENUM(NSInteger, LandscapeActionType) {
    LandscapeActionTypeUnknow = 0, //未知操作
    LandscapeActionTypeDrag = 1, //滑动
    LandscapeActionTypeSelectMock, //点击假数据
    LandscapeActionTypeSelectItem, //选中某个item
    LandscapeActionTypeScrollToPage, //滑动到某页
};

/**
 竖屏礼物回调
 
 @param currentGroupIndex 当前组索引
 */
typedef void(^LandscapePageBlock)(NSInteger currentGroupIndex);

/**
 竖屏礼物动作回调
 
 @param actionType 动作类型
 @param selectIndexRow 动作触发结果
 @param itemModel 选中的item
 @param aimRect 目标rect
 @param aimPoint 目标point
 @param isSystemAuto 手动触发or自动触发
 */
typedef void(^LandscapeActionBlock)(LandscapeActionType actionType, NSInteger selectIndexRow ,MAApiItemItemModel *itemModel, CGRect aimRect, CGPoint aimPoint, BOOL isSystemAuto);


//横屏礼物列表
@interface MAItemListLandscapeView : UIView

@property (nonatomic, weak) UIView *aimView;
@property (nonatomic, strong) LandscapeActionBlock landscapeActionBlock;

@property (nonatomic, strong) NSArray *listsData;

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
