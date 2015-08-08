//
//  Session.m
//  Survey
//
//  Created by Admin on 8/9/15.
//  Copyright (c) 2015 Amit. All rights reserved.
//

#import "Session.h"

@implementation Session

@synthesize token;

+(Session *)sharedSession
{
    static Session *sharedObject = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}




@end
