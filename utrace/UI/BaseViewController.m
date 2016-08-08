//
//  BaseViewController.m
//  utrace
//
//  Created by Ilja Rozhko on 08.08.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (void)addListenerToTextfield:(UITextField *)textField {
    [textField addTarget:self
                    action:@selector(textFieldFinished:)
          forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (IBAction)textFieldFinished:(id)sender {
    [sender resignFirstResponder];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/* API delegate */
- (void)onRequestPrepared {}
- (void)onRequestStarted {}
- (void)onRequestPaused {}
- (void)onRequestResumed {}
- (void)onRequestCanceled {}

- (void)onRequestSuccess:(NSString *)responseSting withJSON:(NSDictionary *)responseJSON {
    
}

- (void)onRequestFail:(NSError *)error {
    
}

@end
