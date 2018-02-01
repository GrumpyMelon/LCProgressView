//
//  LCProgressView.m
//  MojiWeather
//
//  Created by yang.yang on 16/8/25.
//  Copyright © 2016年 Moji Fengyun Software & Technology Development co., Ltd. All rights reserved.
//

#import "LCProgressView.h"

@interface LCProgressView ()

@property (nonatomic , strong) UIView *pointView;

@property (nonatomic , strong) NSMutableArray *pointArray;

@end

@implementation LCProgressView

- (instancetype)initWithDiameter:(CGFloat)diameter {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, diameter, diameter);
        _animationDuration = 2.0;
        _pointArray = [[NSMutableArray alloc] init];
        _pointWidth = 6.0;
        _pointNumber = 6;
        _pointColor = [UIColor redColor];
        [self configPoint];
    }
    return self;
}

#pragma makr - clear

- (void)clearPoints {
    for (UIView *pointView in self.pointArray) {
        [pointView removeFromSuperview];
    }
    [self.pointArray removeAllObjects];
}

#pragma mark -- config point

- (void)configPoint {
    NSInteger pointCount = self.pointNumber;
    CGFloat countFloat = (CGFloat)pointCount;
    
    //每个点动画之间的时间间隔;
    CGFloat timeInterval = 0.75 * _animationDuration / countFloat;
    [self clearPoints];
    for (NSInteger i = 0; i < pointCount; i++) {
        UIView *pointView = [self getPoint];
        [self addSubview:pointView];
        [self.pointArray addObject:pointView];
        pointView.alpha = 1;
        
        CAKeyframeAnimation *animation = [self getKeyAnimation];
        
        animation.timeOffset = ( 2 - i ) * timeInterval;
        [pointView.layer addAnimation:animation forKey:@"animation"];
    }
}

- (UIView *)getPoint {
    UIView *pointView = [[UIView alloc] init];
    pointView.backgroundColor = _pointColor ? _pointColor : [UIColor whiteColor];
    pointView.layer.cornerRadius = _pointWidth / 2.0;
    pointView.layer.masksToBounds = YES;
    pointView.frame = CGRectMake(0, 0, _pointWidth, _pointWidth);
    pointView.center = [self getBeginPoint];
    return pointView;
}

#pragma mark - set

- (void)setPointColor:(UIColor *)pointColor {
    _pointColor = pointColor;
    for (UIView *pointView in self.pointArray) {
        pointView.backgroundColor = pointColor;
    }
}

- (void)setPointWidth:(CGFloat)pointWidth {
    _pointWidth = pointWidth;
    [self configPoint];
}

- (void)setAnimationDuration:(CGFloat)animationDuration {
    _animationDuration = animationDuration;
    [self configPoint];
}

- (void)setPointNumber:(NSInteger)pointNumber {
    _pointNumber = pointNumber;
    [self configPoint];
}

#pragma mark -- animation

- (void)startAnimation {
    [self.pointView.layer addAnimation:[self getKeyAnimation] forKey:@"rotation"];
}

- (CAKeyframeAnimation *)getKeyAnimation {
    CGFloat radius = (self.frame.size.width - _pointWidth) / 2;
    CGPoint centerPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:[self getBeginPoint]];
    [path addArcWithCenter:centerPoint radius:radius startAngle:- M_PI / 2 endAngle:M_PI * 3 / 2 clockwise:1];
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.repeatCount = MAXFLOAT;
    keyAnimation.path = path.CGPath;
    keyAnimation.duration = _animationDuration;
    keyAnimation.autoreverses = NO;
    keyAnimation.fillMode = kCAFillModeBoth;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.calculationMode = kCAAnimationPaced;
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.95 :0.35 :0.05 :0.7];
    return keyAnimation;
}

- (CGPoint)getBeginPoint {
    return CGPointMake(self.frame.size.width / 2.0, _pointWidth / 2.0);
}

@end
