//
//  ViewController.m
//  Test
//
//  Created by 马鹏 on 2021/8/11.
//

#import "ViewController.h"
#import <MPUIKit/MPUIKit.h>

@interface ViewController ()

@end



int global_uninit_value;
int global_init_value = 10;
int global_init_value;
double default_x __attribute__((visibility("hidden"))) ;
static int static_init_value = 9;
static int static_uninit_value;

@implementation ViewController
void sayHi(void);
- (void)viewDidLoad {
    [super viewDidLoad];
    sayHi();
    Star *star = [Star new];
    //symbol项目的other link flags要添加-ObjC参数，不然会找不到方法而crash
    [star makeSound];
    // Do any additional setup after loading the view.
}




@end
