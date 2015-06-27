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

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) // Background thread constant for convenience
#define kPlickersJSONData [NSURL URLWithString:@"http://plickers-interview.herokuapp.com/polls"] // link to plickers json data source



@interface ViewController ()
@property (strong, nonatomic) TestData *testData;
@property (strong, nonatomic) NSMutableArray *correctAnswers;
@property (strong, nonatomic) NSMutableArray *questions;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        kPlickersJSONData];
        // TO DO don't do this on the main thread for long JSON feeds
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
}



- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSArray* jsonArray = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    _testData = [TestData new];
    [_testData parseJSONTestData:jsonArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toQuestionData"]) {
        QuestionDataTableViewController *questionDataController = [segue destinationViewController];
        questionDataController.testData = _testData;
    }
}

@end
