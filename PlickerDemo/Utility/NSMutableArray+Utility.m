//
//  NSMutableArray+Utility.m
//  PlickerDemo
//
//  Created by Scott Richards on 6/26/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import "NSMutableArray+Utility.h"

@implementation NSMutableArray (Utility)
- (void)fillArray:(NSUInteger)numItems initialValue:(id)initialValue
{
    [self removeAllObjects];
    for (uint i=0;i<numItems;i++) {
        [self addObject:initialValue];
    }
}
@end
