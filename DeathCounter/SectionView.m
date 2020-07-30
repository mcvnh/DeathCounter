//
//  SectionView.m
//  DeathCounter
//
//  Created by Mac Van Anh on 7/29/20.
//  Copyright © 2020 Mac Van Anh. All rights reserved.
//

#import "SectionView.h"

@implementation SectionView

- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];

    value = [LabelView new];
    label = [LabelView new];
    
    [label setTextColor:[NSColor colorWithWhite:1.0 alpha:0.4]];
    
    [value setTranslatesAutoresizingMaskIntoConstraints:NO];
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addArrangedSubview:value];
    [self addArrangedSubview:label];
    [self setOrientation:NSUserInterfaceLayoutOrientationVertical];
    [self setAlignment:NSLayoutAttributeCenterX];

    return self;
}

- (void)setLabelText:(NSString *)text
{
    [self->label setStringValue:text];
}

- (void)setValueText:(NSString *)text
{
    [self->value setStringValue:text];
}

- (void)setMainFont:(NSFont *)font
{
    [self->value setFont:font];
}

- (void)setSubFont:(NSFont *)font
{
    [self->label setFont:font];
}

- (void)setHideLabel:(bool)flag
{
    [self->label setHidden:flag];
}
@end
