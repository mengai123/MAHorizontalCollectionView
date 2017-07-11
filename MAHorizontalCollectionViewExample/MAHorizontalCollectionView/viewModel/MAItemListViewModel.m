//
//  MAItemListViewModel.m
//  TairanTV
//
//  Created by mengai on 2017/5/13.
//  Copyright © 2017年 Hangzhou Tairan. All rights reserved.
//

#import "MAItemListViewModel.h"

@interface MAItemListViewModel()

@property (nonatomic, strong) NSArray *currentDataSource;
@property (nonatomic, copy  ) NSString *cellIdentifier;
@property (nonatomic, copy  ) CellBlock cellBlock;

@end

@implementation MAItemListViewModel

- (instancetype)init
{
    return nil;
}

- (id)initWithDataSource:(NSArray *)dataSource cellIdentifier:(NSString *)identifier block:(CellBlock)cellBlock
{
    if (self = [super init]) {
        self.currentDataSource = dataSource;
        self.cellIdentifier = identifier;
        self.cellBlock = [cellBlock copy];
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.currentDataSource[indexPath.row];
}

- (void)setDataSource:(id)dataSource
{
    if (!dataSource) {
        return;
    }
    
    _currentDataSource = dataSource;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.currentDataSource.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    if (self.cellBlock) {
        self.cellBlock(cell, [self itemAtIndexPath:indexPath]);
    }
    return cell;
}


@end
