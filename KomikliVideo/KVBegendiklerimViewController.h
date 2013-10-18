//
//  KVBegendiklerimViewController.h
//  KomikliVideo
//
//  Created by Taner Yıldırım on 16.10.2013.
//  Copyright (c) 2013 Can Bülbül. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KVBegendiklerimViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTable;

@end
