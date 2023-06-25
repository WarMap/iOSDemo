//
//  BMSelectedTagContainer.m
//  UIDemo
//
//  Created by fengjiu on 2023/6/24.
//

#import "BMSelectedTagContainer.h"
#import "BMTwoImageTagView.h"

@interface BMSelectedTagContainer ()<BMTwoImageTagViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) BOOL layouted;

@property (nonatomic, strong) BMTwoImageTagView *tagView;

@property (nonatomic, strong) UILabel *shareLabel;

@end


@implementation BMSelectedTagContainer

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#define imageCellGap 8
#define cellLeftGap 6
#define cellImageLabelGap 2
#define leftGap 6


- (void)setupUI
{
    if (self.layouted) {
        [self updateCellWithTag:self.model.name];
        self.shareLabel.left = self.tagView.right + 6;
    } else {
        self.imageView.frame = CGRectMake(0,
                                          0,
                                          65,
                                          [self.class defaultHeight]);
        [self addSubview:self.imageView];
        
        [self setupCellWithTag:self.model.name];
        self.tagView.left = self.imageView.right + imageCellGap;
        self.tagView.centerY = self.height / 2.;

        [self addSubview:self.tagView];
        
        self.shareLabel.text = @"选择素材继续分享吧";
        [self.shareLabel sizeToFit];
        self.shareLabel.left = self.tagView.right + 6;
        self.shareLabel.centerY = self.height / 2.;
        [self addSubview:self.shareLabel];
        self.layouted = YES;
    }
}

#pragma mark - event
- (void)twoImageTagViewDidClickRightBtn:(BMTwoImageTagView *)twoImageTagView
{
    if ([self.delegate respondsToSelector:@selector(selectedTagContainerDeseleted:)]) {
        [self.delegate selectedTagContainerDeseleted:self];
    }
}

- (void)setupCellWithTag:(NSString *)tag
{
    self.tagView = [BMTwoImageTagView tagWithLeftImage:BME_IMG(@"bee_topic_hashtag")
                                                                text:tag
                                                          rightImage:BME_IMG(@"bee_topic_fire")];
    self.tagView.delegate = self;
}

- (void)updateCellWithTag:(NSString *)tag
{
    [self.tagView updateText:tag];
}



+ (CGFloat)defaultHeight
{
    return 52;
}

- (void)setModel:(BMTagModel *)model
{
    _model = model;
    [self setupUI];
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:BME_IMG(@"bee_topic_singleLineIcon")];
    }
    return _imageView;
}

- (UILabel *)shareLabel
{
    if (!_shareLabel) {
        _shareLabel = [[UILabel alloc] init];
        _shareLabel.font = [UIFont systemFontOfSize:14];
        _shareLabel.textColor = [UIColor whiteColor];
    }
    return _shareLabel;
}
@end
