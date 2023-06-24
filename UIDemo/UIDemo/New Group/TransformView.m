//
//  TransformView.m
//  UIDemo
//
//  Created by fengjiu on 2023/5/30.
//

#import "TransformView.h"

@implementation TransformView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 添加拖拽手势识别器
//        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
//        [self addGestureRecognizer:panGesture];
        UIImageView *transformView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) - 50, CGRectGetHeight(self.bounds) - 50, 50, 50)];
        transformView.backgroundColor = [UIColor clearColor];
        transformView.image = BME_IMG(@"BeeText_Loading");;
        [self addSubview:transformView];
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [transformView addGestureRecognizer:panGesture];
        transformView.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}

//- (void)drawRect:(CGRect)rect {
//    // 绘制旋转和缩放图标
//    UIImage *image = BME_IMG(@"BeeText_Loading");
//    CGRect imageRect = CGRectMake(self.bounds.size.width - 30, self.bounds.size.height - 30, 30, 30);
//    [image drawInRect:imageRect];
//}


- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {
    NSLog(@"tuo zhuai ne");
    UIView *transformedView = gestureRecognizer.view.superview;
    CGPoint translation = [gestureRecognizer translationInView:transformedView];
    CGPoint center = transformedView.center;
    CGFloat scale = 1.0;
    CGFloat rotation = 0.0;
    CGFloat velocity = [gestureRecognizer velocityInView:transformedView].x;
    CGFloat damping = 0.9;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        // Apply damping when gesture ends
        damping = 0.5;
    }
    
    if (gestureRecognizer.numberOfTouches == 2) {
        // Calculate scale and rotation when gesture involves two fingers
        CGPoint point1 = [gestureRecognizer locationOfTouch:0 inView:transformedView];
        CGPoint point2 = [gestureRecognizer locationOfTouch:1 inView:transformedView];
        CGFloat distance = sqrt(pow(point1.x - point2.x, 2) + pow(point1.y - point2.y, 2));
        scale = distance / 100;
        rotation = atan2(point1.y - point2.y, point1.x - point2.x);
    }
    
    transformedView.transform = CGAffineTransformMakeScale(scale, scale);
    transformedView.transform = CGAffineTransformRotate(transformedView.transform, rotation);
    
    [gestureRecognizer setTranslation:CGPointZero inView:transformedView];
    
    CGRect frame = transformedView.frame;
    frame.origin.x = center.x - (frame.size.width / 2);
    frame.origin.y = center.y - (frame.size.height / 2);
    transformedView.frame = frame;
    
    // Apply velocity-based damping to rotation
    rotation = rotation + velocity / 1000.0;
    rotation *= damping;
}




//- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture {
//    CGPoint translation = [gesture translationInView:self.superview];
//    CGPoint center = self.center;
//    CGFloat scale = 1.0;
//    CGFloat rotation = 0.0;
//
//    if (gesture.state == UIGestureRecognizerStateBegan) {
//        // 记录当前的旋转角度和缩放比例
//        rotation = self.rotation;
//        scale = self.scale;
//    }
//    else if (gesture.state == UIGestureRecognizerStateChanged) {
//        // 根据手势的位移计算旋转角度和缩放比例
//        CGFloat distance = sqrt(pow(translation.x, 2) + pow(translation.y, 2));
//        rotation = atan2(translation.y, translation.x);
//        scale = MAX(distance / 100, 1);
//    }
//
//    // 更新视图的变换属性
//    self.transform = CGAffineTransformMakeRotation(rotation);
//    self.transform = CGAffineTransformScale(self.transform, scale, scale);
//
//    // 将视图移动到新的位置
//    center.x += translation.x;
//    center.y += translation.y;
//    self.center = center;
//
//    // 重置手势的位移
//    [gesture setTranslation:CGPointZero inView:self.superview];
//
//    // 更新旋转角度和缩放比例
//    self.rotation = rotation;
//    self.scale = scale;
//}

@end
