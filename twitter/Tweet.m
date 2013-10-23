//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

static NSDateFormatter *dateFormatter = nil;

- (NSString *)text {
    NSString *tweetText = [self.data valueOrNilForKeyPath:@"text"];
    NSLog(@"text %@" ,tweetText);
    return tweetText;
}

- (NSString *)screenName {
    NSString *tweetScreenName = [self.data valueOrNilForKeyPath:@"user.screen_name"];
    NSLog(@"screen name: %@", tweetScreenName);
    return tweetScreenName;
}

- (NSString *)tweeterName {
    NSString *tweeterUserName = [self.data valueOrNilForKeyPath:@"user.name"];
    NSLog(@"user name: %@", tweeterUserName);
    return tweeterUserName;
}

- (NSString *)timestamp {
    // calculate timestamp differential
    // *** set up date formatter ***
    dateFormatter = [[NSDateFormatter alloc] init];
    //"created_at": "Tue Aug 28 21:16:23 +0000 2012"
    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss z yyyy"];
    
    NSString *timestampString =[self.data valueOrNilForKeyPath:@"created_at"];
    NSDate *tweetTimestamp = [dateFormatter dateFromString:timestampString];
    NSDate *currentTimestamp = [dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]];
    
    NSTimeInterval interval = [currentTimestamp timeIntervalSinceDate:tweetTimestamp];
    //int hour = interval / 3600;
    //int minute = (int)interval % 3600 / 60;
    NSLog(@"Timestamp Interval %f seconds", interval);
    return [NSString stringWithFormat:@"%f", interval];
}

- (NSString *)profilePicURL {
    NSString *picURL = [self.data valueOrNilForKeyPath:@"user.profile_image_url"];
    NSLog(@"pic url: %@", picURL);
    return picURL;
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

@end
