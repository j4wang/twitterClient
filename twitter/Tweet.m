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

/*
- (NSString *)text {
    return [self.data valueOrNilForKeyPath:@"text"];
}
*/
+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
        Tweet *tweet = [[Tweet alloc] init];
        
        // set up elements of tweet
        tweet.text = [params objectForKey:@"text"];
        
        // calculate timestamp differential
        // *** set up date formatter ***
        dateFormatter = [[NSDateFormatter alloc] init];
        //"created_at": "Tue Aug 28 21:16:23 +0000 2012"
        [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss z yyyy"];
        
        NSString *timestampString =[params objectForKey:@"created_at"];
        NSDate *tweetTimestamp = [dateFormatter dateFromString:timestampString];
        NSDate *currentTimestamp = [dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]];
        
        NSTimeInterval interval = [currentTimestamp timeIntervalSinceDate:tweetTimestamp];
        //int hour = interval / 3600;
        //int minute = (int)interval % 3600 / 60;
        NSLog(@"Timestamp Interval %f", interval);
        tweet.timestamp = [NSString stringWithFormat:@"%f", interval];
        
        // get info from user section
        NSDictionary *userInfo = [params objectForKey:@"user"];
        tweet.screenName = [userInfo objectForKey:@"screen_name"];
        tweet.tweeterName = [userInfo objectForKey:@"name"];
        
        // setup profile picture
        NSString *picURL = [userInfo objectForKey:@"profile_image_url"];
        NSURL *imageURL = [NSURL URLWithString:picURL];
        NSLog(@"Profile Pic URL: %@", picURL);
        tweet.profilePic = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
    }
    return tweets;
}

@end
