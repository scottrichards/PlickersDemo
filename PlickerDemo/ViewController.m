//
//  ViewController.m
//  PlickerDemo
//
//  Created by Scott Richards on 6/26/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableArray+Utility.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) // Background thread constant for convenience
#define kLatestKivaLoansURL [NSURL URLWithString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"] //2
#define kPlickersJSONData [NSURL URLWithString:@"http://plickers-interview.herokuapp.com/polls"] // link to plickers json data source


@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *correctAnswers;
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

    _correctAnswers = [[NSMutableArray alloc] initWithCapacity:[jsonArray count]];
    [_correctAnswers fillArray:[jsonArray count] initialValue:@-1];      // fill array with unspecified values
    NSUInteger questionNumber = 0;
    for (NSDictionary *item in jsonArray) {
        NSLog(@"item: %@",item);
        NSDictionary *question = item[@"question"];
        if (question) {
            NSArray *choices = question[@"choices"];
            if (choices) {
                for (NSUInteger i=0;i<[choices count];i++) {
                    NSDictionary *choice = choices[i];
                    if ([choice[@"correct"] isEqualToString:@"true"]) {
                        NSLog(@"correct choice is: %ld",i);
                        NSNumber *correctAnswer = [NSNumber numberWithUnsignedInt:(uint)i];
                        [_correctAnswers replaceObjectAtIndex:questionNumber withObject:correctAnswer];
                    }
                }
            }
        }
        questionNumber++;
    }
    uint questionCount = 0;
    for (NSNumber *correctAnswer in _correctAnswers) {
        NSLog(@"Question #: %d answer = %ld",questionCount++,[correctAnswer integerValue]);
    }
    
//    NSArray* questionData = [json objectForKey:@"question"]; //2
//    NSLog(@"questionData: %@", questionData); //3

//    NSLog(@"loans: %@", latestLoans); //3
//    
//    // 1) Get the latest loan
//    NSDictionary* loan = [latestLoans objectAtIndex:0];
//    
//    NSNumber* fundedAmount = [loan objectForKey:@"funded_amount"];
//    NSNumber* loanAmount = [loan objectForKey:@"loan_amount"];
//    float outstandingAmount = [loanAmount floatValue] -
//    [fundedAmount floatValue];
//    
//    // 3) Set the label appropriately
//    NSString *readableString = [NSString stringWithFormat:@"Latest loan: %@ from %@ needs another $%.2f to pursue their entrepreneural dream",
//                         [loan objectForKey:@"name"],
//                         [(NSDictionary*)[loan objectForKey:@"location"]
//                          objectForKey:@"country"],
//                         outstandingAmount];
//    NSLog(@"readable string: %@",readableString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
