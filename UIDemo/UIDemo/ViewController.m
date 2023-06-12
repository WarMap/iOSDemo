//
//  ViewController.m
//  UIDemo
//
//  Created by fengjiu on 2023/5/16.
//

#import "ViewController.h"
#import "BMFloweryCharacterManager.h"
#import "TransformView.h"
#import "DemoViewController.h"
@interface ViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSHashTable *weakArray;
@property (nonatomic, strong) BMFloweryCharacterManager *manager;
@property (nonatomic, strong) UIImageView *progressView;

@property (nonatomic, strong) UIView *myView;
@property (nonatomic, assign) CGFloat sca;

@end

@implementation ViewController

#define textHeight  36
- (void)viewDidLoad {
    self.sca = 1;
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
 
    
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    self.myView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.myView];
//    UIImageView *transformView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_myView.bounds) - 50, CGRectGetHeight(_myView.bounds) - 50, 50, 50)];
//    transformView.backgroundColor = [UIColor clearColor];
//    transformView.image = BME_IMG(@"BeeText_Loading");;
//    [_myView addSubview:transformView];
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
//    [transformView addGestureRecognizer:panGesture];
    
//    self.progressView.frame = CGRectMake(100, 100, 20, 20);
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.sca+=0.2;
    NSLog(@"%@", NSStringFromCGRect(_myView.frame));
    CGRect transframe = CGRectApplyAffineTransform(self.myView.frame, CGAffineTransformMakeRotation(0.3));
    self.myView.transform = CGAffineTransformMakeRotation(0.3);
    NSLog(@"%@", NSStringFromCGRect(transframe));
    NSLog(@"%@", NSStringFromCGRect(_myView.frame));
    NSLog(@"%@", NSStringFromCGRect(_myView.bounds));
}


- (void)updateProgress:(float)progress downOriginalID:(NSString *)originalId
{
        [self startAnimation:self.progressView];
    [self performSelector:@selector(downloadCompleted) withObject:nil afterDelay:2];
}

- (void)downloadCompleted
{
    self.progressView.hidden = YES;
    [self.progressView.layer removeAllAnimations];
}

- (void)startAnimation:(UIView *)view
{
    self.progressView.hidden = NO;
    if ([view.layer.animationKeys containsObject:@"rotationAnimation"]) {
        return;
    }
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (UIImageView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 20, 20)];
//        _progressView.hidden = YES;
        _progressView.image = BME_IMG(@"BeeText_Loading");
    }
    return _progressView;
}
@end

