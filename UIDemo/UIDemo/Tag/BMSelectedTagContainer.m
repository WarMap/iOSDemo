//
//  BMSelectedTagContainer.m
//  UIDemo
//
//  Created by fengjiu on 2023/6/24.
//

#import "BMSelectedTagContainer.h"

@interface BMSelectedTagContainer ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) BOOL layouted;

@property (nonatomic, strong) UIView *cell;
@property (nonatomic, strong) UIImageView *leftImage;
@property (nonatomic, strong) UIImageView *rightImage;
@property (nonatomic, strong) UILabel *label;

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
        self.shareLabel.left = self.cell.right + 6;
    } else {
        self.imageView.frame = CGRectMake(0,
                                          0,
                                          65,
                                          [self.class defaultHeight]);
        [self addSubview:self.imageView];
        
        self.cell.left = self.imageView.right + imageCellGap;
        [self setupCellWithTag:self.model.name];
        self.cell.centerY = self.height / 2.;

        [self addSubview:self.cell];
        
        self.shareLabel.text = @"选择素材继续分享吧";
        [self.shareLabel sizeToFit];
        self.shareLabel.left = self.cell.right + 6;
        self.shareLabel.centerY = self.height / 2.;
        [self addSubview:self.shareLabel];
        self.layouted = YES;
    }
}

#define gap 6
#define leftImageWidth 18
#define leftImageLabelGap 2
#define cellHeight 30

- (void)setupCellWithTag:(NSString *)tag
{
    self.cell.backgroundColor = [UIColor blackColor];
    self.cell.layer.borderColor = RGB(0x333333).CGColor;
    self.cell.layer.borderWidth = 1;
    self.cell.layer.cornerRadius = 8;
    
    self.leftImage.size = CGSizeMake(leftImageWidth, leftImageWidth);
    self.leftImage.left = gap;
    self.leftImage.centerY = cellHeight/2.;
    
    [self.cell addSubview:self.leftImage];
    
    self.label.text = self.model.name;
    [self.label sizeToFit];
    self.label.left = self.leftImage.right + leftImageLabelGap;
    self.label.centerY = cellHeight/2.;
    [self.cell addSubview:self.label];
    
    self.rightImage.size = CGSizeMake(leftImageWidth, leftImageWidth);
    self.rightImage.left = self.label.right + gap;
    self.rightImage.centerY = cellHeight/2.;
    
    [self.cell addSubview:self.rightImage];
    
    CGFloat width = gap + self.leftImage.width + leftImageLabelGap + self.label.width + gap + self.rightImage.width + gap;
    self.cell.width = width;
    self.cell.height = cellHeight;
}

- (void)updateCellWithTag:(NSString *)tag
{
    self.label.text = self.model.name;
    [self.label sizeToFit];
    self.label.left = self.leftImage.right + leftImageLabelGap;
    
    self.rightImage.left = self.label.right + gap;
    
    CGFloat width = gap + self.leftImage.width + leftImageLabelGap + self.label.width + gap + self.rightImage.width + gap;
    self.cell.width = width;
    self.cell.height = cellHeight;
}

- (void)didTapRightImage
{
    if ([self.delegate respondsToSelector:@selector(selectedTagContainerDeseleted:)]) {
        [self.delegate selectedTagContainerDeseleted:self];
    }
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

- (UIView *)cell
{
    if (!_cell) {
        _cell = [[UIView alloc] init];
    }
    return _cell;
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
