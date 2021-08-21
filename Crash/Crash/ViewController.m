//
//  ViewController.m
//  Crash
//
//  Created by 马鹏 on 2021/8/20.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self crash];
//    });
}

- (void)crash {
        NSArray *arr = [NSArray array];
        arr[1];
}
@end
