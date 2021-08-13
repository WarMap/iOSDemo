//
//  ViewController.m
//  Test
//
//  Created by 马鹏 on 2021/8/11.
//

#import "ViewController.h"
//#import <MPUIKit/MPUIKit.h>
@interface ViewController ()

@end

@implementation ViewController
void sayHi(void);
- (void)viewDidLoad {
    [super viewDidLoad];
    sayHi();
    // Do any additional setup after loading the view.
}

void sayHi(void) {
    NSLog(@"vc hi");
}


@end
