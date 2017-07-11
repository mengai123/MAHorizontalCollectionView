//
//  Macro.h
//  MAHorizontalCollectionView
//
//  Created by mengai on 2017/7/10.
//  Copyright © 2017年 mengai. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define WEAKSELF typeof(self) __weak weakSelf = self;
/**
 *  使用rgb颜色
 */
#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r, g, b, alpha) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]


/**
 *  使用16位表达
 */
#define RGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define RGBAHex(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(alphaValue)]

/**
 *  使用字体
 */
#define font(fontName,fontSize)         [UIFont fontWithName:fontName size:fontSize]
#define fontSystem(fontSize)            [UIFont systemFontOfSize:fontSize]
#define fontSystemBold(fontSize)        [UIFont boldSystemFontOfSize:fontSize]


/**
 *  屏幕大小常量
 */
#define APP_W            [UIScreen mainScreen].bounds.size.width  //屏幕宽
#define APP_H            [UIScreen mainScreen].bounds.size.height //屏幕高


#endif /* Macro_h */
