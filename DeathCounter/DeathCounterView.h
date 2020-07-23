//
//  DeathCounterView.h
//  DeathCounter
//
//  Created by Mac Van Anh on 7/23/20.
//  Copyright © 2020 Mac Van Anh. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>

@interface DeathCounterView : ScreenSaverView {
    IBOutlet id configSheet;
    IBOutlet NSTextField *birthday;
    IBOutlet NSTextField *expectedDeathAge;
}
@end
