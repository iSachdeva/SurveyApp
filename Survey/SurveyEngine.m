//
//  SurveyEngine.m
//  Survey
//
//  Created by Admin on 8/1/15.
//  Copyright (c) 2015 Amit. All rights reserved.
//

#import "SurveyEngine.h"
#import "AppDelegate.h"
#import "RESTTask.h"
#import "Survey.h"

@interface SurveyEngine() <RESTTask_Delegate> {
    
    AppDelegate *appDelegate;
}

@end

@implementation SurveyEngine

#pragma mark - init Method
-(id)initWithCaller:(id)delegate_
{
    self = [super init];
    if (self) {
        self.delegate  = delegate_;
        appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    }
    return self;
}

#pragma mark - GetSurveyList
- (void)getSurveyList {
    
    RESTTask* restTask = [[RESTTask alloc]initWithCaller:self];
    [restTask networkRequestTogetSurveyList];
}


#pragma mark - Service the Response

- (NSMutableArray*)parseTheSurveyList:(NSArray*)responseSurveyList {
    //Instead of manaul parsing, we can use third party code also which auto parse the dictionary object into Modal class object. The third party code will be preferrable in more complex data handling
    
    NSMutableArray *surveyList = [NSMutableArray new];
    
    if(responseSurveyList!=nil && [responseSurveyList isKindOfClass:[NSArray class]] && [responseSurveyList count] > 0) {
        
        for(NSInteger i = 0; i < responseSurveyList.count; i++ ) {
            
            NSDictionary* aSurvey = [responseSurveyList objectAtIndex:i];
            Survey* survey = [Survey new];
            
            NSString *title = [aSurvey objectForKey:@"title"];
            NSString *description = [aSurvey objectForKey:@"description"];
            NSString *coverImageUrl = [aSurvey objectForKey:@"cover_image_url"];
            BOOL isActive = [[aSurvey objectForKey:@"is_active"] boolValue];
            
            if(isActive) {
                if(title == nil || [title isKindOfClass:[NSNull class]]) {
                    title = @"";
                }
                if(description == nil || [description isKindOfClass:[NSNull class]]) {
                    description = @"";
                }
                if(coverImageUrl == nil || [coverImageUrl isKindOfClass:[NSNull class]]) {
                    coverImageUrl = @"";
                }
                
                survey.title = title;
                survey.surveyDescription = description;
                survey.coverImageUrl = coverImageUrl;
                [surveyList addObject:survey];
            }
        }
    }
    
    return surveyList;
}

#pragma mark - RESTTask Delegate Methods
- (void)operationCompletedWithObject:(id)object andOperationType:(RESTOperationType)operationType {
    switch (operationType) {
        case RESTOperationTypeSurveyList:
        {
            NSArray* responseSurveyList = (NSArray*)object;
            NSMutableArray* surveyList = [self parseTheSurveyList:responseSurveyList];
            if(self.delegate && [self.delegate respondsToSelector:@selector(surveyEngineCompletedWithObject:andOperationType:)]){
                [self.delegate surveyEngineCompletedWithObject:surveyList andOperationType:SurveyOperationTypeGetSurveyList];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)operationFailedWithError:(NSError *)error andOperationType:(RESTOperationType)operationType {
    
    switch (operationType) {
        case RESTOperationTypeSurveyList:
            if(self.delegate && [self.delegate respondsToSelector:@selector(surveyEngineFailedWithError:andOperationType:)]) {
                [self.delegate surveyEngineFailedWithError:error andOperationType:SurveyOperationTypeGetSurveyList];
            }
            break;
            
        default:
            break;
    }
}


@end
