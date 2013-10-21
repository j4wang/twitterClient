//
//  TweetCell.m
//  twitter
//
//  Created by Timothy Lee on 8/6/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetCell.h"

@interface TweetCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *tweeterName;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

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

-(void)setTweet:(Tweet *)tweet
{
    self.text.text = tweet.text;
    self.profileImage.image = tweet.profilePic;
    self.screenName.text = tweet.screenName;
    self.tweeterName.text = tweet.tweeterName;
    // NOTE: TO DO: Add code to calculate the time differential
    self.timestampLabel.text = tweet.timestamp;
}

@end
