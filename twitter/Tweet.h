//
//  Tweet.h
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : RestObject

//@property (nonatomic, strong, readonly) NSString *text;

@property (strong, nonatomic) NSString *profilePicURL;
@property (strong, nonatomic) NSString *tweeterName;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *timestamp;
@property (strong, nonatomic) NSString *timeAgo;
@property (strong, nonatomic) NSString *tweetID;
@property (nonatomic, strong, readonly) NSString *retweetCount;
@property (nonatomic, strong, readonly) NSString *favoritesCount;

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array;

@end
