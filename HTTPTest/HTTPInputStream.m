//
//  HTTPInputStream.m
//
//  Created by Stefan Reitshamer on 3/16/12.
//  Copyright 2012 Haystack Software. All rights reserved.
//

#import "HTTPInputStream.h"


@implementation HTTPInputStream
- (id)initWithData:(NSData *)theData {
    if (self = [super init]) {
        data = [theData retain];
        inputStream = [[NSInputStream inputStreamWithData:theData] retain];
    }
    NSLog(@"created HTTPInputStream: %p", self);
    return self;
}
- (void)dealloc {
    NSLog(@"destroying HTTPInputStream: %p", self);
    [data release];
    [inputStream release];
    [super dealloc];
}

- (id)retain {
//    HSLogDebug(@"retaining %p; retaincount was %ld; threadname=%@", self, [self retainCount], [NSThread currentThread]);
    return [super retain];
}
- (oneway void)release {
//    HSLogDebug(@"releasing %p; retaincount was %ld; threadname=%@", self, [self retainCount], [NSThread currentThread]);
    [super release];
}

- (NSInteger)read:(uint8_t *)buffer maxLength:(NSUInteger)len {
    NSInteger ret = [inputStream read:buffer maxLength:len];
    return ret;
}


// Implement most of the NSInputStream methods:
- (void)open {
    [inputStream open];
}
- (void)close {
    [inputStream close];
}
- (id)delegate {
    return [inputStream delegate];
}
- (void)setDelegate:(id)theDelegate {
    [inputStream setDelegate:theDelegate];
}
- (void)scheduleInRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode {
    [inputStream scheduleInRunLoop:aRunLoop forMode:mode];
}
- (void)removeFromRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode {
    [inputStream removeFromRunLoop:aRunLoop forMode:mode];
}
- (id)propertyForKey:(NSString *)key {
    return [inputStream propertyForKey:key];
}
- (BOOL)setProperty:(id)property forKey:(NSString *)key {
    return [inputStream setProperty:property forKey:key];
}
- (NSStreamStatus)streamStatus {
    return [inputStream streamStatus];
}
- (NSError *)streamError {
    return [inputStream streamError];
}


// Forward everything else to the inputStream ivar.
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [inputStream methodSignatureForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:inputStream];
}
@end
