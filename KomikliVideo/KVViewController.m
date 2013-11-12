//
//  KVViewController.m
//  KomikliVideo
//
//  Created by Ali Can Bülbül on 9/24/13.
//  Copyright (c) 2013 Can Bülbül. All rights reserved.
//

#import "KVViewController.h"
#import <MediaPlayer/MediaPlayer.h>

#define vidBase @"<html><head><script type=\"text/javascript\">function onYoutubePlayerReady(playerId) {ytplayer = document.getElementById(\"ytplayer\");ytplayer.playVideo();}</script></head><body style=\"margin:0px;background-color:#000;\"><iframe webkit-playsinline autoplay=\"autoplay\" id=\"ytplayer\" width=\"320px\" height=\"240px\" onload=\"onYoutubePlayerReady(1)\" src=\"http://www.youtube.com/embed/%@?feature=player_detailpage&rel=0&iautohide=1&playsinline=1&showinfo=0&autoplay=1&enablejsapi=1&playerapiid=ytplayer\" frameborder=\"0\"></iframe></body></html>"


#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface KVViewController ()

@end

@implementation KVViewController
@synthesize player;
@synthesize topView;
@synthesize bottomView;
@synthesize likeButton;
@synthesize videoName;
@synthesize header;
@synthesize rastgeleLabel;
@synthesize begendiklerimLabel;
@synthesize shuffleButton;
@synthesize likesButton;
@synthesize likeCounter;
NSMutableArray *tableData;
int likecount=0;



- (void)viewWillAppear:(BOOL)animated {
    player.allowsInlineMediaPlayback = true;
    
    player.backgroundColor = [UIColor blackColor];
    [[player scrollView] setBounces:false];
    [[player scrollView] setScrollEnabled:false];
    [self playVideoWithId:@"Zn5CfRrCrIs"];
    
    //likeCounter.text = [NSString stringWithFormat:@"%lu",(unsigned long)tableData.count];
        

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    tableData = [[NSMutableArray alloc] init];
    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([standardUserDefaults objectForKey:@"tableData"] != nil) {
        tableData = [standardUserDefaults objectForKey:@"tableData"];
        likeCounter.text = [NSString stringWithFormat:@"%d",tableData.count];
        
        
    } else {
        [standardUserDefaults setObject:tableData forKey:@"tableData"];
        likeCounter.text = [NSString stringWithFormat:@"%d",0];
    }
    
    //[standardUserDefaults setInteger:likecount forKey:@"likeCount"];
    
    //UIFont *Dosisbold = [UIFont fontWithName:@"Dosis-Bold" size:17.0f];
    UIFont *Dosisbook = [UIFont fontWithName:@"Dosis-Book" size:25.0f];
    //UIFont *Dosisextrabold = [UIFont fontWithName:@"Dosis-ExtraBold" size:17.0f];
    //UIFont *Dosisextralight = [UIFont fontWithName:@"Dosis-ExtraLight" size:17.0f];
    //UIFont *Dosislight = [UIFont fontWithName:@"Dosis-Light" size:25.0f];
    UIFont *Dosismedium = [UIFont fontWithName:@"Dosis-Medium" size:17.0f];
    //UIFont *Dosissemibold = [UIFont fontWithName:@"Dosis-SemiBold" size:17.0f];
    
    topView.backgroundColor = UIColorFromRGB(0xffb400);
    bottomView.backgroundColor = UIColorFromRGB(0xffb400);
    
    [videoName setFont:Dosismedium];
    
    [header setFont: Dosisbook];
    [header setTextColor:UIColorFromRGB(0xb4b4b5)];
    
    [rastgeleLabel setFont:Dosismedium];
    [rastgeleLabel setTextColor:UIColorFromRGB(0x4f4d52)];
    
    [begendiklerimLabel setFont:Dosismedium];
    [begendiklerimLabel setTextColor:UIColorFromRGB(0xb4b4b5)];
    
    [likeCounter setFont:Dosisbook];
    //likeCounter.text = [standardUserDefaults objectForKey:@"likeCount"];
    [likeCounter setTextColor:UIColorFromRGB(0xb4b4b5)];
    
    //shuffleButton.backgroundColor = UIColorFromRGB(0x4f4d52);
    
    UILabel *customTitle = [[UILabel alloc] init];
    [customTitle setFrame:CGRectMake(0,5,50,20)];
    customTitle.text = @"Komik TV";
    [customTitle setFont: Dosisbook];
    [customTitle setTextColor:UIColorFromRGB(0xb4b4b5)];
    
    self.navigationItem.titleView = customTitle;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLikeCounter) name:@"unlike" object:Nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playVideoWithId:(NSString *)videoId {
    [player scrollView].frame = CGRectMake(0, -64, 320, 320);
    NSString *html = [NSString stringWithFormat:vidBase, videoId];
    [player loadHTMLString:html baseURL:[NSURL URLWithString:@"http://youtube.com"]];
}

-(void)setLikeCounter{
    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * tableData2 = [NSMutableArray arrayWithArray:[standardUserDefaults objectForKey:@"tableData"] ];
    
    likeCounter.text = [NSString stringWithFormat:@"%d",tableData2.count];
}

- (IBAction)likeVideo:(id)sender {
    if([likeButton.restorationIdentifier isEqualToString:@"1"])
    {
        UIImage *image = [UIImage imageNamed:@"heart_dark.png"];
        [sender setImage:image forState:UIControlStateNormal];
        likeCounter.text = [NSString stringWithFormat:@"%d",[likeCounter.text intValue]+1];
        likeButton.restorationIdentifier = @"0";
        
        [tableData addObject:videoName.text];
        NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
        [standardUserDefaults setObject:tableData forKey:@"tableData"];
    }
    else
    {
        UIImage *image = [UIImage imageNamed:@"heart_large.png"];
        [sender setImage:image forState:UIControlStateNormal];
        likeCounter.text = [NSString stringWithFormat:@"%d",[likeCounter.text intValue]-1];
        likeButton.restorationIdentifier = @"1";
        
        [tableData removeObject:videoName.text];
        NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
        [standardUserDefaults setObject:tableData forKey:@"tableData"];
    }
    
    
}

- (IBAction)nextVideo:(id)sender {
    NSData *data = [[NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://hgeg.io/komiktv/next/5"] encoding:NSUTF8StringEncoding error: nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSArray *next = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
    //NSLog(@"data: %@",next);
    videoName.text = next[0][@"title"];dfjkdfdkdfskkdfs
    [self playVideoWithId:next[0][@"id"]];

}

- (IBAction)share:(id)sender {
}
@end
