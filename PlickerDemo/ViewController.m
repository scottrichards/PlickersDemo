//
//  ViewController.m
//  PlickerDemo
//
//  Created by Scott Richards on 6/26/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableArray+Utility.h"
#import "QuestionData.h"
#import "TestData.h"
#import "QuestionDataTableViewController.h"
#import "QuestionResultsTableViewController.h"
#import "StudentResultsTableViewController.h"

//#define USE_LOCAL_DATA

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) // Background thread constant for convenience
#define kPlickersJSONData [NSURL URLWithString:@"http://plickers-interview.herokuapp.com/polls"] // link to plickers json data source



@interface ViewController ()
@property (strong, nonatomic) TestData *testData;
@property (strong, nonatomic) NSMutableArray *correctAnswers;
@property (strong, nonatomic) NSMutableArray *questions;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    _activityIndicator.center = self.view.center;
    [self.view addSubview:_activityIndicator];
    [_activityIndicator startAnimating];
    
    dispatch_async(kBgQueue, ^{
#ifdef USE_LOCAL_DATA
        NSString *feedBundlePath = [[NSBundle mainBundle] pathForResource:@"Feed" ofType:@"json"];
        NSData* data = [NSData dataWithContentsOfFile:feedBundlePath];
#else
        NSData* data = [NSData dataWithContentsOfURL:kPlickersJSONData];
#endif
        NSError* error;
        NSArray* jsonArray = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:kNilOptions
                              error:&error];
        _testData = [TestData new];
        [_testData parseJSONTestData:jsonArray];
        [self performSelectorOnMainThread:@selector(stopAnimation) withObject:nil waitUntilDone:0];
    });
}

- (void)stopAnimation
{
    [_activityIndicator stopAnimating];
    [_activityIndicator setHidden:YES];
    [_activityIndicator removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    if ([segue.identifier isEqualToString:@"toQuestionData"]) {
        QuestionDataTableViewController *questionDataController = [segue destinationViewController];
        questionDataController.testData = _testData;
    } else if ([segue.identifier isEqualToString:@"toQuestionResults"]) {
        QuestionResultsTableViewController *questionResultsController = [segue destinationViewController];
        questionResultsController.testData = _testData;
    } else if ([segue.identifier isEqualToString:@"toStudentResults"]) {
        StudentResultsTableViewController *studentResultsController = [segue destinationViewController];
        studentResultsController.testData = _testData;
    }
}

@end
