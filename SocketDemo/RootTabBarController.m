//
//  RootTabBarController.m
//  SocketDemo
//
//  Created by lingzhi on 2016/10/9.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "RootTabBarController.h"
#import "ServerViewController.h"
#import "ClientViewController.h"
#import "BaseNavigationController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ServerViewController *serverVC = [[ServerViewController alloc] init];
    serverVC.title = @"服务器";
    BaseNavigationController *serverNav = [[BaseNavigationController alloc] initWithRootViewController:serverVC];
    serverNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"服务器" image:nil selectedImage:nil];
    
    
    ClientViewController *clientVC = [[ClientViewController alloc] init];
    clientVC.title = @"客户端";
    BaseNavigationController *clientNav = [[BaseNavigationController alloc] initWithRootViewController:clientVC];
    clientNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"客户端" image:nil selectedImage:nil];
    
    
    self.viewControllers = @[serverNav,clientNav];
    
    
    self.tabBar.tintColor = [UIColor blackColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
