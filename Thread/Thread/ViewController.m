//
//  ViewController.m
//  Thread
//
//  Created by 马鹏 on 2021/7/26.
//

#import "ViewController.h"
#import "Star.h"
@interface ViewController ()

@property (nonatomic, weak) NSObject *obj;
@property (nonatomic, weak) Star *star;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self gcdTest];
}

- (void)gcdTest {

    [self performSelector:@selector(test2)];
    [self performSelector:@selector(test3) withObject:nil afterDelay:0];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"5");
        Star *obj = [Star new];
        self.star = obj;
        NSLog(@"5--%@", self.obj);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"4");
        NSLog(@"4--%@", self.obj);
    });

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"6");
    });
    [self test1];
}

- (void)test1 {
    NSLog(@"1");
}
- (void)test2 {
    NSLog(@"2");
}
- (void)test3 {
    NSLog(@"3");
    NSLog(@"3--%@", self.obj);
}
@end
