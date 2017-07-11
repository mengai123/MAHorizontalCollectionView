//
//  MAItemListView.h
//  TairanTV
//
//  Created by mengai on 2017/5/13.
//  Copyright © 2017年 mengai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAApiItemListModel.h"

typedef NS_ENUM(NSInteger, ItemListViewLayoutType) {
    ItemListLayoutTypePortrait = 0,  //竖屏
    ItemListLayoutTypeLandscape  //横屏
};

//礼物列表
@interface MAItemListView : UIView

@property (nonatomic, assign) ItemListViewLayoutType itemListLayoutType;

@property (nonatomic, strong) NSArray *listsData;

@end
