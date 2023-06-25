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
#import "BeeMediaTagView.h"
#import "BMCollectionViewHorzontalLayout.h"
#import "BMTwoImageTagView.h"


@interface ViewController ()<UITextViewDelegate, BeeMediaTagViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSHashTable *weakArray;
@property (nonatomic, strong) BMFloweryCharacterManager *manager;
@property (nonatomic, strong) UIImageView *progressView;

@property (nonatomic, strong) UIView *myView;
@property (nonatomic, assign) CGFloat sca;
@property (nonatomic, strong) BeeMediaTagView *topicView;
@property (nonatomic, strong) BMTwoImageTagView *tagView;

@end

@implementation ViewController
#define kHeightOfTopicView 103.f

#define textHeight  36
- (void)viewDidLoad {
    [super viewDidLoad];

    
}
- (BeeMediaTagView *)topicView
{
    if (!_topicView) {
        _topicView = [[BeeMediaTagView alloc] initWithFrame:CGRectMake(0,
                                                                       100,
                                                                       self.view.bounds.size.width,
                                                                       kHeightOfTopicView)];
        _topicView.backgroundColor = [UIColor blackColor];
        _topicView.delegate = self;
    }
    return _topicView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view addSubview:self.topicView];
}

#pragma mark - Label
/// 某个tag被选中
/// - Parameters:
///   - tagView: <#tagView description#>
///   - model: <#model description#>
- (void)tagView:(BeeMediaTagView *)tagView tagSelected:(BMTagModel *)model
{
    
}


/// tagview的高度发生变化
/// - Parameters:
///   - tagView: <#tagView description#>
///   - height: <#height description#>
- (void)tagView:(BeeMediaTagView *)tagView heightChanged:(CGFloat)height
{
    [UIView animateWithDuration:0.25 animations:^{
        self.topicView.height = height;
    } completion:^(BOOL finished) {
        
    }];
}



@end

