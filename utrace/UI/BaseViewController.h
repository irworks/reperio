//
//  BaseViewController.h
//  utrace
//
//  Created by Ilja Rozhko on 08.08.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "const.h"
#import "HTTPRequest.h"

@interface BaseViewController : UIViewController<HTTPRequestDelegate>

- (void)addListenerToTextfield:(UITextField * _Nonnull)textField;
- (UIAlertController * _Nonnull)showAlertMessageWithTitle:(NSString * _Nonnull)title message:(NSString * _Nonnull)message;
- (UIAlertController * _Nonnull)showAlertMessageWithTitle:(NSString * _Nonnull)title message:(NSString * _Nonnull)message completion:(void (^ _Nullable)(void))completion actions:(NSArray <UIAlertAction*> * _Nullable)actions;

@end
