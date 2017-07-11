//
//  MAHorizontalPageFlowlayout.h
//  TairanTV
//
//  Created by mengai on 2017/5/16.
//  Copyright © 2017年 mengai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAHorizontalPageFlowlayout : UICollectionViewFlowLayout

/** 列间距 */
@property (nonatomic, assign) CGFloat columnSpacing;
/** 行间距 */
@property (nonatomic, assign) CGFloat rowSpacing;
/** collectionView的内边距 */
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

/** 多少行 */
@property (nonatomic, assign) NSInteger rowCount;
/** 每行展示多少个item */
@property (nonatomic, assign) NSInteger itemCountPerRow;

//固定宽度
@property (nonatomic, assign) CGFloat itemWidth; //设置完这个，就会自动计算列间距
//固定高度
@property (nonatomic, assign) CGFloat itemHight;//设置完这个，就会自动计算行间距

/** 所有item的属性数组 */
@property (nonatomic, strong) NSMutableArray *attributesArrayM;

/** 设置行列间距及collectionView的内边距 */
- (void)setColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing edgeInsets:(UIEdgeInsets)edgeInsets;
/** 设置多少行及每行展示的item个数 */
- (void)setRowCount:(NSInteger)rowCount itemCountPerRow:(NSInteger)itemCountPerRow;

#pragma mark - 构造方法
/** 设置多少行及每行展示的item个数 */
+ (instancetype)horizontalPageFlowlayoutWithRowCount:(NSInteger)rowCount itemCountPerRow:(NSInteger)itemCountPerRow;
/** 设置多少行及每行展示的item个数 */
- (instancetype)initWithRowCount:(NSInteger)rowCount itemCountPerRow:(NSInteger)itemCountPerRow;


@end
