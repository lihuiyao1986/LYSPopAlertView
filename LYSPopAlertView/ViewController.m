//
//  ViewController.m
//  LYSPopAlertView
//
//  Created by jk on 2017/4/11.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "ViewController.h"
#import "LYSPopAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 120, CGRectGetWidth(self.view.frame), 44);
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)btnClicked:(UIButton*)sender{
    LYSPopAlertView * alertView = [[LYSPopAlertView alloc]init];
    alertView.content = @"您确定要拨您确定要拨打客您确定要拨打客打客户电话";
    alertView.type = LYSPopAlertTypeWarning;
    alertView.title = @"提示信息";
    alertView.btnTitle = @"知道了";
    alertView.dismissTouchOutside = YES;
    [alertView showInView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
