//
//  BMCollectonTextFiledView.h
//  BeeMediaFileEditor
//
//  Created by fengjiu on 2023/5/16.
//  Copyright © 2023 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMInputAnimater.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BMCollectonTextFiledViewDelegate <NSObject>


/// 输入框内容发生变化
/// - Parameters:
///   - textView: 输入框
///   - text: 输入的内容
///   - newHeight: 变化后新的高度
- (void)textView:(UITextView *)textView
       didChange:(NSString *)text
       newHeight:(CGFloat)newHeight;


/// 点击了确认
- (void)textBarConfirmed;

/// 推出编辑
- (void)textBarEndEdit;

@end

@interface BMCollectonTextFiledView : UIView<BMInputAnimater>

@property (nonatomic, weak) id<BMCollectonTextFiledViewDelegate> delegate;

/// textview最小高度
@property (nonatomic, assign) CGFloat minTextViewHeight;
/// textview最大高度
@property (nonatomic, assign) CGFloat maxTextViewHeight;

/// textviewContainer的高度，用于键盘升起来的时候做动画
- (CGFloat)textViewContainerHeight;

/// 默认textview文本，不是plackeholder
/// - Parameter defaultText: 文案
- (void)setDefaultText:(NSString *)defaultText;

/// 计算textview高度
- (CGFloat)calTextViewHeigh;

/// 当前BMCollectonTextFiledView高度变化时，textbar不动，动态调整collection高度
- (void)updateCollectionHeight;


@end

NS_ASSUME_NONNULL_END
