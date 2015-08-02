//
//  RestTask.m
//  Survey
//
//  Created by Admin on 8/1/15.
//  Copyright (c) 2015 Amit. All rights reserved.
//

#import "RESTTask.h"
#import "Constants.h"

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
    
    NSString* url = [NSString stringWithFormat:@"%@?access_token=%@",BASE_URL,CRENDITIALS];
    NSMutableURLRequest *urlRequest = [self createRequestWithUrl:url params:nil httpMethod:HTTP_METHOD_GET];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *connectionError) {
                               NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                               
                               if(connectionError) {
                                   NSLog(@"Error: %@",connectionError);
                                   [self.delegate operationFailedWithError:connectionError andOperationType:RESTOperationTypeSurveyList];
                               } else {
                                   NSLog(@"Response: %@",responseStr);
                                   id responseObject = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingAllowFragments error:nil];
                                   if(responseObject != nil) {
                                       [self.delegate operationCompletedWithObject:responseObject andOperationType:RESTOperationTypeSurveyList];
                                   } else {
                                       [self.delegate operationFailedWithError:[[NSError alloc] initWithDomain:ERROR_MESSAGE_INVALID_RESPONSE code:[ERRORCODE_INVALID_RESPONSE integerValue] userInfo:nil] andOperationType:RESTOperationTypeSurveyList];
                                   }
                                   
                               }
                           }];
}


#pragma mark - Create Network Request (a generic method for all APIs)
- (NSMutableURLRequest*)createRequestWithUrl:(NSString *)url_ params:(id)params httpMethod:(NSString *)httpMethod
{
    //HTTP Basic Authentication
    NSString *authenticationString = [NSString stringWithFormat:@"%@:%@", USERNAME, PASSWORD];
    NSData *authenticationData = [authenticationString dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authenticationValue = [authenticationData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url_] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [urlRequest setValue:[NSString stringWithFormat:@"Basic %@", authenticationValue] forHTTPHeaderField:@"Authorization"];
    
    if (params) {
        NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
        [urlRequest setValue:[NSString stringWithFormat:@"application/json; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
        
        [urlRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil]];
    }
    
    [urlRequest setHTTPMethod:httpMethod];
    
    return urlRequest;
}

@end
