//
//  KVViewController.h
//  KomikliVideo
//
//  Created by Ali Can Bülbül on 9/24/13.
//  Copyright (c) 2013 Can Bülbül. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>

#import "GADInterstitial.h"

@interface KVViewController : UIViewController <NSURLConnectionDelegate, GADInterstitialDelegate>
{
    NSArray *videos;
    int indexOfNext;
    NSDictionary *next;
    NSMutableArray *tableData;
    UIActivityViewController *activityViewController;
    GADInterstitial *interstitial_;
    int counter;
}
@property (weak, nonatomic) IBOutlet UIWebView *player;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *videoName;
@property (weak, nonatomic) IBOutlet UIView *videoContainerView;
@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UIButton *shuffleButton;
@property (weak, nonatomic) IBOutlet UIButton *likesButton;
@property (weak, nonatomic) IBOutlet UILabel *rastgeleLabel;
@property (weak, nonatomic) IBOutlet UILabel *begendiklerimLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCounter;

- (IBAction)likeVideo:(id)sender;
- (IBAction)nextVideo:(id)sender;
- (IBAction)share:(id)sender;
@end