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
    
    // update every second
    [self setAnimationTimeInterval:1.0];

    [self setDefaultUserInfoIfNeeded];
    
    [self fetchUserInfo];
    
    [self registerCustomFonts];

    [self buildClock];

    return self;
}

- (void)animateOneFrame
{
    NSDate *currentDay = [NSDate date];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate: currentDay toDate: self->userDeathDate options: 0];
    
    NSInteger days = [components day];
    NSInteger hours = [components hour];
    NSInteger minutes = [components minute];
    NSInteger seconds = [components second];

    [daysView setValueText:[NSString stringWithFormat:@"%02ld", days]];
    [hoursView setValueText:[NSString stringWithFormat:@"%02ld", hours]];
    [minutesView setValueText:[NSString stringWithFormat:@"%02ld", minutes]];
    [secondsView setValueText:[NSString stringWithFormat:@"%02ld", seconds]];

    [stackView setHidden:false];
}


// MARK: - Configure sheet

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (NSWindow*)configureSheet
{
    ScreenSaverDefaults *defaults;
    defaults = [ScreenSaverDefaults defaultsForModuleWithName:deathCounterModule];
    
    if (!configSheet) {
        if ( ! [[NSBundle bundleForClass:self.class] loadNibNamed:@"ConfigSheet" owner:self  topLevelObjects:nil] ) {
            NSLog( @"Failed to load configure sheet." );
        }
    }
    
    [birthday setStringValue:[defaults stringForKey:@"birthday"]];
    [expectedDeathAge setStringValue:[defaults stringForKey:@"expectedDeathAge"]];
    
    return configSheet;
}

- (IBAction)cancelClick:(id)sender {
    [[NSApplication sharedApplication] endSheet:configSheet];
}

- (IBAction)saveClick:(id)sender {
    ScreenSaverDefaults *defaults;
    defaults = [ScreenSaverDefaults defaultsForModuleWithName:deathCounterModule];

    [defaults setValue:[birthday stringValue] forKey:@"birthday"];
    [defaults setValue:[expectedDeathAge stringValue]
               forKey:@"expectedDeathAge"];

    [defaults synchronize];

    [[NSApplication sharedApplication] endSheet:configSheet];
}

// MARK: - Private methods

- (void)buildClock
{
    NSFont *mainFont = [NSFont fontWithName:@"Iceland-Regular" size:self.frame.size.width * 0.1];
    NSFont *subFont = [NSFont fontWithName:@"Iceland-Regular" size:self.frame.size.width * 0.035];

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

       [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];

       [self addSubview:stackView];
       
       [stackView setSpacing:self.frame.size.width * 0.06];

       [stackView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
       [stackView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;

       [daysView setValueText:@"0000"];
       [daysView setLabelText:@"Days"];
       [daysView setMainFont:mainFont];
       [daysView setSubFont:subFont];

       [hoursView setValueText:@"24"];
       [hoursView setLabelText:@"Hours"];
       [hoursView setMainFont:mainFont];
       [hoursView setSubFont:subFont];

       [minutesView setValueText:@"00"];
       [minutesView setLabelText:@"Minutes"];
       [minutesView setMainFont:mainFont];
       [minutesView setSubFont:subFont];

       [secondsView setValueText:@"00"];
       [secondsView setLabelText:@"Seconds"];
       [secondsView setMainFont:mainFont];
       [secondsView setSubFont:subFont];
       
       [stackView setHidden:true];
   }
}

- (void)registerCustomFonts
{
    NSArray * paths = [[NSBundle bundleForClass:self.class] pathsForResourcesOfType:@"ttf" inDirectory:@""];
    for (NSString * path in paths) {
        NSURL * url = [NSURL fileURLWithPath:path];
        CFErrorRef error;
        bool success = CTFontManagerRegisterFontsForURL(CFBridgingRetain(url), kCTFontManagerScopeProcess, &error);

        error = nil;
        
        if (success) {
            NSLog(@"Font registed %@ successful.", path);
        } else {
            NSLog(@"Font registed %@ failed.", path);
        }
    }
}

- (void)setDefaultUserInfoIfNeeded
{
    ScreenSaverDefaults *defaults;
    defaults = [ScreenSaverDefaults defaultsForModuleWithName:deathCounterModule];
    [defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
           @"1991/10/27", @"birthday",
           nil]];
    [defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
            @"50", @"expectedDeathAge",
       nil]];
}

- (void)fetchUserInfo
{
    ScreenSaverDefaults *defaults;
    defaults = [ScreenSaverDefaults defaultsForModuleWithName:deathCounterModule];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    
    NSString *birthday = [defaults stringForKey:@"birthday"];
    self->userBirthday = [dateFormat dateFromString:birthday];

    NSString *deathAge = [defaults stringForKey:@"expectedDeathAge"];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:[deathAge intValue]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    self->userDeathDate = [calendar dateByAddingComponents:dateComponents toDate:self->userBirthday options:0];
}
@end
