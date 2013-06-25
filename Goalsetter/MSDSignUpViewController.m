//
//  MSDSignUpViewController.m
//  Goalsetter
//
//  Created by Matthew Dobson on 6/22/13.
//  Copyright (c) 2013 Matthew Dobson. All rights reserved.
//

#import "MSDSignUpViewController.h"
#import "UGConnection.h"
#import "UGHTTPClient.h"
#import "UGHTTPResult.h"

@interface MSDSignUpViewController ()

@end

@implementation MSDSignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUp:(id)sender {
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    NSString *email = self.email.text;
    NSString *name = self.name.text;
    
    UGConnection * conn = [UGConnection sharedConnection];
    conn.application = @"goalsetter";
    conn.organization = @"mdobson";
    
    NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:username, @"username", password, @"password", email, @"email", name, @"name", nil];
    
    NSMutableURLRequest * request = [conn createUserWithValues:dict];
    
    [[[UGHTTPClient alloc] initWithRequest:request] connectWithCompletionHandler:^(UGHTTPResult * result){
        if (result.error) {
            NSLog(@"Error:%@",[result error]);
        } else {
            NSLog(@"Result:%@",[result object]);
        }
    }];

    
}

@end
