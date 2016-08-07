//
//  MoreInfoView.h
//  utrace
//
//  Created by Ilja Rozhko on 07.08.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "const.h"
#import "ResultElement.h"

@interface MoreInfoView : UIView {
    ResultElement *resultElement;
}

- (id)initWithResultElement:(ResultElement *)result;

- (void)setupLabels;

@end
