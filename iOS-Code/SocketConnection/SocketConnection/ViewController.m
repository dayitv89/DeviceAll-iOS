//
//  ViewController.m
//  SocketConnection
//
//  Created by Gaurav on 29/04/16.
//  Copyright © 2016 Softex Lab. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>

@end

@implementation ViewController

- (IBAction)btnTapped:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"Touch All Test"
                                message:@"Wanna Back from this screen"
                               delegate:self
                      cancelButtonTitle:@"NO"
                      otherButtonTitles:@"YES", nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
