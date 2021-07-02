//
//  ViewController.m
//  Runloop
//
//  Created by mapeng on 2021/5/29.
//

#import "ViewController.h"
#import "MPThread.h"
#import "MPLRSource.h"
#import "MPRunloopObserver.h"

@interface ViewController ()

@property (nonatomic, strong) MPRunloopObserver *runloopOB;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.runloopOB = [MPRunloopObserver beginObserver];
//    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
//    [self runloopCallingOut];
//    [self threadAndRunloop];
    [MPLRSource run];
}


- (void)loadView {
    self.view = [self scrollView];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self runloopCallingOut];
    
}

- (void)threadAndRunloop {
    //子线程runloop默认不开启
    MPThread *thread = [[MPThread alloc] initWithBlock:^{
        NSLog(@"current thread: %@", [NSThread currentThread]);
        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"sub thread timer fired");
        }];        
        [[NSRunLoop currentRunLoop] run];
    }];
    thread.name = @"com.warmap.runloop";
    [thread start];
}

- (void)runloopCallingOut {
    //__CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"dispatch_get_main_queue");
    });
    //__CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION__
    [self performSelector:@selector(fire) withObject:nil afterDelay:1.0];
    //__CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION__
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"time's up");
    }];
    void(^block)(void) = ^{
        NSLog(@"this is a block");
    };
    block();
}

- (void)fire {
    NSLog(@"fire!!!");
}

- (UIScrollView *)scrollView {
    UIScrollView *result = [[UIScrollView alloc] init];
    result.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    result.contentSize = CGSizeMake(result.bounds.size.width, 2*result.bounds.size.height);
    
    CGFloat sec = result.contentSize.height / 8;
    NSArray *colors = @[UIColor.redColor, UIColor.yellowColor, UIColor.blueColor];
    for (int i = 0; i<8; ++i) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, i*sec, result.contentSize.width, sec);
        NSUInteger se = random() % 3;
        view.backgroundColor = colors[se];
        [result addSubview:view];
    }
    return result;
}
@end

