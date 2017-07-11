//
//  MADataHelper.m
//  MAHorizontalCollectionView
//
//  Created by mengai on 2017/7/10.
//  Copyright © 2017年 mengai. All rights reserved.
//

#import "MADataHelper.h"
#import <MJExtension/MJExtension.h>
#import "MAApiItemListModel.h"

@implementation MADataHelper

+ (NSArray *)loadTestData
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Resourse" ofType:@"bundle"];
    NSBundle *resourseBundle = [NSBundle bundleWithPath:bundlePath];
    
    NSData *data = [NSData dataWithContentsOfFile:[resourseBundle pathForResource:@"data" ofType:@"json"]];
    NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    if (dataArr.count <= 0) {
        return nil;
    }
    
    NSMutableArray *list = [NSMutableArray array];
    for (id obj in dataArr) {
        
        [MAApiItemListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"itemList" : @"MAApiItemItemModel"};
        }];
        
        MAApiItemListModel *model = [MAApiItemListModel mj_objectWithKeyValues:obj];
        [list addObject:model];
    }
    
    return list;
}

@end
