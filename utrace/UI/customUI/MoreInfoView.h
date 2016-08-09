//
//  MoreInfoView.h
//  utrace
//
//  Created by Ilja Rozhko on 07.08.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLabel.h"

#import "const.h"
#import "LookupModel.h"

@interface MoreInfoView : UIView {
    LookupModel *lookupModel;
}

- (id)initWithLookupModel:(LookupModel *)model;

- (void)setupLabels;

@end
