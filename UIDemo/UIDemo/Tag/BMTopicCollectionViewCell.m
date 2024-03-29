//
//  BMTopicCollectionViewCell.m
//  BeeMediaFileEditor
//
//  Created by fengjiu on 2023/6/19.
//  Copyright © 2023 Alipay. All rights reserved.
//

#import "BMTopicCollectionViewCell.h"
#import "BeeMediaMarco.h"

@interface BMTopicCollectionViewCell ()

@property (nonatomic, strong) UIImageView *leftImage;
@property (nonatomic, strong) UIImageView *rightImage;
@property (nonatomic, strong) UILabel *label;

@end


@implementation BMTopicCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = RGB(0x333333).CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 8;
    }
    return self;
}
#define gap 6
#define leftImageWidth 18
#define leftImageLabelGap 2

- (void)setupUI
{
    if (self.model.isMore) {
        self.leftImage.hidden = YES;
        self.label.hidden = NO;
        self.rightImage.hidden = NO;
        
        self.label.text = self.model.name;
        [self.label sizeToFit];
        self.label.left = gap * 2;
        self.label.centerY = self.height/2.;
        
        self.rightImage.image = BME_IMG(@"bee_topic_fire");
        self.rightImage.size = CGSizeMake(leftImageWidth, leftImageWidth);
        self.rightImage.left = self.label.right + leftImageLabelGap;
        self.rightImage.centerY = self.height/2.;
    } else {
        self.leftImage.hidden = NO;
        self.label.hidden = NO;
        
        self.leftImage.size = CGSizeMake(leftImageWidth, leftImageWidth);
        self.leftImage.left = gap;
        self.leftImage.centerY = self.height/2.;
        
        self.backgroundColor = [UIColor clearColor];
        fjlog(@"%@", self.model.name)
        self.label.text = self.model.name;
        [self.label sizeToFit];
        self.label.left = self.leftImage.right + leftImageLabelGap;
        self.label.centerY = self.height/2.;
        
        if (_model.hasHotImage) {
            self.rightImage.hidden = NO;
            self.rightImage.size = CGSizeMake(leftImageWidth, leftImageWidth);
            self.rightImage.left = self.label.right + leftImageLabelGap;
            self.rightImage.centerY = self.height/2.;
        } else {
            self.rightImage.hidden = YES;
        }
    }
}

- (void)setModel:(BMTagModel *)model
{
    _model = model;
    [self setupUI];
}

+ (CGFloat)extWidthWithModel:(BMTagModel *)model
{
    if ([model hasHotImage]) {
        return gap + leftImageWidth + leftImageLabelGap + leftImageLabelGap + leftImageWidth + gap;
    } else if ([model isMore]) {
        return gap + leftImageWidth + leftImageLabelGap + gap + gap;
    } else {
        return gap + leftImageWidth + leftImageLabelGap + gap;
    }
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_label];
    }
    return _label;
}

- (UIImageView *)leftImage {
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc] initWithImage:BME_IMG(@"bee_topic_hashtag")];
        [self.contentView addSubview:_leftImage];
    }
    return _leftImage;
}

- (UIImageView *)rightImage {
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc] initWithImage:BME_IMG(@"bee_topic_fire")];
        [self.contentView addSubview:_rightImage];
    }
    return _rightImage;
}

@end
