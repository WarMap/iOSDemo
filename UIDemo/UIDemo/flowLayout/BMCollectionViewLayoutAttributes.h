//
//  BMCollectionViewLayoutAttributes.h
//  UIDemo
//
//  Created by fengjiu on 2023/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic, copy) UIColor *color;
@property (nonatomic, copy) UIImage *image;

//此属性只是header会单独设置，其他均直接返回其frame属性
@property (nonatomic, assign, readonly) CGRect orginalFrame;



@end

NS_ASSUME_NONNULL_END
