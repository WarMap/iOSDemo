//
//  ViewController.m
//  DSYM
//
//  Created by 马鹏 on 2021/8/21.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self crash];
}

- (void)crash {
    [NSArray array][1];
}
@end
