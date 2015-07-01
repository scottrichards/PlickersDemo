//
//  TestData.m
//  PlickerDemo
//
//  Created by Scott Richards on 6/27/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import "TestData.h"
#import "QuestionData.h"
#import "NSMutableArray+Utility.h"
#import "ResponseObject.h"
#import "StudentResponses.h"
#import "ChoiceObject.h"

const int kUnspecifiedValue = -1;

@implementation TestData


-(void)parseJSONTestData:(NSArray *)jsonArray
{
    _correctAnswers = [[NSMutableArray alloc] initWithCapacity:[jsonArray count]];
    _questions = [[NSMutableArray alloc] initWithCapacity:[jsonArray count]];
    _studentResponsesDictionary = [NSMutableDictionary new];
    [_correctAnswers fillArray:[jsonArray count] initialValue:@-1];      // fill array with unspecified values
    NSUInteger questionNumber = 0;
    for (NSDictionary *item in jsonArray) {
        NSLog(@"item: %@",item);
        NSDictionary *question = item[@"question"];
        QuestionData *questionData = [QuestionData new];
        if (question) {
            questionData.body = [NSString stringWithFormat:@"%lu. %@",questionNumber + 1,question[@"body"]];
            questionData.answer = kUnspecifiedValue;
            // parse the choices for each question and identify the correct answer
            NSArray *choices = question[@"choices"];
            if (choices) {
                questionData.choices = [NSMutableArray new];
                for (NSUInteger i=0;i<[choices count];i++) {
                    ChoiceObject *choiceObject = [ChoiceObject new];
                    NSDictionary *choice = choices[i];
                    NSString *choiceString = [NSString stringWithFormat:@"%@) %@",[questionData mapAnswerToLetter:i],choice[@"body"]];
                    choiceObject.body = choiceString;
                    NSNumber *isSuccessNumber = choice[@"correct"];
                    if ([isSuccessNumber boolValue]) {
                        choiceObject.correct = true;
                        NSLog(@"correct choice is: %ld",i);
                        NSNumber *correctAnswer = [NSNumber numberWithUnsignedInt:(uint)i];
                        [_correctAnswers replaceObjectAtIndex:questionNumber withObject:correctAnswer];
                        questionData.answer = i;
                    }
                    [questionData.choices addObject:choiceObject];
                }
            }
        }
        NSArray *responses = item[@"responses"];
        if (responses) {
            questionData.numResponses = [responses count];
            for (NSDictionary *response in responses) {
                BOOL isCorrect;
                NSString *studentName = response[@"student"];
                StudentResponses *studentResponse = _studentResponsesDictionary[studentName];
                if (!studentResponse) {
                    studentResponse = [StudentResponses new];
                    studentResponse.name = studentName;
                    _studentResponsesDictionary[studentName] = studentResponse;
                }
                NSString *studentAnswer = response[@"answer"];
                [questionData addResponse:studentAnswer];
                if (questionData)
                    isCorrect = [questionData isAnswerCorrect:studentAnswer];
                NSLog(@"Student: %@ Answer: %@ Correct: %@",studentName,response[@"answer"], isCorrect ? @"Yes" : @"No");
                if (isCorrect) {
                    questionData.numCorrect++;
                    studentResponse.numCorrect++;
                }
                studentResponse.numResponses++;
            }
            float percentCorrect = (float)questionData.numCorrect/questionData.numResponses;
            questionData.percentCorrect = [NSNumber numberWithFloat:percentCorrect];
            NSLog(@"Question #: %ld # Responses: %ld # Correct: %ld Correct: %f",questionNumber,questionData.numResponses,questionData.numCorrect,percentCorrect);
        }
        _questions[questionNumber++] = questionData;
    }
    uint questionCount = 0;
    // iterate through all studentResults and add them to array
    _studentResults = [NSMutableArray new];
    for (NSString *key in _studentResponsesDictionary) {
        StudentResponses *studentResponse = [_studentResponsesDictionary objectForKey: key];
        [_studentResults addObject:studentResponse];
    }
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"numCorrect"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    _studentResults = (NSMutableArray *)[_studentResults sortedArrayUsingDescriptors:sortDescriptors];
    
    for (NSNumber *correctAnswer in _correctAnswers) {
        NSLog(@"Question #: %d answer = %ld",questionCount++,[correctAnswer integerValue]);
    }
}


@end
