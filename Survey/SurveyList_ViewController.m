//
//  ViewController.m
//  Survey
//
//  Created by Admin on 8/1/15.
//  Copyright (c) 2015 Amit. All rights reserved.
//

#import "SurveyList_ViewController.h"
#import "SurveyEngine.h"
#import "Survey.h"
#import "Survey_TableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "LoadingWrapper.h"

@interface SurveyList_ViewController () <SurveyEngine_Delegate,UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView* surveyTableView;
    IBOutlet UIBarButtonItem* refershItem;
    IBOutlet UIButton* takeSurveyButton;
    IBOutlet UIPageControl* surveyListPageControl;
    
    LoadingWrapper* loadingIndicatorView;
    
    SurveyEngine* surveyEngine;
    
    NSMutableArray* surveyList;
}

@end

@implementation SurveyList_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    surveyListPageControl.transform = CGAffineTransformMakeRotation(M_PI / 2);
    surveyEngine = [[SurveyEngine alloc]initWithCaller:self];
    surveyList = [NSMutableArray new];
    loadingIndicatorView = [[LoadingWrapper alloc]init];
    
    [self requestSurveyList];
}

#pragma mark - API Request Start & Finish load methods
- (void)requestSurveyList {
    
    [loadingIndicatorView showGlobalHudWithMessage:@""];
    takeSurveyButton.hidden = YES;
    refershItem.enabled = NO;
    //surveyListPageControl.numberOfPages = 0;
    
    [surveyList removeAllObjects];
    [surveyEngine getSurveyList];
    [surveyTableView reloadData];
}

- (void)loadSurveyListWithResponseStatus:(BOOL)isSuccess
{
    if(isSuccess) {
        if(surveyList.count > 0) {
            takeSurveyButton.hidden = NO;
        }
        surveyListPageControl.numberOfPages = [surveyList count];
        [surveyTableView reloadData];
    } else {
        takeSurveyButton.hidden = YES;
        surveyListPageControl.numberOfPages = 0;
        [loadingIndicatorView hideGlobalHud];
    }
    
    refershItem.enabled = YES;
    [loadingIndicatorView hideGlobalHud];
}

#pragma mark - IBActions
- (IBAction)refersh:(id)sender {
    [self requestSurveyList];
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [surveyList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.frame.size.height;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Survey_TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SurveyCellIdentifier" forIndexPath:indexPath];
    [cell.surveyTitle setPreferredMaxLayoutWidth:200.0];
    
    cell.surveyTitle.text = [(Survey*)[surveyList objectAtIndex:indexPath.row] title];
    cell.surveyDescription.text = [(Survey*)[surveyList objectAtIndex:indexPath.row] surveyDescription];
    [cell.surveyImageView setImageWithURL:[NSURL URLWithString:[(Survey*)[surveyList objectAtIndex:indexPath.row] coverImageUrl]]];
    
    return cell;
}

#pragma mark - UIScrollView/Tableview-Scroll Delegate Method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentSize.height > [[UIScreen mainScreen] bounds].size.height) {
        surveyListPageControl.currentPage = round(scrollView.contentOffset.y / scrollView.frame.size.height);
    }
}

#pragma mark - Survey Engine Delegate Methods
- (void)surveyEngineCompletedWithObject:(NSArray*)responseSurveyList andOperationType:(SurveyOperationType)operationType
{
    switch (operationType) {
        case SurveyOperationTypeGetSurveyList:
        {
            [surveyList removeAllObjects];
            [surveyList addObjectsFromArray:responseSurveyList];
            [self loadSurveyListWithResponseStatus:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)surveyEngineFailedWithError:(NSError*)error andOperationType:(SurveyOperationType)operationType
{
    switch (operationType) {
            
        case SurveyOperationTypeGetSurveyList:
        {
            [self loadSurveyListWithResponseStatus:NO];
            
            UIAlertView* errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error while loading Survey list. Please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [errorAlert show];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - SurveyEngine Delegate Methods

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
