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
#import "MyView.h"
#import "MyViewController.h"

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


@interface ViewController ()<UIScrollViewDelegate, UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) MyScrollDelegate *scrollDelegate;

@property (nonatomic, strong) UIButton *pushBtn;

@property (nonatomic, strong) UIView *playerView;

@end

@implementation ViewController

- (void)loadView
{
    self.view = [[MyView alloc] init];
    [self.view addSubview:self.playerView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
    self.pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pushBtn setTitle:@"push" forState:UIControlStateNormal];
    self.pushBtn.frame = CGRectMake(100, 100, 100, 100);
    self.pushBtn.backgroundColor = UIColor.greenColor;
    [self.pushBtn addTarget:self action:@selector(didClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pushBtn];
//    self.scrollDelegate = [[MyScrollDelegate alloc] init];
//    [self setupScrollView];
//    DobbyHook(test_sum, new_sum, NULL);

    
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    NSLog(@"landscape: willanimation");
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    
    // 开始一个非常短的动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewController.view.alpha = 1.0;  // 确保新视图完全不透明
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];  // 动画完成，无论动画是否取消
    }];
}

- (void)didClick
{
    id<UINavigationControllerDelegate> delegate = self.navigationController.delegate;
    self.navigationController.delegate = self;
    
    MyViewController *vc = [[MyViewController alloc] init];
    vc.playerView = [self.playerView snapshotViewAfterScreenUpdates:NO];
    [self.navigationController pushViewController:vc animated:YES];
    
    self.navigationController.delegate = delegate;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    return self;
    
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

- (UIView *)playerView
{
    if (!_playerView) {
        _playerView = [[UIView alloc] init];
        _playerView.backgroundColor = UIColor.greenColor;
        _playerView.frame = [UIScreen mainScreen].bounds;
        UIView *core = [[UIView alloc] init];
        core.backgroundColor = UIColor.redColor;
        CGFloat width = _playerView.width;
        CGFloat height = _playerView.width*9/16;
        core.frame = CGRectMake(0, (_playerView.height-height)/2., width, height);
        [_playerView addSubview:core];
    }
    return _playerView;
}



@end
