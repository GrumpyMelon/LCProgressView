# CAKeyframeAnimation应用之-仿windows加载样式

[gitHub地址](https://github.com/LazyChops/LCProgressView)

## 效果图: 

![](https://raw.githubusercontent.com/LazyChops/LCProgressView/master/previewImage.gif)


## 代码解析:

主要原理是使用UIBezierPath绘制运动轨迹,并使用CAKeyframeAnimation实现动画.通过设置timingFunction来改变动画的速度,设置timeOffset改变动画的初始位置.原理比较简单直接看代码吧

```
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
        //设置timeOffset,即初始偏移量
        animation.timeOffset = ( 2 - i ) * timeInterval;
        [pointView.layer addAnimation:animation forKey:@"animation"];
    }
}

- (CAKeyframeAnimation *)getKeyAnimation {
    CGFloat radius = (self.frame.size.width - _pointWidth) / 2;
    CGPoint centerPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
    //使用UIBezierPath绘制运动轨迹
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
    //设置动画速度.
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.95 :0.35 :0.05 :0.7];
    return keyAnimation;
}

```

## 辅助工具:
设置timingFunction时可以用 [这个工具](https://github.com/YouXianMing/Tween-o-Matic-CN) 获取合适的动画参数.

![](https://github.com/YouXianMing/Tween-o-Matic-CN/blob/master/app.png)

