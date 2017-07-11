//
//  MAPageControl.m
//  TairanTV
//
//  Created by mengai on 2017/5/25.
//  Copyright © 2017年 mengai. All rights reserved.
//

#import "MAPageControl.h"

#define kMargin 10              //两个点之间的间距
#define kDotNormalWidth     5   //正常点的宽度
#define kDotSelctedWidth    10  //选中点的宽度
#define kDotHeight          5   //点的高度

@implementation MAPageControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];//[UIImage imageNamed:@"pageControl_normal"]
    [self setCurrentPage:0];
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //计算圆点间距
    CGFloat marginX = kDotNormalWidth + kMargin;
    
    //计算整个pageControll的宽度
    CGFloat newW = (self.numberOfPages - 1 ) * marginX + kDotNormalWidth;
    
    //设置新frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, self.frame.size.height);
    
    //设置居中
    CGPoint center = self.center;
    center.x = self.superview.center.x;
    self.center = center;
    
    //遍历subview,设置圆点frame
    
    for (NSUInteger i =0; i < [self.subviews count]; i++) {
        
        UIView* dot = [self.subviews objectAtIndex:i];
        [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, kDotNormalWidth, kDotHeight)];
        
        UIImageView *imageView = nil;
        if ([dot.subviews count] == 0) {
            imageView = [[UIImageView alloc] init];
            [dot addSubview:imageView];
        }else{
            imageView = dot.subviews[0];
        }
        
        if (i == self.currentPage) {
            imageView.image = self.selectedImage;
            [imageView setBounds:CGRectMake(0, 0, kDotSelctedWidth, kDotHeight)];
            
        } else {
            imageView.image = self.normalImage;
            [imageView setBounds:CGRectMake(0, 0, kDotNormalWidth, kDotHeight)];
        }
        [imageView setCenter:CGPointMake(dot.bounds.size.width/2, dot.bounds.size.height/2)];
        dot.backgroundColor = [UIColor clearColor];
        [dot setCenter:CGPointMake(dot.center.x, CGRectGetHeight(self.frame)/2)];
    }
}

- (void)setCurrentPage:(NSInteger)page {
    [super setCurrentPage:page];
}

@end
