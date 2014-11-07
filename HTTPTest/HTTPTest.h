//
//  HTTPTest.h
//  HTTPTest
//
//  Created by Stefan Reitshamer on 11/7/14.
//  Copyright (c) 2014 Stefan Reitshamer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPTest : NSObject {
    NSMutableData *body;
    NSString *uuid;
    BOOL done;
}
- (void)works;
- (void)doesntWork;
@end
