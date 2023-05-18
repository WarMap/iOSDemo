//
//  BMFloweryCharacterManager.m
//  BeeMediaFileEditor
//
//  Created by fengjiu on 2023/5/16.
//  Copyright © 2023 Alipay. All rights reserved.
//

#import "BMFloweryCharacterManager.h"
#import "BMCollectonTextFiledView.h"
#import "BMInputAnimater.h"

@interface BMFloweryCharacterManager ()<BMCollectonTextFiledViewDelegate, BMInputAnimater>

@property (nonatomic, strong) BMCollectonTextFiledView *colTextView;
@property (nonatomic, assign, readwrite) BOOL showing;
@property (nonatomic, assign, readwrite) BOOL editing;
@property (nonatomic, strong) BMInputAnimater *animater;

@end

@implementation BMFloweryCharacterManager

#define panelHeight 284

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupNotification];
        self.animater = [[BMInputAnimater alloc] init];
        [self.animater addAnimater:self];
    }
    return self;
}

- (void)setupNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}




static const int animateTimeInterval = 0.25;

#pragma mark - keyboard event
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 处理键盘升起事件
    if (self.showing) {
        self.editing = YES;
        WS(ws);
        [UIView animateWithDuration:animateTimeInterval animations:^{
            __strong typeof(ws) ss = ws;
            ss.colTextView.height = keyboardFrame.size.height + [ss.colTextView textViewContainerHeight];
            ss.colTextView.bottom = ss.colTextView.superview.bottom;
        } completion:^(BOOL finished) {
            __strong typeof(ws) ss = ws;
            [ss.colTextView updateCollectionHeight];
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.editing = NO;
    // 处理键盘收起事件
}

#pragma mark - panel handle
- (void)hidePanelWithSibling:(dispatch_block_t)sibling
{
    if (self.colTextView.superview) {
        self.showing = NO;
        WS(ws);
        [UIView animateWithDuration:animateTimeInterval animations:^{
            __strong typeof(ws) ss = ws;
            ss.colTextView.top = ss.colTextView.superview.height;
            if (sibling) {
                sibling();
            }
        }];
    }
    if (self.closeEvent) {
        self.closeEvent();
    }
}

- (void)showPanelWithContainer:(UIView *)container sibling:(dispatch_block_t)sibling
{
    if (!container) {
        return;
    }
    
    if (!self.showing) {
        self.showing = YES;
        if (!self.colTextView) {
            [self setupColtextViewWithSuperView:container];
        }
        [container addSubview:self.colTextView];
        WS(ws);
        [UIView animateWithDuration:animateTimeInterval animations:^{
            __strong typeof(ws) ss = ws;
            ss.colTextView.bottom = ss.colTextView.superview.height;
            if (sibling) {
                sibling();
            }
        }];
    }
}

- (void)setupColtextViewWithSuperView:(UIView *)superView
{
    self.colTextView = [[BMCollectonTextFiledView alloc] initWithFrame:CGRectMake(0,
                                                                                  superView.height,
                                                                                  superView.width,
                                                                                  panelHeight)];
    self.colTextView.delegate = self;
    [self.animater addAnimater:self.colTextView];
}

#pragma mark - BMCollectonTextFiledViewDelegate

/// 输入框内容发生变化
/// - Parameters:
///   - textView: 输入框
///   - text: 输入的内容
///   - newHeight: 变化后新的高度
- (void)textView:(UITextView *)textView
       didChange:(NSString *)text
       newHeight:(CGFloat)newHeight;
{
    if (textView.height != newHeight) {
        [self.animater animateWithOldHeight:textView.height newHeight:newHeight];
    }
}

/// 点击了确认
- (void)textBarConfirmed
{
    [self hidePanelWithSibling:self.closeAnimate];
    if (self.closeEvent) {
        self.closeEvent();
    }
}

/// 推出编辑
- (void)textBarEndEdit
{
    if (self.showing) {
        WS(ws);
        [UIView animateWithDuration:animateTimeInterval animations:^{
            __strong typeof(ws) ss = ws;
            ss.colTextView.height = panelHeight;
            ss.colTextView.bottom = ss.colTextView.superview.bottom;
        } completion:^(BOOL finished) {
            __strong typeof(ws) ss = ws;
            [ss.colTextView updateCollectionHeight];
        }];
    }
}

#pragma mark - BMInputAnimater

- (void)animateWithOldHeight:(CGFloat)oldHeight newHeight:(CGFloat)newHeight
{
    CGFloat deltaHeight = newHeight - oldHeight;
    self.colTextView.height += deltaHeight;
    self.colTextView.bottom = self.colTextView.superview.bottom;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
