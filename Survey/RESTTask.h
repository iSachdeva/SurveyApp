//
//  RestTask.h
//  Survey
//
//  Created by Admin on 8/1/15.
//  Copyright (c) 2015 Amit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RESTOperationType) {
    
    RESTOperationTypeSurveyList
};

@protocol RESTTask_Delegate <NSObject>

- (void)operationCompletedWithObject:(id)object andOperationType:(RESTOperationType)operationType;
- (void)operationFailedWithError:(NSError*)error andOperationType:(RESTOperationType)operationType;

@end

@interface RESTTask : NSObject

@property (nonatomic, strong) id delegate;

-(id)initWithCaller:(id)delegate_;
-(void)networkRequestTogetSurveyList;

@end
