//
//  KVViewController.m
//  KomikliVideo
//
//  Created by Ali Can Bülbül on 9/24/13.
//  Copyright (c) 2013 Can Bülbül. All rights reserved.
//

#import "KVViewController.h"
#import <MediaPlayer/MediaPlayer.h>

#define vidBase @"<html><body style=\"margin:0px;\"><iframe webkit-playsinline width=\"320\" height=\"240\" src=\"https://www.youtube.com/embed/%@?feature=player_detailpage&autohide=1&playsinline=1&controls=0&showinfo=0\" frameborder=\"0\"><iframe></body></html>"

//#define vidBase @"<html><body style=\"margin:0px;\"><iframe webkit-playsinline id=\"ytplayer\" type=\"text/html\" width=\"320\" height=\"240\" src=\"https://www.youtube.com/embed/%@?autoplay=1&controls=0&modestbranding=1&rel=0&showinfo=0\" frameborder=\"0\"></body></html>"

@interface KVViewController ()

@end

@implementation KVViewController
@synthesize player;

- (void)viewWillAppear:(BOOL)animated {
    player.allowsInlineMediaPlayback = true;

    [[player scrollView] setBounces:false];
    [self playVideoWithId:@"Zn5CfRrCrIs"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playVideoWithId:(NSString *)videoId {
    NSString *html = [NSString stringWithFormat:vidBase, videoId];
    [player loadHTMLString:html baseURL:[[NSBundle mainBundle] resourceURL]];
}
@end
