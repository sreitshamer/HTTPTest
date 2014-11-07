//
//  HTTPInputStream.h
//
//  Created by Stefan Reitshamer on 3/16/12.
//  Copyright 2012 Haystack Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HTTPInputStream : NSObject {
    NSData *data;
    NSInputStream *inputStream;
}
- (id)initWithData:(NSData *)theData;
@end
