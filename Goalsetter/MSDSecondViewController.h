//
//  MSDSecondViewController.h
//  Goalsetter
//
//  Created by Matthew Dobson on 6/22/13.
//  Copyright (c) 2013 Matthew Dobson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSDSecondViewController : UIViewController

@property (nonatomic,retain) IBOutlet UITextField *goalField;
@property (nonatomic,retain) IBOutlet UITextField *startField;
@property (nonatomic,retain) IBOutlet UITextField *endField;

-(IBAction)createGoal:(id)sender;

@end
