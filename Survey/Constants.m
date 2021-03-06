//
//  Constants.m
//  Survey
//
//  Created by Admin on 8/2/15.
//  Copyright (c) 2015 Amit. All rights reserved.
//

#import "Constants.h"

@implementation Constants

#pragma mark - REST & URLs
NSString * const BASE_URL = @"https://www-staging.usay.co/app/surveys.json";
NSString * const USERNAME = @"usay";
NSString * const PASSWORD = @"isc00l";
NSString * const HTTP_METHOD_GET = @"GET";
NSString * const HTTP_METHOD_POST = @"POST";

#pragma mark - ErrorMessages
NSString * const ERROR_MESSAGE_INVALID_RESPONSE = @"Invalid response. Please try again";

#pragma mark - Error Code
 NSString * const ERRORCODE_INVALID_RESPONSE = @"1001"; //Developer defined

@end
