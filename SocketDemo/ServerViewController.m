//
//  ServerViewController.m
//  SocketDemo
//
//  Created by lingzhi on 2016/10/9.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "ServerViewController.h"
#import  <GCDAsyncSocket.h>


@interface ServerViewController ()<GCDAsyncSocketDelegate>
//服务器socket (开放端口，监听客户端socket的连接)
@property (nonatomic,strong)GCDAsyncSocket *serverSocket;
// 保存客户端socket
@property (nonatomic,strong)GCDAsyncSocket *clientSocket;
@end

@implementation ServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
    
    //1.初始化服务器socket
    self.serverSocket  = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    
}
//开始监听
- (IBAction)startNotification:(id)sender {
    //2.开放哪一个端口
    NSError *error = nil;
    BOOL result = [self.serverSocket acceptOnPort:self.portTF.text.integerValue error:&error];
    if (result && error == nil)
    {
        //开放成功
        [self showMessageWithStr:@"开放成功"];
    }
    else
    {
        //开放失败
        [self showMessageWithStr:@"开放失败"];
    }
    
}

//接收信息
- (IBAction)recieveMessageAction:(id)sender {
    
      [self.clientSocket readDataWithTimeout:11 tag:0];
}


// socket是保存的客户端scket, 表示给这个socket客户端发送消息
- (IBAction)sendMessage:(id)sender {
    NSData *data = [self.sendMessageTF.text dataUsingEncoding:NSUTF8StringEncoding];
    
    // withTimeout -1 : 无穷大,一直等
    // tag : 消息标记
    [self.clientSocket writeData:data withTimeout:- 1 tag:0];
}


#pragma mark - 服务器socketDelegate
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    self.clientSocket = newSocket;
    [self showMessageWithStr:@"链接成功"];
    [self showMessageWithStr:[NSString stringWithFormat:@"服务器地址: %@ -端口: %d", newSocket.connectedHost, newSocket.connectedPort]];
    [self.clientSocket readDataWithTimeout:- 1 tag:0];

    
}

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
