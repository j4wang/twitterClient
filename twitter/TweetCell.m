//
//  TweetCell.m
//  twitter
//
//  Created by Timothy Lee on 8/6/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetCell.h"

@interface TweetCell ()

@end

@implementation TweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
-(void)setTweet:(Tweet *)tweet
{
    self.textLabel.text = tweet.text;
    self.profileImage.image = tweet.profilePic;
    self.screenNameLabel.text = tweet.screenName;
    self.tweeterNameLabel.text = tweet.tweeterName;
    self.timestampLabel.text = tweet.timestamp;
}
*/
@end
