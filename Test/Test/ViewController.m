//
//  ViewController.m
//  Test
//
//  Created by 马鹏 on 2021/8/11.
//

#import "ViewController.h"
#import <MPUIKit/MPUIKit.h>
#import <Car.h>

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
    //全局符号，且是导出符号，上面有声明，所以这里就可以调用
//    sayHi();
//
//    Star *star = [Star new];
//    //symbol项目的other link flags要添加-ObjC参数，不然会找不到方法而crash
//    [star makeSound];
//    CherryCar *cherry = [CherryCar new];
//    NSLog(@"car :%@", cherry);
    // Do any additional setup after loading the view.
    [self crashedMethod];
}

- (void)crashedMethod {
    NSArray *arr = [NSArray array];
    arr[1];
}


@end
