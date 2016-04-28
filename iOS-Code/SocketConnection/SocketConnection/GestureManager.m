//
//  GestureManager.m
//  SocketConnection
//
//  Created by Gaurav on 29/04/16.
//  Copyright © 2016 Softex Lab. All rights reserved.
//

#import "GestureManager.h"
#import "AppDelegate.h"
#import "HRClientSocket.h"

@interface GestureManager () <UIGestureRecognizerDelegate, HRSocketDelegate>
@property (nonatomic, weak) AppDelegate *appDelegate;
@property (nonatomic, strong) HRClientSocket *socket;
@property (nonatomic,strong) HRQueue* chatQueue;
@end

@implementation GestureManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static id SINGLETON = nil;
    dispatch_once(&onceToken, ^{
        SINGLETON = [[self alloc] init];
    });
    return SINGLETON;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setWindowGestures];
        [self setSocketConnections];
    }
    return self;
}

- (void)setWindowGestures {
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(tapTest:)];
    [tap setDelegate:self];
    [self.appDelegate.window addGestureRecognizer:tap];
}

- (void)setSocketConnections {
    self.socket = [[HRClientSocket alloc] initWithReadQueue:[[HRQueue alloc] initWithQueue:dispatch_queue_create("serverout", NULL)]
                                                                  writeQueue:[[HRQueue alloc] initWithQueue:dispatch_queue_create("serverin", NULL)]];
    self.socket.delegate = self;
    [self.socket connectIP:@"192.168.1.4" port:5000];
    [self.socket recivSoketCompletionBlock:^(NSData *data) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [self.chatQueue async:^{
            NSLog(@"%@",str);
        }];
    }];
    self.chatQueue = [[HRQueue alloc] initWithQueue:dispatch_queue_create("chat", NULL)];
    
}

- (void) contentSocket:(HRSocket*) socket{
    [self.chatQueue async:^{
        NSLog(@"new user");
    }];
}

- (void) socket:(HRSocket*) socket didRecivData:(NSData*) data{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self.chatQueue async:^{
        NSLog(@"%@",str);
    }];
    [socket recivSoketCompletionBlock:nil];
}

- (void) discontentSocket:(HRSocket*) socket{
    [self.chatQueue async:^{
        NSLog(@"the user has left the chat ");
    }];
}

#pragma mark - working  
#pragma mark getter
- (void)getSocketValue:(NSString *)str {
    NSLog(@"touch point get %@", str);
    CGPoint pointData = CGPointFromString(str);
//    [self.appDelegate.window tapAtPoint:pointData];
}

#pragma mark setter
- (void)tapTest:(UITapGestureRecognizer *)sender {
    CGPoint pointMake = CGPointMake([sender locationInView:self.appDelegate.window].x, [sender locationInView:self.appDelegate.window].y);
    NSString *pointData = NSStringFromCGPoint(pointMake);
    NSLog(@"touch point %@", pointData);
    [self sendSocketData:pointData];
}

- (void)sendSocketData:(NSString *)str {
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket sendData:data completionBloack:nil];
}

@end
