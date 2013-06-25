//
//  MSDLoginViewController.h
//  Goalsetter
//
//  Created by Matthew Dobson on 6/22/13.
//  Copyright (c) 2013 Matthew Dobson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSDLoginViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;


-(IBAction)login:(id)sender;
@end

