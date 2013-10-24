//
//  KVViewController.m
//  KomikliVideo
//
//  Created by Ali Can Bülbül on 9/24/13.
//  Copyright (c) 2013 Can Bülbül. All rights reserved.
//

#import "KVViewController.h"
#import <MediaPlayer/MediaPlayer.h>

#define vidBase @"<html><body style=\"margin:0px;\"><iframe webkit-playsinline id=\"ytplayer\" width=\"320\" height=\"240\" src=\"http://www.youtube.com/embed/%@?feature=player_detailpage&rel=0&iautohide=1&playsinline=1&showinfo=0&autoplay=1&enablejsapi=1\" frameborder=\"0\"></iframe></body></html>"

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
    
    [[player scrollView] setBounces:false];
    [self playVideoWithId:@"Zn5CfRrCrIs"];
    
    likeCounter.text = [NSString stringWithFormat:@"%d",tableData.count];
        

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
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playVideoWithId:(NSString *)videoId {
    NSString *html = [NSString stringWithFormat:vidBase, videoId];
    [player loadHTMLString:html baseURL:nil];
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
}

- (IBAction)share:(id)sender {
}
@end
