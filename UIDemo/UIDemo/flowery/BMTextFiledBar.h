//
//  BMTextFiledBar.h
//  BeeMediaFileEditor
//
//  Created by fengjiu on 2023/5/16.
//  Copyright © 2023 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BMTextFiledBar;

typedef void(^TextChangeBlcok)(NSString *content);

@protocol BMTextFiledBarDelegate <NSObject>


/// 输入框内容发生变化
/// - Parameters:
///   - textBar: bar
///   - textView: 输入框
///   - text: 框里内容
- (void)textBar:(BMTextFiledBar *)textBar
       textView:(UITextView *)textView
      didChange:(NSString *)text;

/// 即将开始输入
/// - Parameter textBar: 输入bar
- (void)textBarShouldBeginEditing:(BMTextFiledBar *)textBar;

/// 点击了确认
/// - Parameter textBar: bar
- (void)textBarConfirm:(BMTextFiledBar *)textBar;

/// 结束编辑
/// - Parameter textBar: bar
- (void)didClickedEndEdit:(BMTextFiledBar *)textBar;

@optional

/// 即将结束编辑
/// - Parameter textBar:
- (void)textBarShouldEndEditing:(BMTextFiledBar *)textBar;

@end

@interface BMTextFiledBar : UIView

@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy) TextChangeBlcok textChanged;
@property (nonatomic, copy) NSString *defaultEditText;
@property (nonatomic, weak) id<BMTextFiledBarDelegate> delegate;
@property (nonatomic, assign) CGFloat minTextViewHeight;
@property (nonatomic, assign) CGFloat maxTextViewHeight;

- (BMTextFiledBar *)initWithDefaultTagWord:(NSString * _Nullable)word;

/// 一定要调用
- (void)customLayout;


/// 基于minTextViewHeight和maxTextViewHeight还有当前text计算出的高度
- (CGFloat)calTextViewHeigh;

/// 基于minTextViewHeight和maxTextViewHeight还有textview.text计算出的高度
/// - Parameter textView: 要计算高度的textview
- (CGFloat)calTextViewHeigh:(UITextView *)textView;

/// 基于想要的textview高度，调整视图
/// - Parameter tvHeight: 变化的高度
- (void)updateWithNewTextViewHeight:(CGFloat)tvHeight;

@end

NS_ASSUME_NONNULL_END
