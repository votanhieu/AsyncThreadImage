//
//  ViewController.m
//  BGDownloadingDemo
//
//  Created by Shinkangsan on 11/28/16.
//  Copyright © 2016 Sheldon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *downloadIndicator;

@end

@implementation ViewController
NSString * urlString;
NSURL * url;

- (void)viewDidLoad {
    [super viewDidLoad];
    urlString = @"https://images.unsplash.com/photo-1462822257719-8e456a6b23ef?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=913&q=80";
    url = [[NSURL alloc]initWithString:urlString];
    [_downloadIndicator startAnimating];
    [_downloadIndicator setHidden:true];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downloadTapped:(id)sender {
    //self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    [_downloadIndicator setHidden:false];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && data != nil)  {
            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.imageView.image = [UIImage imageWithData:data];
//            });
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [_downloadIndicator setHidden:true];
                self.imageView.image = [UIImage imageWithData:data];
            }];
            
        };
    }] resume];
}

@end
