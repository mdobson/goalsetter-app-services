//
//  MSDSecondViewController.m
//  Goalsetter
//
//  Created by Matthew Dobson on 6/22/13.
//  Copyright (c) 2013 Matthew Dobson. All rights reserved.
//

#import "MSDSecondViewController.h"
#import "UGConnection.h"
#import "UGHTTPClient.h"
#import "UGHTTPResult.h"

@interface MSDSecondViewController ()

@end

@implementation MSDSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)createGoal:(id)sender {
    NSString * goal = self.goalField.text;
    double start = [self.startField.text doubleValue];
    double end = [self.endField.text doubleValue];
    
    NSDictionary * goalEntity = [[NSDictionary alloc] initWithObjectsAndKeys:goal, @"goal", [NSNumber numberWithDouble:start], @"start", [NSNumber numberWithDouble:end], @"end", nil];
    
    UGConnection *connection = [UGConnection sharedConnection];
    
    NSMutableURLRequest * request = [connection createEntityInCollection:@"goals" withValues:goalEntity];
    
    UGHTTPClient * client = [[UGHTTPClient alloc] initWithRequest:request];
    
    [client connectWithCompletionHandler:^(UGHTTPResult *result){
        if(result.error) {
            NSLog(@"error:%@", result.error);
        } else {
            //Awesome we created an entity
            NSArray * entities = [result.object objectForKey:@"entities"];
            NSDictionary * entity = [entities objectAtIndex:0];
            NSString *uuid = [entity objectForKey:@"uuid"];
            
            //Get username from defaults.
            
            NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
            
            //Connect it.
            NSMutableURLRequest * connectionRequest = [connection connectEntity:username inCollection:@"users" toEntity:uuid throughRelationship:@"setgoal"];
            
            UGHTTPClient * client = [[UGHTTPClient alloc] initWithRequest:connectionRequest];
            [client connectWithCompletionHandler:^(UGHTTPResult *result){
                if (result.error) {
                    NSLog(@"error:%@", result.error);
                } else {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Created!" message:[NSString stringWithFormat:@"Created with uuid:%@",uuid] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                }
            }];
        }
    }];
}

@end
