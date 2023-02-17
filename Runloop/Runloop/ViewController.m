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
#import "MPPerson.h"
@interface ViewController ()

@property (nonatomic, strong) MPThread *thread;
@property (nonatomic, assign) BOOL stop;

@end

typedef void (^mpblock)(void);
@implementation ViewController

typedef void (^MJBlock) (void);

struct __Block_byref_age_0 {
    void *__isa;
    struct __Block_byref_age_0 *__forwarding;
    int __flags;
    int __size;
    int age;
};

struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(void);
    void (*dispose)(void);
};

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    struct __Block_byref_age_0 *age;
};
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
//    [self runloopCallingOut];
//    [self threadAndRunloop];
//    [MPLRSource run];
//    [self gcdTest];
    
//    __block NSObject *a = [[NSObject alloc] init];
    MPPerson *person = [[MPPerson alloc] init];
    person.age = 3;
    NSObject *obj = [NSObject alloc];
    int b =7;
    int *a = &b;
    __block int age = 10;
    mpblock my = ^(void) {
        NSLog(@"11 %d", age);
//        NSLog(@"ddd - %@", a);
    };
//    NSLog(@"11 %@", a);
//    NSLog(@"11 %ll", );
    struct __main_block_impl_0 *blockImp = (__bridge struct __main_block_impl_0 *)my;
    struct __main_block_impl_0 *blockImp12 = (__bridge struct __main_block_impl_0 *)^(void){
        NSLog(@"%d",age);
    };
    NSLog(@"my %@", my);
    my();
    NSLog(@"tmp %@", ^(void){NSLog(@"");});
    NSLog(@"obj %@", obj);

}
#pragma mark -
#pragma mark - 线程保活
- (void)threadAndRunloop {
    //子线程runloop默认不开启
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setBackgroundColor:[UIColor redColor]];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    self.thread = [[MPThread alloc] initWithBlock:^{
        NSLog(@"current thread: %@", [NSThread currentThread]);
//        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            NSLog(@"sub thread timer fired");
//        }];
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        while (!self.stop) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
//        [[NSRunLoop currentRunLoop] run];
        NSLog(@"thread ____ending________");
    }];
    self.thread.name = @"com.warmap.runloop";
    [self.thread start];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self gcdTest];
//    if (self.thread) {
//        [self performSelector:@selector(touchTest) onThread:self.thread withObject:nil waitUntilDone:YES];
//    } else {
//        NSLog(@"thread not exist, stop touch");
//    }
//    int res = [self recurAdd:100];
//    NSLog(@"100 == %d", res);
    [self runloopCallingOut];
}

- (void)btnClick {
    if (self.thread) {
        [self performSelector:@selector(stopThread) onThread:self.thread withObject:nil waitUntilDone:YES];
    } else {
        NSLog(@"thread not exist, stop click");
    }
}

- (void)stopThread {
    self.stop = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"stop_ clicked=-------");
    self.thread = nil;
}

- (void)touchTest {
    NSLog(@"touch  test ----");
}


- (void)gcdTest {
    
//    [self test4];
//    NSLog(@"1");
//    [self performSelector:@selector(test2)];
//    [self performSelector:@selector(test3) withObject:nil afterDelay:0];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"5");
//    });
//    [self test2];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"4");
//    });
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"6");
//    });
//    [self test1];
}


- (void)test1 {
    NSLog(@"1");
}
- (void)test2 {
    NSLog(@"2");
}
- (void)test3 {
    NSLog(@"3");
}

- (void)test4 {
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"====1=====");
    }];
    [thread start];
    NSLog(@"-------2--------");
//    *** Terminating app due to uncaught exception 'NSDestinationInvalidException', reason: '*** -[ViewController performSelector:onThread:withObject:waitUntilDone:modes:]: target thread exited while waiting for the perform'
    [self performSelector:@selector(test2) onThread:thread withObject:nil waitUntilDone:YES];
}

//- (void)loadView {
//    self.view = [self scrollView];
//    self.view.backgroundColor = UIColor.whiteColor;
//}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
////    [self runloopCallingOut];
//
//}


- (void)runloopCallingOut {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    long wait = dispatch_semaphore_wait(sema, 3*NSEC_PER_MSEC);
    //__CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"dispatch_get_main_queue");
    });
    UIButton *btn;
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

