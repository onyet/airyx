/*
 * Copyright (C) 2022 Zoe Knox <zoe@pixin.net>
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import <AppKit/AppKit.h>
#import "desktop.h"

@implementation ClockView
- init {
    NSRect frame = [[NSScreen mainScreen] visibleFrame];
    dateFormatter = [NSDateFormatter new];
    dateFormat = @"%Y/%m/%d__%H:%M";
    [dateFormatter setDateFormat:dateFormat];

    self = [super initWithFrame:NSMakeRect(frame.size.width - 300, menuBarVPad, 300, menuBarHPad)];
    [self setDrawsBackground:NO];
    [self setEditable:NO];
    NSFont *font = [NSFont systemFontOfSize:18];
    attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];

    [self update:nil];
    NSRect f = [self frame];
    f.size = [[self textStorage] size];
    f.origin.x = frame.size.width - f.size.width - menuBarHPad;
    [self setFrame:f];
    [self setNeedsDisplay:YES];

    updateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self 
        selector:@selector(update:) userInfo:nil repeats:YES];
    return self;
}

- (void)dealloc {
    [updateTimer invalidate];
    [super dealloc];
}

- (void)update:(NSTimer *)timer {
    [[self textStorage] setAttributedString:[[NSAttributedString alloc]
        initWithString:[[dateFormatter stringFromDate:[NSDate date]]
        stringByReplacingOccurrencesOfString:@"_" withString:@" "] attributes:attributes]];
    [self setNeedsDisplay:YES];
}

@end

