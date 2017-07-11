//
//  MAItemListViewModel.h
//  TairanTV
//
//  Created by mengai on 2017/5/13.
//  Copyright © 2017年 Hangzhou Tairan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CellBlock)(id cell, id item);

@interface MAItemListViewModel : NSObject<UICollectionViewDataSource>

- (id)initWithDataSource:(NSArray *)dataSource cellIdentifier:(NSString *)identifier block:(CellBlock)cellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) id dataSource;

@end
