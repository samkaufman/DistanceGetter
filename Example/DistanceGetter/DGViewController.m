//
//  DGViewController.m
//  DistanceGetter
//
//  Created by Sam Kaufman on 09/11/2015.
//  Copyright (c) 2015 Sam Kaufman. All rights reserved.
//

#import <DistanceGetter/DGDistanceRequest.h>
#import "DGViewController.h"

@interface DGViewController ()

@property (weak, nonatomic) IBOutlet UIButton *updateButton;
@property (weak, nonatomic) IBOutlet UITextField *sourceTextField;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstAnswerLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondAnswerLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdAnswerLabel;

@end

@implementation DGViewController

- (IBAction)updateButtonTapped:(id)sender {
    self.updateButton.enabled = NO;
    
    NSArray *locs = @[self.firstLabel.text, self.secondLabel.text, self.thirdLabel.text];
    
    DGDistanceRequest *req = [[DGDistanceRequest alloc] initWithLocationDescriptions:locs sourceDescription:self.sourceTextField.text];
    req.callback = ^(NSArray *distances) {
        NSString *fmtStr = @"%.2f meters";
        
        self.firstAnswerLabel.text = [NSString stringWithFormat:fmtStr, [distances[0] doubleValue]];
        self.secondAnswerLabel.text = [NSString stringWithFormat:fmtStr, [distances[1] doubleValue]];
        self.thirdAnswerLabel.text = [NSString stringWithFormat:fmtStr, [distances[2] doubleValue]];
        
        self.updateButton.enabled = YES;
    };
    [req start];
}

@end
