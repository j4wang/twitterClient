//
//  TimelineVC.m
//  twitter
//
//  Created by Timothy Lee on 8/4/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TimelineVC.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeTweetViewController.h"
#import "SingleTweetViewController.h"

@interface TimelineVC ()

#define PADDING 5.0f

@property (nonatomic, strong) NSMutableArray *tweets;

- (void)onSignOutButton;
- (void)reload;

@end

@implementation TimelineVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Twitter";
        
        [self reload];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOutButton)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStylePlain target:self action:@selector(onComposeButton)];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // register the custom cell
    UINib *customNib = [UINib nibWithNibName:@"TweetCell" bundle:nil];
    [self.tableView registerNib: customNib forCellReuseIdentifier:@"TweetCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //TweetCell *cell = [[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    Tweet *tweet = self.tweets[indexPath.row];
    cell.textLabel.text = tweet.text;
    cell.screenNameLabel.text = tweet.screenName;
    cell.tweeterNameLabel.text = tweet.tweeterName;
    cell.timestampLabel.text = tweet.timeAgo;
    
    //NSString *imageURL = ;
    //[cell.profileImage setURL:imageURL];
    NSURL *imageURL = [NSURL URLWithString:tweet.profilePicURL];
    if (imageURL) {
        [cell.profileImage setImageWithURL:imageURL];
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //TweetCell *cell = (TweetCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    Tweet *currentTweet = self.tweets[indexPath.row];
    if(currentTweet){
        NSLog(@"self.tweet is not null!");
    }
    else {
        NSLog(@"self.tweet is null!");
    }

    SingleTweetViewController *svc = [[SingleTweetViewController alloc] initWithTweet:currentTweet];
    [self.navigationController pushViewController:svc animated:YES];
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // call sizeWithFont to get height
    
    // size of other elements
    float heightOfConstraints = 10; // 5 (constraint) x 2 (top & bottom)
    //float heightOfTopRow = [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
    //int heightOfTwitterText = [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}];

    // current Tweet
    Tweet *currentTweet = [self.tweets objectAtIndex:indexPath.row];
    
    // calculate height of top row (name, etc.)
    NSString *tweeterName = currentTweet.tweeterName;
    //NSLog(@"indexPath.row: %f", indexPath.row);
    //NSString *tweeterName = @"Joe Blow";
    CGSize heightOfTopRow = [tweeterName sizeWithFont:[UIFont systemFontOfSize:12.0f] forWidth:50.0 lineBreakMode:NSLineBreakByWordWrapping];
    NSLog(@"heightOfTopRow %f",heightOfTopRow.height);
    
    NSString *tweetContent = currentTweet.text;
    //NSString *tweetContent = @"This is 140 characters of prime foolishness!! Why don't you visit http://codepath.com to learn iOS programming";
    CGSize heightOfTweetText = [tweetContent sizeWithFont:[UIFont systemFontOfSize:14.0f] forWidth:150.0 lineBreakMode:NSLineBreakByWordWrapping];
    NSLog(@"heightOfTweetText %f",heightOfTweetText.height);
    
    // using height of UIImageView as minimum tweet cell height = 48 + padding of 5 on both top & bottom
    float totalCellHeight = 100.0;
    
    // replace totalCellHeight if calculated cell height is greater
    if ((2*heightOfTweetText.height + 2*heightOfTopRow.height + (PADDING * 3)) > totalCellHeight)
    {
        totalCellHeight = 2*heightOfTweetText.height + 2*heightOfTopRow.height + (PADDING * 3);
    }
    NSLog(@"totalCellHeight %f",totalCellHeight);
    return totalCellHeight;
}

#pragma mark - Private methods

- (void)onSignOutButton {
    [User setCurrentUser:nil];
}

- (void)onComposeButton {
    ComposeTweetViewController *tweetComposeVC = [[ComposeTweetViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tweetComposeVC];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)reload {
    [[TwitterClient instance] homeTimelineWithCount:20 sinceId:0 maxId:0 success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        self.tweets = [Tweet tweetsWithArray:response];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Do nothing
    }];
}

@end
