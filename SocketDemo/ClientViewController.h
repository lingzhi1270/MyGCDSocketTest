//
//  ClientViewController.h
//  SocketDemo
//
//  Created by lingzhi on 2016/10/9.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "BaseViewController.h"

@interface ClientViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *ipAdressTF;

@property (weak, nonatomic) IBOutlet UITextField *portTF;

@property (weak, nonatomic) IBOutlet UITextField *sendMessageTF;


@property (weak, nonatomic) IBOutlet UITextView *showMessageTextView;

@end
