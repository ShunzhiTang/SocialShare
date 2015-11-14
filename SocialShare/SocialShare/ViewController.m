//
//  ViewController.m
//  SocialShare
//
//  Created by Tsz on 15/11/14.
//  Copyright © 2015年 Tsz. All rights reserved.

#import "ViewController.h"
#import <Social/Social.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self appleShare];
}


#pragma mark: 社交分享的实现
- (void)appleShare{
    
    //1、检测是否可用 ，新浪微博
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        NSLog(@"微博分享不可用, 请检测是否配置账号");
        return;
    }
    
    //2、创建分享控制器
    SLComposeViewController *compose = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    
    //3、添加文字
    [compose setInitialText:@"耍微博"];
    
    //4、添加文字
    [compose addImage:[UIImage imageNamed:@"cloudy.png"]];
    
    
    //5、添加跳转路径
    [compose addURL:[NSURL URLWithString:@"www.baidu.com"]];
    
    //6、弹出
    [self presentViewController:compose animated:YES completion:nil];
}


@end
