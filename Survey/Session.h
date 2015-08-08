//
//  Session.h
//  Survey
//
//  Created by Admin on 8/9/15.
//  Copyright (c) 2015 Amit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Session : NSObject

#pragma mark - initialization of Shared Session object
+(Session *)sharedSession;

#pragma mark - Token

@property (nonatomic, strong) NSString* token;

@end
