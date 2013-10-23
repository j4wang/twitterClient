//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"
#import "NSDate+TimeAgo.h"

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

- (NSString *)timeAgo {
    // *** set up date formatter ***
    dateFormatter = [[NSDateFormatter alloc] init];
    // current Twitter date format
    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss z yyyy"];
    
    NSString *timestampString =[self.data valueOrNilForKeyPath:@"created_at"];
    NSDate *tweetTimestamp = [dateFormatter dateFromString:timestampString];
    
    // use timeAgo to create Tweet interval string
    NSString *timeAgo = [tweetTimestamp timeAgo];
    return timeAgo;
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
