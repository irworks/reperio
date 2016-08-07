//
//  MoreInfoView.m
//  utrace
//
//  Created by Ilja Rozhko on 07.08.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import "MoreInfoView.h"

@implementation MoreInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self setupConstraints];
        
        [self setupLabels];
        [self setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    return self;
}

- (void)setupConstraints {
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self
                                                             attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute multiplier:1
                                                              constant:180];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute multiplier:1
                                                               constant:80];
    
    [self addConstraint:width];
    [self addConstraint:height];
}

- (void)setupLabels {
    UILabel *addressLbl = [[UILabel alloc] init];
    [addressLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [addressLbl setText:@"IP address:"];
    [self addSubview:addressLbl];

    [self addContstraintsForLabel:addressLbl relativeMarginTo:self];
    
    UILabel *locationLbl = [[UILabel alloc] init];
    [locationLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [locationLbl setText:@"Location:"];
    [self addSubview:locationLbl];
    
    [self addContstraintsForLabel:locationLbl relativeMarginTo:addressLbl];
}

- (void)addContstraintsForLabel:(UILabel *)label relativeMarginTo:(UIView *)relativeItem {
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
    [self addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                     attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                        toItem:relativeItem
                                                     attribute:NSLayoutAttributeTop multiplier:1.8
                                                      constant:UI_MARGIN]];
    //left margin
    [self addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                     attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft multiplier:1.0
                                                      constant:UI_MARGIN]];
}

@end
