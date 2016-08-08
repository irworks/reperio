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

- (void)addListenerToTextfield:(UITextField *)textField;

@end
