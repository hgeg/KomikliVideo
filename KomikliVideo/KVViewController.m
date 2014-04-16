//
//  KVViewController.m
//  KomikliVideo
//
//  Created by Ali Can Bülbül on 9/24/13.
//  Copyright (c) 2013 Can Bülbül. All rights reserved.
//

#import "KVViewController.h"
#import "XCDYouTubeVideoPlayerViewController.h"
#import "GADInterstitial.h"

#define vidBase @"<html><body style=\"margin:0;padding:0;background-color:#000;\"><iframe webkit-playsinline autoplay=\"autoplay\" id=\"ytplayer\" width=\"%dpx\" height=\"%dpx\" src=\"http://www.youtube.com/embed/%@?feature=player_detailpage&rel=0&iautohide=1&playsinline=1&showinfo=0&autoplay=1&enablejsapi=1&playerapiid=ytplayer\" frameborder=\"0\"></iframe></body></html>"


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

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)viewWillAppear:(BOOL)animated {
    /*player.allowsInlineMediaPlayback = true;
    
    player.backgroundColor = [UIColor blackColor];
    [[player scrollView] setBounces:false];
    [[player scrollView] setScrollEnabled:false];

    //[self playVideoWithId:@"Zn5CfRrCrIs"];
    [self nextVideo:self];
    */
    
    //likeCounter.text = [NSString stringWithFormat:@"%lu",(unsigned long)tableData.count];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    indexOfNext = -1;
    counter = 0;
	// Do any additional setup after loading the view, typically from a nib.
    NSData *data = [[NSString stringWithContentsOfURL:[NSURL URLWithString:f(@"http://hgeg.io/komiktv/next/%@/20/",uid)] encoding:NSUTF8StringEncoding error: nil] dataUsingEncoding:NSUTF8StringEncoding];
    videos = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@",videos);
    
    tableData = [[NSMutableArray alloc] init];
    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([standardUserDefaults objectForKey:@"tableData"] != nil) {
        tableData = [standardUserDefaults objectForKey:@"tableData"];
        likeCounter.text = [NSString stringWithFormat:@"%lu",(unsigned long)[tableData count]];
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
    customTitle.text = @"Fenomen Videolar";
    [customTitle setFont: Dosisbook];
    [customTitle setTextColor:UIColorFromRGB(0xb4b4b5)];
    
    
    player.allowsInlineMediaPlayback = true;
    player.backgroundColor = [UIColor blackColor];
    [[player scrollView] setContentInset:UIEdgeInsetsMake(-65, 0, 0, 0)];
    [[player scrollView] setBounces:false];
    [[player scrollView] setScrollEnabled:false];
    [self nextVideo:self];
    
    self.navigationItem.titleView = customTitle;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLikeCounter) name:@"unlike" object:Nil];
    
    NC_addObserver(@"playVideo", @selector(playVideoWithObject:));
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playVideoWithId:(NSString *)videoId {
    [NSString stringWithContentsOfURL:[NSURL URLWithString:f(@"http://hgeg.io/komiktv/watched/%@/%@/",uid,videoId)] encoding:NSUTF8StringEncoding error: nil];
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:videoId];
    [videoPlayerViewController presentInView:self.videoContainerView];
    [videoPlayerViewController.moviePlayer prepareToPlay];
}

- (void)playVideoWithObject:(NSNotification *)object {
    NSDictionary *video = object.object;
    
    videoName.text = video[@"title"];
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * tableData2 = [NSMutableArray arrayWithArray:[standardUserDefaults objectForKey:@"tableData"] ];
    
    if([tableData2 containsObject: video])
    {
        NSLog(@"bulundu");
        UIImage *image = [UIImage imageNamed:@"heart_red.png"];
        [likeButton setImage:image forState:UIControlStateNormal];
        likeButton.restorationIdentifier = @"0";
    }
    else
    {
        NSLog(@"bulunmadı");
        UIImage *image = [UIImage imageNamed:@"heart_large.png"];
        [likeButton setImage:image forState:UIControlStateNormal];
        
        likeButton.restorationIdentifier = @"1";
    }
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:video[@"id"]];
    [videoPlayerViewController presentInView:self.videoContainerView];
    [videoPlayerViewController.moviePlayer prepareToPlay];
}

-(void)setLikeCounter{
    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * tableData2 = [NSMutableArray arrayWithArray:[standardUserDefaults objectForKey:@"tableData"] ];
    
    likeCounter.text = [NSString stringWithFormat:@"%lu",(unsigned long)tableData2.count];
    
    if([tableData2 containsObject: next])
    {
        NSLog(@"bulundu");
        UIImage *image = [UIImage imageNamed:@"heart_red.png"];
        [likeButton setImage:image forState:UIControlStateNormal];
        likeButton.restorationIdentifier = @"0";
    }
    else
    {
        NSLog(@"bulunmadı");
        UIImage *image = [UIImage imageNamed:@"heart_large.png"];
        [likeButton setImage:image forState:UIControlStateNormal];
        
        likeButton.restorationIdentifier = @"1";
    }
    
}

- (IBAction)likeVideo:(id)sender {
    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * tableData2 = [NSMutableArray arrayWithArray:[standardUserDefaults objectForKey:@"tableData"] ];

    
    if([likeButton.restorationIdentifier isEqualToString:@"1"])
    {
        UIImage *image = [UIImage imageNamed:@"heart_red.png"];
        [sender setImage:image forState:UIControlStateNormal];
        likeCounter.text = [NSString stringWithFormat:@"%d",[likeCounter.text intValue]+1];
        likeButton.restorationIdentifier = @"0";
        
        [tableData2 addObject:next];
        NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
        [standardUserDefaults setObject:tableData2 forKey:@"tableData"];
    }
    else
    {
        UIImage *image = [UIImage imageNamed:@"heart_large.png"];
        [sender setImage:image forState:UIControlStateNormal];
        likeCounter.text = [NSString stringWithFormat:@"%d",[likeCounter.text intValue]-1];
        likeButton.restorationIdentifier = @"1";
        
        [tableData2 removeObject:next];
        NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
        [standardUserDefaults setObject:tableData2 forKey:@"tableData"];
    }
    

}

- (IBAction)nextVideo:(id)sender {
    indexOfNext++;
    if (indexOfNext >= [videos count]) {
        NSData *data = [[NSString stringWithContentsOfURL:[NSURL URLWithString:f(@"http://hgeg.io/komiktv/next/%@/20/",uid)] encoding:NSUTF8StringEncoding error: nil] dataUsingEncoding:NSUTF8StringEncoding];
        videos = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        indexOfNext = 0;
    }
    next = videos[indexOfNext];
    NSLog(@"next: %@",next[@"id"]);
    videoName.text = next[@"title"];
    [self playVideoWithId:next[@"id"]];
    
    //setLikeButton
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * tableData2 = [NSMutableArray arrayWithArray:[standardUserDefaults objectForKey:@"tableData"] ];
   
    if([tableData2 containsObject: next])
    {
        NSLog(@"bulundu");
        UIImage *image = [UIImage imageNamed:@"heart_red.png"];
        [likeButton setImage:image forState:UIControlStateNormal];
        likeButton.restorationIdentifier = @"0";
    }
    else
    {
        NSLog(@"bulunmadı");
        UIImage *image = [UIImage imageNamed:@"heart_large.png"];
        [likeButton setImage:image forState:UIControlStateNormal];
        
        likeButton.restorationIdentifier = @"1";
    }
    counter++;
    if (counter%10==0) {
        GADRequest *request = [GADRequest request];
        request.testDevices = @[ GAD_SIMULATOR_ID ];
        request.testing = true;
        interstitial_ = [[GADInterstitial alloc] init];
        interstitial_.adUnitID = @"a15347d61bbc99b";
        interstitial_.delegate = self;
        [interstitial_ loadRequest:request];
    }
    
}

-(IBAction)share:(id)sender{
    
    NSArray* dataToShare = @[f(@"%@ http://youtu.be/%@ #FenomenVideolar http://orkestra.co/FV", next[@"title"], next[@"id"]),@""];
    
    activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
    
    [activityViewController setExcludedActivityTypes:@[UIActivityTypePrint,UIActivityTypePostToWeibo,UIActivityTypeMessage,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,UIActivityTypeMail,UIActivityTypeAirDrop,UIActivityTypeAddToReadingList]];
    [activityViewController setTitle:@"Videoyu paylaş"];
    
    [self presentViewController:activityViewController animated:YES completion:^{}];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Conn error: %@",error);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"retval: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    [interstitial_ presentFromRootViewController:self];
}

@end