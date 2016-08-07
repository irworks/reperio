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
        
        //[self setupLabels];
        [self setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    return self;
}

- (void)setupConstraints {
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self
                                                             attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute multiplier:1
                                                              constant:180];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute multiplier:1
                                                               constant:80];
    
    [self addConstraint:width];
    [self addConstraint:height];
}

- (void)setupLabels {
    UILabel *ipTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    //[ipTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
    [ipTitle setText:@"IP address:"];
    [self addSubview:ipTitle];
    
    NSLayoutConstraint *marginL = [NSLayoutConstraint constraintWithItem:ipTitle
                                                               attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self
                                                               attribute:NSLayoutAttributeWidth multiplier:0.8
                                                                constant:0.0];
    
    NSLayoutConstraint *heightIP = [NSLayoutConstraint constraintWithItem:ipTitle
                                                                attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self
                                                                attribute:NSLayoutAttributeHeight multiplier:0.2
                                                                 constant:0.0];
    
    //[self addConstraint:marginL];
    //[self addConstraint:heightIP];
}

@end
