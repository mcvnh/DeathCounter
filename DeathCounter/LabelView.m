//
//  LabelView.m
//  DeathCounter
//
//  Created by Mac Van Anh on 7/29/20.
//  Copyright © 2020 Mac Van Anh. All rights reserved.
//

#import "LabelView.h"

@implementation LabelView

- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];

    [self setBezeled:NO];
    [self setDrawsBackground:NO];
    [self setTextColor:[NSColor whiteColor]];
    [self setEditable:NO];
    [self setSelectable:NO];
    [self setAlignment:NSTextAlignmentCenter];

    return self;
}

@end
