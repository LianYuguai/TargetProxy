//
//  ViewController.m
//  TargetProxy
//
//  Created by yulong on 16/9/12.
//  Copyright © 2016年 com.YL. All rights reserved.
//

#import "ViewController.h"
#import "TargetProxy.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableString *string = [[NSMutableString alloc] init];
    
    // Create an empty mutable array, which will be the other
    // real object for the proxy.
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    // Create a proxy to wrap the real objects.  This is rather
    // artificial for the purposes of this example -- you'd rarely
    // have a single proxy covering two objects.  But it is possible.
    id proxy = [[TargetProxy alloc] initWithTarget1:string target2:array];
    
    // Note that we can't use appendFormat:, because vararg methods
    // cannot be forwarded!
    [proxy appendString:@"This "];
    [proxy appendString:@"is "];
    [proxy addObject:string];
    [proxy appendString:@"a "];
    [proxy appendString:@"test!"];
    
    NSLog(@"count should be 1, it is: %d", [proxy count]);
    
    if ([[proxy objectAtIndex:0] isEqualToString:@"This is a test!"]) {
        NSLog(@"Appending successful.", proxy);
    } else {
        NSLog(@"Appending failed, got: '%@'", proxy);
    }
    
    NSLog(@"Example finished without errors.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
