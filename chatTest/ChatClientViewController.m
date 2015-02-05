//
//  ChatClientViewController.m
//  chatTest
//
//  Created by Luyao Huang on 15/2/4.
//  Copyright (c) 2015年 LPP. All rights reserved.
//

#import "ChatClientViewController.h"

@interface ChatClientViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputNameField;
@property (weak, nonatomic) IBOutlet UIButton *joinView;


@end

@implementation ChatClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNetworkCommunication];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)joinChat:(id)sender {
    NSString *response  = [NSString stringWithFormat:@"iam:%@", _inputNameField.text];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    
}


- (void)initNetworkCommunication {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"54.69.204.42", 80, &readStream, &writeStream);
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
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
