//
//  LoadingWrapper.m
//  Survey
//
//  Created by Admin on 8/2/15.
//  Copyright (c) 2015 Amit. All rights reserved.
//

#import "LoadingWrapper.h"
#import "DejalActivityView.h"
#import "AppDelegate.h"

@implementation LoadingWrapper

- (void)showGlobalHudWithMessage:(NSString *)message {
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
    [DejalActivityView activityViewForView:window withLabel:message];
}

- (void)hideGlobalHud {
    [DejalActivityView removeView];
}

+ (BOOL)isLoading
{
    id view = [DejalActivityView currentActivityView];
    if(view) {
        return YES;
    } else {
        return NO;
    }
}



@end
