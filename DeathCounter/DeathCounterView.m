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
    
    ScreenSaverDefaults *defaults;
    defaults = [ScreenSaverDefaults defaultsForModuleWithName:deathCounterModule];
    [defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
           @"1991/10/27", @"birthday",
           nil]];
    [defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
            @"50", @"expectedDeathAge",
       nil]];

    // WebView
    NSString *birthday = [defaults stringForKey:@"birthday"];
    NSString *expectedDeathAge = [defaults stringForKey:@"expectedDeathAge"];

    NSURL* indexHTML = [NSURL URLWithString:[[[[NSURL fileURLWithPath:[[NSBundle bundleForClass:self.class].resourcePath stringByAppendingString:@"/index.html"] isDirectory:NO] description] stringByAppendingFormat:@"?birthday=%@", birthday] stringByAppendingFormat:@"&expectedDeathAge=%@", expectedDeathAge]];

    WKWebView* webView = [[WKWebView alloc] initWithFrame:NSMakeRect(0, 0, frame.size.width, frame.size.height)];
    [webView setValue: @NO forKey: @"drawsBackground"];
    NSURLRequest *nsRequest = [NSURLRequest requestWithURL:indexHTML cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval: 30.0];
    
    [webView loadRequest:nsRequest];
    
    [self addSubview:webView];
    
    return self;
}

- (void)animateOneFrame
{
    [self stopAnimation];
}

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

@end
