//
//  LoadingWrapper.h
//  Survey
//
//  Created by Admin on 8/2/15.
//  Copyright (c) 2015 Amit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadingWrapper : NSObject

- (void)showGlobalHudWithMessage:(NSString *)message;
- (void)hideGlobalHud;
+ (BOOL)isLoading;


@end
