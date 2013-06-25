//
//  MSDLoginViewController.m
//  Goalsetter
//
//  Created by Matthew Dobson on 6/22/13.
//  Copyright (c) 2013 Matthew Dobson. All rights reserved.
//

#import "MSDLoginViewController.h"
#import "UGConnection.h"
#import "UGHTTPClient.h"
#import "UGHTTPResult.h"

@interface MSDLoginViewController ()

@end

@implementation MSDLoginViewController

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

-(IBAction)login:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    NSMutableURLRequest *request = [[UGConnection sharedConnection] getAccessTokenForApplicationWithUsername:username password:password];
    
    [[[UGHTTPClient alloc] initWithRequest:request] connectWithCompletionHandler:^(UGHTTPResult *result){
        if (result.error) {
            NSLog(@"error:%@", [result error]);
        } else {
            NSLog(@"success:%@", [result object]);
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *userProfile = [[result object] objectForKey:@"user"];
            NSString *username = [userProfile objectForKey:@"username"];
            [defaults setObject:username forKey:@"username"];
            [[UGConnection sharedConnection] authenticateWithResult:result];
            if ([[UGConnection sharedConnection] isAuthenticated]) {
                NSLog(@"Token is good!");
            }
            
            [self performSegueWithIdentifier:@"goals" sender:self];
        }
    }];
    
}

@end
