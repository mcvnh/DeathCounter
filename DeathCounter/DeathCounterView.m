//
//  DeathCounterView.m
//  DeathCounter
//
//  Created by Mac Van Anh on 7/23/20.
//  Copyright © 2020 Mac Van Anh. All rights reserved.
//

#import "DeathCounterView.h"
#import <WebKit/WebKit.h>

@implementation DeathCounterView

static NSString * const deathCounterModule = @"com.anhmv.deathcounter";

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    
    if (self) {
        stackView = [NSStackView new];

        daysView = [SectionView new];
        hoursView = [SectionView new];
        minutesView = [SectionView new];
        secondsView = [SectionView new];
        
        [stackView addArrangedSubview:daysView];
        [stackView addArrangedSubview:hoursView];
        [stackView addArrangedSubview:minutesView];
        [stackView addArrangedSubview:secondsView];

        [daysView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [hoursView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [minutesView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [secondsView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];

        [self addSubview:stackView];
        
        [stackView setSpacing:self.frame.size.width * 0.05];

        [self addConstraint:[stackView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]];
        [self addConstraint:[stackView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]];

        // set sample test
        [daysView setValueText:@"7777"];
        [daysView setLabelText:@"Days"];

        [hoursView setValueText:@"24"];
        [hoursView setLabelText:@"Hours"];

        [minutesView setValueText:@"00"];
        [minutesView setLabelText:@"Minutes"];

        [secondsView setValueText:@"00"];
        [secondsView setLabelText:@"Seconds"];
    }
    
    return self;
}
    
- (void)animateOneFrame
{
    [self stopAnimation];
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
