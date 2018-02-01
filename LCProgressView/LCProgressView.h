//
//  LCProgressView.h
//  MojiWeather
//
//  Created by yang.yang on 16/8/25.
//  Copyright © 2016年 Moji Fengyun Software & Technology Development co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCProgressView : UIView

@property (nonatomic, strong) UIColor *pointColor;
@property (nonatomic, assign) NSInteger pointNumber;
@property (nonatomic, assign) CGFloat pointWidth;

//default = 2.0
@property (nonatomic, assign) CGFloat animationDuration;

- (instancetype)initWithDiameter:(CGFloat)diameter;

@end
