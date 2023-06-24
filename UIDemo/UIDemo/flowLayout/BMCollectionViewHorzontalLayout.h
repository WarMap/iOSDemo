//
//  BMCollectionViewHorzontalLayout.h
//  UIDemo
//
//  Created by fengjiu on 2023/6/22.
//

#import "BMCollectionViewBaseFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMCollectionViewHorzontalLayout : BMCollectionViewBaseFlowLayout

//目前支持两行
@property (nonatomic, assign) CGFloat topLeftGap; //横向布局时，第一行左侧的间隙，
@property (nonatomic, assign) CGFloat bottomLeftGap; //横向布局时，第二行左侧的间隙，

@end

NS_ASSUME_NONNULL_END
