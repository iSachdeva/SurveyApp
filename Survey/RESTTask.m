//
//  RestTask.m
//  Survey
//
//  Created by Admin on 8/1/15.
//  Copyright (c) 2015 Amit. All rights reserved.
//

#import "RESTTask.h"
#import "Constants.h"
#import "Session.h"
#import <AFHTTPRequestOperationManager.h>

@implementation RESTTask

@synthesize delegate;

-(id)initWithCaller:(id)delegate_
{
    self = [super init];
    if (self) {
        delegate  = delegate_;

    }
    return self;
}

- (void)networkRequestTogetSurveyList {
    
    NSString* url = [NSString stringWithFormat:@"%@?access_token=%@",BASE_URL,[[Session sharedSession] token]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSURLCredential *credential = [NSURLCredential credentialWithUser:USERNAME password:PASSWORD persistence:NSURLCredentialPersistenceNone];
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"GET" URLString:url parameters:nil error:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCredential:credential];
    [operation setResponseSerializer:[AFJSONResponseSerializer alloc]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(responseObject != nil) {
            [self.delegate operationCompletedWithObject:responseObject andOperationType:RESTOperationTypeSurveyList];
        } else {
            [self.delegate operationFailedWithError:[[NSError alloc] initWithDomain:ERROR_MESSAGE_INVALID_RESPONSE code:[ERRORCODE_INVALID_RESPONSE integerValue] userInfo:nil] andOperationType:RESTOperationTypeSurveyList];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
         [self.delegate operationFailedWithError:error andOperationType:RESTOperationTypeSurveyList];
        
    }];
    
    [manager.operationQueue addOperation:operation];
}

@end
