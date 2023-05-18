//
//  BMInputAnimater.h
//  BeeMediaFileEditor
//
//  Created by fengjiu on 2023/5/17.
//  Copyright © 2023 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@protocol BMInputAnimater <NSObject>

- (void)animateWithOldHeight:(CGFloat)oldHeight newHeight:(CGFloat)newHeight;

@end

@interface BMInputAnimater : NSObject


/// 添加需要支持组动画的animater
/// - Parameter animater: animater 
- (void)addAnimater:(id<BMInputAnimater>)animater;

/// 基于新老高度做动画
/// - Parameters:
///   - oldHeight: 原始高度
///   - newHeight: 新高度
- (void)animateWithOldHeight:(CGFloat)oldHeight newHeight:(CGFloat)newHeight;

@end

NS_ASSUME_NONNULL_END
