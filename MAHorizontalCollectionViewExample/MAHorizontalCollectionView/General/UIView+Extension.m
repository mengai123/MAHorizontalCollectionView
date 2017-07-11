//
//  UIView+Extension.m
//  TairanTV
//
//  Created by mengai on 2017/3/25.
//  Copyright © 2017年 Hangzhou Tairan. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (CGFloat)left_t {
    return self.frame.origin.x;
}

- (void)setLeft_t:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top_t {
    return self.frame.origin.y;
}

- (void)setTop_t:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right_t {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight_t:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom_t {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom_t:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX_t {
    return self.center.x;
}

- (void)setCenterX_t:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY_t {
    return self.center.y;
}

- (void)setCenterY_t:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width_t {
    return self.frame.size.width;
}

- (void)setWidth_t:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height_t {
    return self.frame.size.height;
}

- (void)setHeight_t:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin_t {
    return self.frame.origin;
}

- (void)setOrigin_t:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size_t {
    return self.frame.size;
}

- (void)setSize_t:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


@end
