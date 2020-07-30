//
//  SectionView.h
//  DeathCounter
//
//  Created by Mac Van Anh on 7/29/20.
//  Copyright © 2020 Mac Van Anh. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LabelView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SectionView : NSStackView {
    LabelView *value;
    LabelView *label;
}

- (void)setValueText:(NSString *)text;
- (void)setLabelText:(NSString *)text;
- (void)setMainFont:(NSFont *)font;
- (void)setSubFont:(NSFont *)font;
- (void)setHideLabel:(bool)flag;

@end

NS_ASSUME_NONNULL_END
