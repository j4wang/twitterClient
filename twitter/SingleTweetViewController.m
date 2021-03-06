//
//  SingleTweetViewController.m
//  twitter
//
//  Created by John on 10/23/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "SingleTweetViewController.h"
#import "ComposeTweetViewController.h"
#import "UIImageView+AFNetworking.h"

@interface SingleTweetViewController ()

@end

@implementation SingleTweetViewController

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/
- (id)initWithTweet:(Tweet *)tweet {
    self = [super initWithNibName:@"SingleTweetViewController" bundle:nil];
    if (self) {
        self.tweet = tweet;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"enter single tweet view");
    // load tweet info
    self.tweeterName.text = self.tweet.tweeterName;
    self.screenName.text = self.tweet.screenName;
    
    // set up async picture loading
    NSURL *imageURL = [NSURL URLWithString:self.tweet.profilePicURL];
    if (imageURL) {
        [self.profilePic setImageWithURL:imageURL];
    }
    self.text.text = self.tweet.text;
    self.timestamp.text = self.tweet.timestamp;

    NSLog(@"favorite count: %@", self.tweet.favoritesCount);
    self.favoriteCount.text = self.tweet.favoritesCount;
    
    NSLog(@"retweetCount %@", self.tweet.retweetCount);
    self.retweetCount.text = self.tweet.retweetCount;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onReply:(id)sender
{
    NSLog(@"Reply to tweet");
    ComposeTweetViewController *composeTweetVC = [[ComposeTweetViewController alloc] init];
    // pass id & name for replies
    composeTweetVC.responseTweetID = self.tweet.tweetID;
    composeTweetVC.responseTweenScreenName = self.tweet.screenName;
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:composeTweetVC];
    [self presentViewController:nc animated:YES completion:nil];
}

- (IBAction)onRetweet:(id)sender
{
    NSLog(@"Retweeted Tweet ID: %@",self.tweet.tweetID);
    [[TwitterClient instance] retweet:self.tweet.tweetID success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"Retweeted!");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (IBAction)onFavorite:(id)sender
{
    NSLog(@"Favorited Tweet ID: %@",self.tweet.tweetID);
    [[TwitterClient instance] favorite:self.tweet.tweetID success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"Tweet Favorited!");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}
@end
