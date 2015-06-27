//
//  ResponseObject.h
//  PlickerDemo
//
//  Created by Scott Richards on 6/27/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseObject : NSObject
@property (strong, nonatomic) NSString *body;
@property (assign, nonatomic) NSString *answer;
@property (assign, nonatomic) BOOL correct;
@end
