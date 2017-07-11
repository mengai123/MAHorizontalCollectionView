//
//  ViewController.m
//  MAHorizontalCollectionViewExample
//
//  Created by mengai on 2017/7/11.
//  Copyright © 2017年 mengai. All rights reserved.
//
//c
#import "ViewController.h"

//m
#import "MADataHelper.h"

//v
#import "MAItemListView.h"

@interface ViewController ()

@property (nonatomic, strong) MAItemListView *itemListView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _itemListView = [[MAItemListView alloc] init];
    [self.view addSubview:_itemListView];
    [_itemListView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [_itemListView layoutIfNeeded];
    
    _itemListView.listsData = [MADataHelper loadTestData];
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection
                 withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext> context)
     {
         if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
             //紧凑的高 横屏
             [_itemListView setItemListLayoutType:ItemListLayoutTypeLandscape];
         } else {
             //正常的高
             [_itemListView setItemListLayoutType:ItemListLayoutTypePortrait];
         }
         [self.view setNeedsLayout];
     } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
