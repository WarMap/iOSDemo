//
//  BMFoldableTagView.m
//  UIDemo
//
//  Created by fengjiu on 2023/6/25.
//

#import "BMFoldableTagView.h"
#import "BMSelectedTagContainer.h"

@interface BMFoldableTagView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) BMSelectedTagContainer *label;

@end

@implementation BMFoldableTagView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self customLayout];
    }
    return self;
}

#define labelHeight 30

- (void)customLayout
{
    self.label.frame = CGRectMake(0, 0, 0, 30);
    self.imageView.frame = CGRectMake(0, 0, 54, 78);
}

- (void)updateUI
{
    
}

+ (CGFloat)defaultHeight
{
    return 72;
}

- (void)setModel:(BMTagModel *)model
{
    _model = model;
    self.label.model = model;
    [self updateUI];
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:BME_IMG(@"")];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (void)setDelegate:(id<BMSelectedTagContainerDelegate>)delegate
{
    _delegate = delegate;
    self.label.delegate = delegate;
}

- (BMSelectedTagContainer *)label
{
    if (!_label) {
        _label = [[BMSelectedTagContainer alloc] init];
        [self addSubview:_label];
    }
    return _label;
}

@end
