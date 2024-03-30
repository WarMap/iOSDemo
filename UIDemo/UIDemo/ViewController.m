//
//  ViewController.m
//  UIDemo
//
//  Created by fengjiu on 2023/5/16.
//

#import "ViewController.h"
#import "MyScrollDelegate.h"
#include "dobby.h"
#include <objc/runtime.h>
#include <mach/mach_time.h>
#include <objc/message.h>

#include <objc/runtime.h>
#include <objc/message.h>
#include <mach/mach_time.h>
#include "dobby.h"
#import "DemoViewController.h"


static void (*orig_objc_msgSend)(id, SEL, ...);

// 此函数将被用来替换原始的 objc_msgSend
static void my_objc_msgSend(id self, SEL _cmd, ...) {

}

__attribute__((constructor))
void initialize_and_hook(void) {
    // 在运行时初始化时，Hook objc_msgSend
//    if (DobbyHook((void *)objc_msgSend, (void *)my_objc_msgSend, (void **)&orig_objc_msgSend) == 1) {
//        // Hook 成功
//        NSLog(@"hook success");
//    } else {
//        // Hook 失败，需要处理错误
//        NSLog(@"hook fail");
//
//    }
}


@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) MyScrollDelegate *scrollDelegate;
@end

@implementation ViewController

+(void)load
{
//    initialize_hook();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
//    self.scrollDelegate = [[MyScrollDelegate alloc] init];
//    [self setupScrollView];
//    DobbyHook(test_sum, new_sum, NULL);

    
}


- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"1 %@", NSStringFromSelector(_cmd));
}
- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"1 %@", NSStringFromSelector(_cmd));
}
- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"1 %@", NSStringFromSelector(_cmd));
}
- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"1 %@", NSStringFromSelector(_cmd));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    DemoViewController *vc = [[DemoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#define pageCount 20

- (void)setupScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self.scrollDelegate;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.scrollView.bounds.size.height * pageCount);
    for (NSInteger i = 0; i < pageCount; ++i) {
        UIView *view = [self.class randomColorViewWithFrame:self.scrollView.bounds];
        view.top = i*self.scrollView.bounds.size.height;
        [self.scrollView addSubview:view];
    }
}


+ (UIView *)randomColorViewWithFrame:(CGRect)frame 
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    // 生成随机颜色
    CGFloat red = arc4random_uniform(256) / 255.0;
    CGFloat green = arc4random_uniform(256) / 255.0;
    CGFloat blue = arc4random_uniform(256) / 255.0;
    
    view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    return view;
}



@end
