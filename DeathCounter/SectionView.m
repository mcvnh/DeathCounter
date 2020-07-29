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
    
    [value setTranslatesAutoresizingMaskIntoConstraints:NO];
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addSubview:value];
    [self addSubview:label];
        
    [value.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [value.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [value.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [value.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    
    [label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [label.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [label.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    
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
@end
