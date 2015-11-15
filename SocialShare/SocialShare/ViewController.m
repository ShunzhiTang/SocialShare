//
//  ViewController.m
//  SocialShare
//
//  Created by Tsz on 15/11/14.
//  Copyright © 2015年 Tsz. All rights reserved.

#import "ViewController.h"
#import <Social/Social.h>

//导入友盟分享
#import "UMSocial.h"

@interface ViewController () <UMSocialDataDelegate , UMSocialUIDelegate>
- (IBAction)shareClick:(UIBarButtonItem *)sender;

- (IBAction)weiboClick:(UIBarButtonItem *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self appleShare];
}






#pragma mark: apple 自带的 社交分享的实现
- (void)appleShare{
    /**
     SLComposeViewController 分享专用控制器
     isAvailableForServiceType 专门检测服务是否可用 --> 看有没有对系统进行设置
     ServiceType:
     
     SLServiceTypeTwitter
     SLServiceTypeFacebook
     SLServiceTypeSinaWeibo
     SLServiceTypeTencentWeibo
     */
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


- (IBAction)shareClick:(UIBarButtonItem *)sender {
    
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"559bb90967e58e9f0a003d02" shareText:@"您要分享的文字" shareImage:[UIImage imageNamed:@"cloudy.png"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren, UMShareToDouban, UMShareToEmail, UMShareToFacebook, UMShareToYXSession, nil] delegate:self];
}
- (void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response{
    if (response.responseCode == UMSResponseCodeSuccess) {
        NSLog(@"分享成功");
    }
}

//使用SSO 授权登录第三方的页面

- (IBAction)weiboClick:(UIBarButtonItem *)sender {
    
    UMSocialSnsPlatform *platform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    platform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
         //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            //得到帐号
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
             NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
        }
    });
    
    
}
@end
