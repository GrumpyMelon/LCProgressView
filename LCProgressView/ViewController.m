//
//  ViewController.m
//  LCProgressView
//
//  Created by yang.yang on 2018/2/1.
//  Copyright © 2018年 yang.yang. All rights reserved.
//

#import "ViewController.h"
#import "LCProgressView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LCProgressView *hud = [[LCProgressView alloc] initWithDiameter:60];
    hud.frame = CGRectMake(100, 100, hud.frame.size.width, hud.frame.size.height);
    
    LCProgressView *hud2 = [[LCProgressView alloc] initWithDiameter:60];
    hud2.pointColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    hud2.pointWidth = 10.0;
    hud2.frame = CGRectMake(200, 100, hud2.frame.size.width, hud2.frame.size.height);
    
    LCProgressView *hud3 = [[LCProgressView alloc] initWithDiameter:60];
    hud3.pointNumber = 8;
    hud3.frame = CGRectMake(100, 200, hud3.frame.size.width, hud3.frame.size.height);
    
    LCProgressView *hud4 = [[LCProgressView alloc] initWithDiameter:80];
    hud4.pointNumber = 8;
    hud4.animationDuration = 3.0;
    hud4.frame = CGRectMake(200, 200, hud4.frame.size.width, hud4.frame.size.height);
    
    [self.view addSubview:hud];
    [self.view addSubview:hud2];
    [self.view addSubview:hud3];
    [self.view addSubview:hud4];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
