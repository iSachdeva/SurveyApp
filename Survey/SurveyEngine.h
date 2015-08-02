//
//  SurveyEngine.h
//  Survey
//
//  Created by Admin on 8/1/15.
//  Copyright (c) 2015 Amit. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, SurveyOperationType) {
    SurveyOperationTypeGetSurveyList
};

@protocol SurveyEngine_Delegate <NSObject>

- (void)surveyEngineCompletedWithObject:(id)object andOperationType:(SurveyOperationType)operationType;
- (void)surveyEngineFailedWithError:(NSError*)error andOperationType:(SurveyOperationType)operationType;

@end

@interface SurveyEngine : NSObject

@property (nonatomic, assign) id delegate;

-(id)initWithCaller:(id)delegate_;
-(void)getSurveyList;

@end
