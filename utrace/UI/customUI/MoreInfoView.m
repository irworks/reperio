//
//  MoreInfoView.m
//  utrace
//
//  Created by Ilja Rozhko on 07.08.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import "MoreInfoView.h"

@implementation MoreInfoView

- (id)initWithLookupModel:(LookupModel *)model {
    lookupModel = model;
    
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self setupConstraints];
        [self setupLabels];
    }
    
    return self;
}

- (void)setupConstraints {
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self
                                                             attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute multiplier:1
                                                              constant:200];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute multiplier:1
                                                               constant:110];
    
    [self addConstraint:width];
    [self addConstraint:height];
}

- (void)setupLabels {
    //ip
    CustomLabel *addressLbl = [[CustomLabel alloc] initWithBoldFont:YES];
    [addressLbl setText:[NSLocalizedString(@"IP_ADDRESS", nil) stringByAppendingString:@":"]];
    [self addSubview:addressLbl];
    [self addMarginContstraintsForLabel:addressLbl relativeMarginTo:self topMultiplier:1.0 isFirstLabel:YES];
    
    CustomLabel *addressLblValue = [[CustomLabel alloc] init];
    [addressLblValue setText:[lookupModel ip]];
    [self addSubview:addressLblValue];
    
    [self addMarginContstraintsForLabel:addressLblValue relativeMarginTo:addressLbl topMultiplier:1.0 isFirstLabel:NO];
    
    //location
    CustomLabel *locationLbl = [[CustomLabel alloc] initWithBoldFont:YES];
    [locationLbl setText:[NSLocalizedString(@"Location", nil) stringByAppendingString:@":"]];
    [self addSubview:locationLbl];
    
    [self addMarginContstraintsForLabel:locationLbl relativeMarginTo:addressLblValue topMultiplier:1.1 isFirstLabel:NO];
    
    NSString *locationString = @"";
    
    if(![[lookupModel city] isEqualToString:@""]) {
        locationString = [[lookupModel city] stringByAppendingString:@", "];
    }
    
    if(![[lookupModel region] isEqualToString:@""]) {
        locationString = [locationString stringByAppendingString:[[lookupModel region] stringByAppendingString:@", "]];
    }
    
    if(![[lookupModel country] isEqualToString:@""]) {
        locationString = [locationString stringByAppendingString:[lookupModel country]];
    }
    
    CustomLabel *locationLblVal = [[CustomLabel alloc] init];
    [locationLblVal setText:locationString];
    [self addSubview:locationLblVal];
    
    [self addMarginContstraintsForLabel:locationLblVal relativeMarginTo:locationLbl topMultiplier:1.0 isFirstLabel:NO];
}

- (void)addMarginContstraintsForLabel:(UILabel *)label relativeMarginTo:(UIView *)relativeItem topMultiplier:(double)topMultiplier isFirstLabel:(BOOL)isFirstLabel {
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [label setTextAlignment:NSTextAlignmentCenter];
    
    //width
    [self addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                     attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth multiplier:0.8
                                                      constant:0.0]];
    //height
    [self addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                     attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight multiplier:0.2
                                                      constant:0.0]];
    
    //top margin
    if(isFirstLabel) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                         attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop multiplier:1.0
                                                          constant:UI_MARGIN]];
    }else{
        [self addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                         attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                            toItem:relativeItem
                                                         attribute:NSLayoutAttributeBottom multiplier:topMultiplier
                                                          constant:0.0]];
    }
    
    //left margin
    [self addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                     attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeftMargin multiplier:1.0
                                                      constant:UI_MARGIN]];
    
}

@end
