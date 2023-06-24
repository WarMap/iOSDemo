//
//  BMCollectionReusableView.m
//  UIDemo
//
//  Created by fengjiu on 2023/6/22.
//

#import "BMCollectionReusableView.h"
#import "BMCollectionViewLayoutAttributes.h"

@interface BMCollectionReusableView ()

@property(nonatomic,strong)UIImageView* ivBackground;

@end

@implementation BMCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.ivBackground];
        self.ivBackground.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:@[
            [NSLayoutConstraint constraintWithItem:self.ivBackground attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0],
            [NSLayoutConstraint constraintWithItem:self.ivBackground attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant: 0.0],
            [NSLayoutConstraint constraintWithItem:self.ivBackground attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant: 0.0],
            [NSLayoutConstraint constraintWithItem:self.ivBackground attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant: 0.0]
            ]];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    //设置背景颜色
    BMCollectionViewLayoutAttributes *ecLayoutAttributes = (BMCollectionViewLayoutAttributes*)layoutAttributes;
    if (ecLayoutAttributes.color) {
        self.backgroundColor = ecLayoutAttributes.color;
    }
    if (ecLayoutAttributes.image) {
        self.ivBackground.image = ecLayoutAttributes.image;
    }
}


- (UIImageView*)ivBackground {
    if (!_ivBackground) {
        _ivBackground = [[UIImageView alloc]init];
        _ivBackground.contentMode = UIViewContentModeScaleAspectFill;
        _ivBackground.backgroundColor = [UIColor clearColor];
    }
    return _ivBackground;
}


@end
