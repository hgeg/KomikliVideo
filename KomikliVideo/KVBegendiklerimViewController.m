//
//  KVBegendiklerimViewController.m
//  KomikliVideo
//
//  Created by Taner Yıldırım on 16.10.2013.
//  Copyright (c) 2013 Can Bülbül. All rights reserved.
//

#import "KVBegendiklerimViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface KVBegendiklerimViewController ()

@end

@implementation KVBegendiklerimViewController
@synthesize myTable;



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
	// Do any additional setup after loading the view.
    UIFont *Dosisbook = [UIFont fontWithName:@"Dosis-Book" size:25.0f];
    /*
    UIFont *Dosisbold = [UIFont fontWithName:@"Dosis-Bold" size:17.0f];
    UIFont *Dosisextrabold = [UIFont fontWithName:@"Dosis-ExtraBold" size:17.0f];
    UIFont *Dosisextralight = [UIFont fontWithName:@"Dosis-ExtraLight" size:17.0f];
    UIFont *Dosislight = [UIFont fontWithName:@"Dosis-Light" size:25.0f];
    UIFont *Dosismedium = [UIFont fontWithName:@"Dosis-Medium" size:17.0f];
    UIFont *Dosissemibold = [UIFont fontWithName:@"Dosis-SemiBold" size:17.0f];
    */
    
    
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    return [[standardUserDefaults objectForKey:@"tableData"] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    UIFont *Dosismedium = [UIFont fontWithName:@"Dosis-Medium" size:17.0f];
    
    static NSString *simpleTableIdentifier = @"videolar";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    ((UILabel *)[cell viewWithTag:1]).text = [[standardUserDefaults objectForKey:@"tableData"] objectAtIndex:indexPath.row];
    
    [((UILabel *)[cell viewWithTag:1]) setFont:Dosismedium];
    

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"%d", indexPath.row);
        
        //add code here for when you hit delete
        NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray * tableData = [NSMutableArray arrayWithArray:[standardUserDefaults objectForKey:@"tableData"] ];
        //tableData = [standardUserDefaults objectForKey:@"tableData"];
        NSLog(@"%@", tableData);
        [tableData removeObjectAtIndex:indexPath.row];
        
        [standardUserDefaults setObject:tableData forKey:@"tableData"];
        [standardUserDefaults synchronize];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"unlike" object:Nil];
        //NSLog(@"%d", [[standardUserDefaults objectForKey:@"tableData"] count]);
        
        
        
    }
}




@end
