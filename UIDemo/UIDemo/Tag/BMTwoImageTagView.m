//
//  BMTwoImageTagView.m
//  UIDemo
//
//  Created by fengjiu on 2023/6/25.
//

#import "BMTwoImageTagView.h"

@interface BMTwoImageTagView ()

@property (nonatomic, strong) UIImageView *leftImage;
@property (nonatomic, strong) UIImageView *rightImage;
@property (nonatomic, strong) UILabel *label;

@end

@implementation BMTwoImageTagView

+ (instancetype)tagWithLeftImage:(UIImage *)leftImage
                            text:(NSString *)text
                      rightImage:(UIImage *)rightImage
{
    BMTwoImageTagView *tagView = [[BMTwoImageTagView alloc] initWithLeftImage:leftImage
                                                                         text:text
                                                                   rightImage:rightImage];
    return tagView;
}

- (instancetype)initWithLeftImage:(UIImage *)leftImage
                    text:(NSString *)text
              rightImage:(UIImage *)rightImage
{
    self = [super init];
    if (self) {
        self.leftImage.image = leftImage;
        self.label.text = text;
        self.rightImage.image = rightImage;
        [self setupUI];
        [self sizeToFit];
    }
    return self;
}

- (void)updateText:(NSString *)text
{
    self.label.text = text;
    [self sizeToFit];
}

- (void)setupUI
{
    self.backgroundColor = [UIColor blackColor];
    self.layer.borderColor = RGB(0x333333).CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 8;
}

#define gap 6
#define leftImageWidth 18
#define leftImageLabelGap 2
#define cellHeight 30

- (void)sizeToFit
{
    self.leftImage.size = CGSizeMake(leftImageWidth, leftImageWidth);
    self.leftImage.left = gap;
    self.leftImage.centerY = cellHeight/2.;
    
    [self addSubview:self.leftImage];
    
    [self.label sizeToFit];
    self.label.left = self.leftImage.right + leftImageLabelGap;
    self.label.centerY = cellHeight/2.;
    [self addSubview:self.label];
    
    self.rightImage.size = CGSizeMake(leftImageWidth, leftImageWidth);
    self.rightImage.left = self.label.right + gap;
    self.rightImage.centerY = cellHeight/2.;
    
    [self addSubview:self.rightImage];
    
    CGFloat width = gap + self.leftImage.width + leftImageLabelGap + self.label.width + gap + self.rightImage.width + gap;
    self.width = width;
    self.height = cellHeight;
}

#pragma mark - event
- (void)didTapRightImage
{
    if ([self.delegate respondsToSelector:@selector(twoImageTagViewDidClickRightBtn:)]) {
        [self.delegate twoImageTagViewDidClickRightBtn:self];
    }
}


#pragma mark - getter

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor whiteColor];
    }
    return _label;
}

- (UIImageView *)leftImage {
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc] initWithImage:BME_IMG(@"bee_topic_hashtag")];
    }
    return _leftImage;
}

- (UIImageView *)rightImage {
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc] initWithImage:BME_IMG(@"bee_topic_fire")];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(didTapRightImage)];
        _rightImage.userInteractionEnabled = YES;
        [_rightImage addGestureRecognizer:tap];
    }
    return _rightImage;
}
@end
