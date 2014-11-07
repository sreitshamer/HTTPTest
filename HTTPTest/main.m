//
//  main.m
//  HTTPTest
//
//  Created by Stefan Reitshamer on 11/7/14.
//  Copyright (c) 2014 Stefan Reitshamer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPTest.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        HTTPTest *test = [[[HTTPTest alloc] init] autorelease];
        
        NSLog(@"the first run destroys the HTTPInputStream; subsequent runs do not");
        
        [test go];
        [test go];
    }
    return 0;
}
