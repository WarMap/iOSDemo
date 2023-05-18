//
//  BMTextFiledBar.m
//  BeeMediaFileEditor
//
//  Created by fengjiu on 2023/5/16.
//  Copyright © 2023 Alipay. All rights reserved.
//

#import "BMTextFiledBar.h"

@interface BMTextFiledBar ()<UITextViewDelegate>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *checkButton;
@property (nonatomic, strong) UIButton *endEditButton;
@property (nonatomic, copy) NSString *editText;
@property (nonatomic, copy, readwrite) NSString *text;
@property (nonatomic, strong) UILabel *placeLabel;

/// 结束编辑按钮底部和textview底部的差值，为了输入框变高时，保持这个高度
@property (nonatomic, assign) CGFloat bottomDelta;

@end
#define textBarHeight 36.
@implementation BMTextFiledBar

- (BMTextFiledBar *)initWithDefaultTagWord:(NSString *)word
{
    self = [super init];
    if (self) {
        self.defaultEditText = word;
        [self setupItem];
        if (word.length > 0) {
            self.textView.text = word;
            self.placeLabel.hidden = YES;
        }
    }
    return self;
}

- (void)setupItem
{
    self.containerView = [[UIView alloc] init];
    self.containerView.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.16 alpha:1];
    self.containerView.layer.cornerRadius = 4;
    self.containerView.layer.masksToBounds = YES;
    
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.font = [UIFont systemFontOfSize:15.f];
    self.textView.textColor = [UIColor whiteColor];

    self.textView.showsVerticalScrollIndicator = NO;
    self.textView.showsHorizontalScrollIndicator = NO;
    
    self.placeLabel = [[UILabel alloc] init];
    self.placeLabel.textColor = [UIColor grayColor];
    self.placeLabel.font = [UIFont systemFontOfSize:15.];
    self.placeLabel.text = @"请输入文字";

    self.checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkButton setImage:BME_IMG(@"bee_confirm") forState:UIControlStateNormal];
    [self.checkButton setBackgroundColor:[UIColor redColor]];
    [self.checkButton addTarget:self
                         action:@selector(didClickedDone)
               forControlEvents:UIControlEventTouchUpInside];
    
    self.endEditButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.endEditButton setImage:BME_IMG(@"bee_cancel") forState:UIControlStateNormal];
    [self.endEditButton setBackgroundColor:[UIColor blueColor]];
    [self.endEditButton addTarget:self
                           action:@selector(didClickedEndEdit)
                 forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.textView];
    [self.textView addSubview:self.placeLabel];
    [self addSubview:self.checkButton];
    [self addSubview:self.endEditButton];
    self.endEditButton.hidden = YES;
    
    self.minTextViewHeight = 36;
    self.maxTextViewHeight = 70;
    
}

- (void)updateWithNewTextViewHeight:(CGFloat)tvHeight
{
    CGFloat deltaHeight = tvHeight - self.textView.height;
    self.containerView.height += deltaHeight;
    self.textView.height += deltaHeight;
    self.endEditButton.bottom = self.textView.bottom - self.bottomDelta;
    self.checkButton.centerY = self.textView.centerY;
}

- (void)customLayout
{
    CGFloat btnGap = 12;
    CGFloat btnWidth = 36;
    CGFloat containerLiftMargin =  16;
    self.containerView.frame = CGRectMake(containerLiftMargin,
                                          0,
                                          self.width-containerLiftMargin-btnGap*2-btnWidth,
                                          textBarHeight);
    self.checkButton.size = CGSizeMake(btnWidth, btnWidth);
    self.checkButton.right = self.width-btnGap;
    self.checkButton.top = 0;
    
    self.endEditButton.frame = self.checkButton.frame;
    
    CGFloat textViewLiftMargin = 12;
    CGFloat textViewRightMargin = 5;
    self.textView.size = CGSizeMake(self.containerView.width - textViewLiftMargin - textViewRightMargin,
                                    textBarHeight);
    self.textView.top = 0;
    self.textView.left = textViewLiftMargin;
    
    [self.placeLabel sizeToFit];
    self.placeLabel.centerY = self.textView.centerY;
    self.placeLabel.left = self.textView.left-6;
    
    self.bottomDelta = self.textView.bottom - self.endEditButton.bottom;
}

- (CGFloat)calTextViewHeigh {
    return [self calTextViewHeigh:self.textView];
}

- (CGFloat)calTextViewHeigh:(UITextView *)textView {
    CGSize size = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, MAXFLOAT)];
    CGFloat height = size.height;
    BeeLogInfo(@"textbar", @"text changed: %f", height);
    
    if (height < self.minTextViewHeight) {
        //    高度小于最低高度
        height = self.minTextViewHeight;
    } else if (height > self.maxTextViewHeight) {
        //    高度大于最大高度
        height = self.maxTextViewHeight;
    }
    return height;
}

#pragma mark - btn event
- (void)didClickedDone
{
    if ([self.delegate respondsToSelector:@selector(textBarConfirm:)]) {
        [self.delegate textBarConfirm:self];
    }
}

- (void)didClickedEndEdit
{
    [self.textView resignFirstResponder];
    [self customLayout];
    self.textView.contentOffset = CGPointMake(0, self.textView.contentSize.height-self.textView.height);

    if ([self.delegate respondsToSelector:@selector(didClickedEndEdit:)]) {
        [self.delegate didClickedEndEdit:self];
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.checkButton.hidden = YES;
    self.endEditButton.hidden = NO;
    if ([self.delegate respondsToSelector:@selector(textBarShouldBeginEditing:)]) {
        [self.delegate textBarShouldBeginEditing:self];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    self.checkButton.hidden = NO;
    self.endEditButton.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(textBarShouldEndEditing:)]) {
        [self.delegate textBarShouldEndEditing:self];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.placeLabel.hidden = (textView.text.length > 0);
    if ([self.delegate respondsToSelector:@selector(textBar:textView:didChange:)]) {
        [self.delegate textBar:self textView:textView didChange:textView.text];
    }
}

@end
