//
//  TweetComposeViewController.m
//  twitter
//
//  Created by John on 10/22/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "ComposeTweetViewController.h"
#import "TwitterClient.h"

@interface ComposeTweetViewController ()

@property (weak, nonatomic) IBOutlet UITextField *twitterContentField;

@end

@implementation ComposeTweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweetButton)];
    
    // add screenName of author for the reply
    if (self.responseTweetID != nil) {
        // add a space behind the screenName
        NSMutableString *screenNameWithSpace = [[NSMutableString alloc] initWithString:self.responseTweenScreenName];
        [screenNameWithSpace appendString:@" "];
        self.twitterContentField.text = screenNameWithSpace;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onTweetButton {
    [[TwitterClient instance] tweet:self.twitterContentField.text inReplyToTweetID:self.responseTweetID
                    success:^(AFHTTPRequestOperation *operation, id response) {
                       NSLog(@"Tweet sent!");
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"%@", error);
                   }];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
