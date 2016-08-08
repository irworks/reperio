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

/* UI */

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIAlertController *)showAlertMessageWithTitle:(NSString *)title message:(NSString *)message {
    return [self showAlertMessageWithTitle:title message:message completion:nil actions:nil style:UIAlertControllerStyleAlert];
}

- (UIAlertController *)showAlertMessageWithTitle:(NSString *)title message:(NSString *)message completion:(void (^)(void))completion actions:(NSArray <UIAlertAction*> *)actions {
    return [self showAlertMessageWithTitle:title message:message completion:completion actions:actions style:UIAlertControllerStyleAlert];
}

- (UIAlertController *)showAlertMessageWithTitle:(NSString *)title message:(NSString *)message completion:(void (^)(void))completion actions:(NSArray <UIAlertAction*> *)actions style:(UIAlertControllerStyle)style {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:style];
    
    if(actions == nil) {
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", nil)
                                   style:UIAlertActionStyleDefault
                                   handler:nil];
        
        [alertController addAction:okAction];
    }else{
        for(UIAlertAction *action in actions) {
            [alertController addAction:action];
        }
    }
    
    [self presentViewController:alertController animated:YES completion:completion];
    
    return alertController;
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
