//
//  ClientViewController.m
//  SocketDemo
//
//  Created by lingzhi on 2016/10/9.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "ClientViewController.h"
#import <GCDAsyncSocket.h>


@interface ClientViewController ()<GCDAsyncSocketDelegate>

//客户端socket
@property (nonatomic,strong)GCDAsyncSocket *clientSocket;

@end

@implementation ClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor whiteColor]];


    //1.初始化
    self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    

}
//开始连接
- (IBAction)connectAction:(id)sender {
    //2.连接服务器
    NSError *error = nil;
    [self.clientSocket connectToHost:self.ipAdressTF.text onPort:self.portTF.text.integerValue viaInterface:nil withTimeout:-1 error:&error];
}

//发送消息
- (IBAction)sendMessage:(id)sender {
    
    NSData *data = [self.sendMessageTF.text dataUsingEncoding:NSUTF8StringEncoding];
    /**
     *  withTimeout   -1:  表示无穷大  一直等
     *  tag :  消息标记
     */
    [self.clientSocket writeData:data withTimeout:-1 tag:0];
    
}


//接收消息
- (IBAction)receiveMessageAction:(id)sender {
    
    [self.clientSocket readDataWithTimeout:11 tag:0];
    
}

#pragma mark- GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    [self showMessageWithStr:@"连接成功"];
    [self showMessageWithStr:[NSString stringWithFormat:@"服务器IP: %@", host]];
    //接收数据
    [self.clientSocket readDataWithTimeout:-1 tag:0];

}

// 接收到消息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self showMessageWithStr:text];
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}

// 信息展示
- (void)showMessageWithStr:(NSString *)str {
    self.showMessageTextView.text = [self.showMessageTextView.text stringByAppendingFormat:@"%@\n", str];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
