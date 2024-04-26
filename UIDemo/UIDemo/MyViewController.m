//
//  MyViewController.m
//  UIDemo
//
//  Created by fengjiu on 2024/4/25.
//

#import "MyViewController.h"

@interface MyViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) UIButton *pushBtn;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.playerView];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
    self.pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pushBtn setTitle:@"push" forState:UIControlStateNormal];
    self.pushBtn.frame = CGRectMake(100, 100, 100, 100);
    self.pushBtn.backgroundColor = UIColor.greenColor;
    [self.pushBtn addTarget:self action:@selector(didClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pushBtn];
}
//- (void)viewDidAppear:(BOOL)animated
//{
//    [self performSelector:@selector(landscape) withObject:nil afterDelay:2];
////    [self landscape];
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self changeOrientationToLandscape];

}

- (void)changeOrientationToLandscape
{
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.anyObject;
        if ([windowScene respondsToSelector:@selector(requestGeometryUpdateWithPreferences:errorHandler:)]) {
            UIWindowSceneGeometryPreferencesIOS *preferences = [[UIWindowSceneGeometryPreferencesIOS alloc] initWithInterfaceOrientations:UIInterfaceOrientationMaskLandscapeRight];
            [windowScene requestGeometryUpdateWithPreferences:preferences errorHandler:^(NSError * _Nonnull error) {
                NSLog(@"%@", error);
            }];
        }
    } else {
        // iOS 12 或更早的版本方向调整
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        [self setNeedsUpdateOfSupportedInterfaceOrientations];
    }
}

- (void)changeOrientationToPortrait {
    if (@available(iOS 13.0, *)) {
        // 获取当前的 UIWindowScene
        UIWindowScene *windowScene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.anyObject;
        // 创建几何偏好设置为竖屏
        UIWindowSceneGeometryPreferencesIOS *preferences = [[UIWindowSceneGeometryPreferencesIOS alloc] initWithInterfaceOrientations:UIInterfaceOrientationMaskPortrait];
        // 请求更新窗口场景的方向
        [windowScene requestGeometryUpdateWithPreferences:preferences errorHandler:^(NSError * _Nonnull error) {
            NSLog(@"Error changing orientation: %@", error);
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    NSLog(@"landscape: heiehie");
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    
    // 开始一个非常短的动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewController.view.alpha = 1.0;  // 确保新视图完全不透明
    } completion:^(BOOL finished) {
//        [self landscape];
        [transitionContext completeTransition:YES];  // 动画完成，无论动画是否取消
    }];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;

}
// 默认方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    if (size.width > size.height) {
        [self viewWillTransitToLandscape:size withTransitionCoordinator:coordinator];
    }
    else {
        [self viewWillTransitToPortrait:size withTransitionCoordinator:coordinator];
    }
}

- (void)viewWillTransitToLandscape:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    
    if (coordinator) {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            NSLog(@"ani: %");
//            self.playerView.transform = context.targetTransform;
            
            CGFloat videoH = self.playerView.width*9/16;
            
            CGFloat scale = size.width/self.playerView.width;
            
            CGFloat width = size.width;
            CGFloat height = self.playerView.height * scale;
            
            
            self.playerView.frame = CGRectMake(0, -(height-videoH*scale)/2,width,height);
            [self.view layoutIfNeeded];
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
        }];
    }
}

- (void)viewWillTransitToPortrait:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        NSLog(@"ani: %");
        //            self.playerView.transform = context.targetTransform;
        
        
        CGFloat scale = size.width/self.playerView.width;
        
        CGFloat width = size.width;
        CGFloat height = self.playerView.height * scale;
        
        
        self.playerView.frame = CGRectMake(0, 0,width,height);
        [self.view layoutIfNeeded];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self bacck];
    }];
}


- (void)didClick
{    [self changeOrientationToPortrait];  // 在视图将要消失时调用


}

- (void)bacck
{
    id<UINavigationControllerDelegate> delegate = self.navigationController.delegate;
    self.navigationController.delegate = self;
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    self.navigationController.delegate = delegate;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    return self;
    
}


@end
