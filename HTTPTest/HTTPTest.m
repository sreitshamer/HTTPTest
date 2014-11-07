//
//  HTTPTest.m
//  HTTPTest
//
//  Created by Stefan Reitshamer on 11/7/14.
//  Copyright (c) 2014 Stefan Reitshamer. All rights reserved.
//

#import "HTTPTest.h"
#import "HTTPInputStream.h"

#define RUN_LOOP_MODE (@"HTTPTestMode")


@implementation HTTPTest
- (id)init {
    if (self = [super init]) {
        body = [[NSMutableData alloc] init];
        
        CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
        uuid = (NSString*)CFUUIDCreateString(nil, uuidObj);
        CFRelease(uuidObj);
        
        [body appendBytes:"--" length:2];
        [body appendData:[uuid dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendBytes:"\r\n" length:2];
        
        [body appendData:[@"Content-Disposition: form-data; name=\"emailAddress\"" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendBytes:"\r\n" length:2];
        [body appendBytes:"\r\n" length:2];
        [body appendData:[@"unknown@reitshamer.com" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendBytes:"\r\n" length:2];
        [body appendBytes:"\r\n" length:2];
        
        [body appendBytes:"--" length:2];
        [body appendData:[uuid dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendBytes:"--" length:2];
        [body appendBytes:"\r\n" length:2];
    }
    return self;
}
- (void)dealloc {
    [body release];
    [uuid release];
    [super dealloc];
}

- (void)go {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.haystacksoftware.com/support/sendlog.php"]];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data, boundary=%@", uuid] forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", (unsigned long)[body length]] forHTTPHeaderField:@"Content-Length"];
    
    NSInputStream *inputStream = (NSInputStream *)[[HTTPInputStream alloc] initWithData:body];
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBodyStream:inputStream];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    [connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:RUN_LOOP_MODE];
    [connection start];
    
    while (!done) {
        [[NSRunLoop currentRunLoop] runMode:RUN_LOOP_MODE beforeDate:[NSDate distantFuture]];
    }
    [[NSRunLoop currentRunLoop] runMode:RUN_LOOP_MODE beforeDate:[NSDate distantFuture]];
    [request release];
    [inputStream release];
    [connection unscheduleFromRunLoop:[NSRunLoop currentRunLoop] forMode:RUN_LOOP_MODE];
    [connection release];
    NSLog(@"done");
}

#pragma mark NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    done = YES;
}
//- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection {
//    
//}
//- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
//    
//}


#pragma mark NSURLConnectionDataDelegate
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
    return request;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
}
- (NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request {
    return (NSInputStream *)[[[HTTPInputStream alloc] initWithData:body] autorelease];
}
- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
    
}
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    done = YES;
}
@end
