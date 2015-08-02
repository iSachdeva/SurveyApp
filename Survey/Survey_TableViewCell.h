//
//  Survey_TableViewCell.h
//  Survey
//
//  Created by Admin on 8/2/15.
//  Copyright (c) 2015 Amit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Survey_TableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView* surveyImageView;
@property (nonatomic, weak) IBOutlet UILabel* surveyTitle;
@property (nonatomic, weak) IBOutlet UILabel* surveyDescription;


@end
