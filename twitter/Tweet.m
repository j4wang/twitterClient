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
    // add the "@" character to the screen name
    NSMutableString *amendedScreenName = [[NSMutableString alloc] initWithString:@"@"];
    
    NSString *tweetScreenName = [self.data valueOrNilForKeyPath:@"user.screen_name"];
    NSLog(@"screen name: %@", tweetScreenName);
   
    [amendedScreenName appendString:tweetScreenName];
    return amendedScreenName;
}

- (NSString *)tweeterName {
    NSString *tweeterUserName = [self.data valueOrNilForKeyPath:@"user.name"];
    NSLog(@"user name: %@", tweeterUserName);
    return tweeterUserName;
}

- (NSString *)timestamp {
    dateFormatter = [[NSDateFormatter alloc] init];
    // current Twitter date format
    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss z yyyy"];
    
    NSString *timestampString =[self.data valueOrNilForKeyPath:@"created_at"];
    NSDate *tweetTimestamp = [dateFormatter dateFromString:timestampString];
    
    // set to current output date format
    [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm"];
    
    return [dateFormatter stringFromDate:tweetTimestamp];
}

- (NSString *)timeAgo {
    // *** set up date formatter ***
    dateFormatter = [[NSDateFormatter alloc] init];
    // current Twitter date format
    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss z yyyy"];
    
    NSString *timestampString =[self.data valueOrNilForKeyPath:@"created_at"];
    NSDate *tweetTimestamp = [dateFormatter dateFromString:timestampString];
    
    // use timeAgo to create Tweet interval string
    return [tweetTimestamp timeAgo];
}

- (NSString *)profilePicURL {
    NSString *picURL = [self.data valueOrNilForKeyPath:@"user.profile_image_url"];
    NSLog(@"pic url: %@", picURL);
    return picURL;
}

- (NSString *)retweetCount {
    return [self.data valueOrNilForKeyPath:@"retweet_count"];
}

- (NSString *)favoritesCount {
    NSString *count = [self.data valueOrNilForKeyPath:@"favourites_count"];
    NSLog(@"Favorites count: %@", count);
    return count;
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

@end
