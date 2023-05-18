//
//  BMCollectonTextFiledView.m
//  BeeMediaFileEditor
//
//  Created by fengjiu on 2023/5/16.
//  Copyright © 2023 Alipay. All rights reserved.
//

#import "BMCollectonTextFiledView.h"
#import "BMTextFiledBar.h"


@interface BMCollectonTextFiledView ()<BMTextFiledBarDelegate, BMInputAnimater>

@property (nonatomic, strong) UIView *textBarContainer;
@property (nonatomic, strong) BMTextFiledBar *textBar;
@property (nonatomic, strong) UICollectionView *collectionview;

@end



#define itemVerticalGap 16

@implementation BMCollectonTextFiledView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupItem];
        [self customLayout];
        self.backgroundColor = RGB(0x111111);
    }
    return self;
}

- (void)setupItem {
    self.textBarContainer = [[UIView alloc] init];
    self.textBarContainer.backgroundColor = [UIColor clearColor];
    
    self.textBar = [[BMTextFiledBar alloc] initWithDefaultTagWord:@"点击输入文字"];
    self.textBar.delegate = self;
    self.minTextViewHeight = 36;
    self.maxTextViewHeight = 70;
    
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    self.collectionview = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionview.backgroundColor = [UIColor yellowColor];
    
    [self addSubview:self.textBarContainer];
    [self.textBarContainer addSubview:self.textBar];
    [self addSubview:self.collectionview];
}

#pragma mark - public API
- (void)setMinTextViewHeight:(CGFloat)minTextViewHeight {
    _minTextViewHeight = minTextViewHeight;
    self.textBar.minTextViewHeight = minTextViewHeight;
}

- (void)setMaxTextViewHeight:(CGFloat)maxTextViewHeight {
    _maxTextViewHeight = maxTextViewHeight;
    self.textBar.maxTextViewHeight = maxTextViewHeight;
}

- (void)setDefaultText:(NSString *)defaultText {
    self.textBar.defaultEditText = defaultText;
}

- (CGFloat)textViewContainerHeight {
    return self.textBarContainer.height;
}

- (void)updateCollectionHeight {
    self.collectionview.top = self.textBarContainer.bottom;
    self.collectionview.height = self.height - self.textBarContainer.height;
}

- (void)customLayout {
    [self customLayoutWithTextViewHeight:self.minTextViewHeight];
}

- (void)customLayoutWithTextViewHeight:(CGFloat)tvheight {
    CGFloat itemGap = itemVerticalGap;
    CGFloat textBarHeigh = tvheight;
    self.textBarContainer.frame = CGRectMake(0,
                                             0,
                                             self.width,
                                             textBarHeigh + itemGap*2
                                             );
    self.textBar.frame = CGRectMake(0,
                                    itemGap,
                                    self.width,
                                    textBarHeigh);
    [self.textBar customLayout];
    self.collectionview.size = CGSizeMake(self.width, self.height-self.textBarContainer.height);
    self.collectionview.top = self.textBarContainer.bottom;
}




#pragma mark - BMTextFiledBarDelegate
- (void)textBar:(BMTextFiledBar *)textBar
       textView:(UITextView *)textView
      didChange:(NSString *)text {
    CGFloat height = [self.textBar calTextViewHeigh];
    //    高度没有变化就不用动了
    if (height == textView.height) {
        return;
    }
    BeeLogInfo(@"textbar", @"animate height: %f", height);
    if ([self.delegate respondsToSelector:@selector(textView:didChange:newHeight:)]) {
        [self.delegate textView:textView didChange:text newHeight:height];
    }
}

- (void)textBarConfirm:(BMTextFiledBar*)textBar {
    if ([self.delegate respondsToSelector:@selector(textBarConfirmed)]) {
        [self.delegate textBarConfirmed];
    }
}

- (void)didClickedEndEdit:(BMTextFiledBar *)textBar {
    [self customLayout];
    if ([self.delegate respondsToSelector:@selector(textBarEndEdit)]) {
        [self.delegate textBarEndEdit];
    }
}

- (void)textBarShouldBeginEditing:(BMTextFiledBar *)textBar {
//  更新直系子view高度
    CGFloat height = [self.textBar calTextViewHeigh];
    [self customLayoutWithTextViewHeight:height];
    
//  更新textBar
    [self.textBar updateWithNewTextViewHeight:height];
}

#pragma mark - Label
- (void)animateWithOldHeight:(CGFloat)oldHeight newHeight:(CGFloat)newHeight {
    CGFloat height = newHeight - oldHeight;
    self.textBar.height += height;
    self.textBarContainer.height += height;
    self.collectionview.top = self.textBarContainer.bottom;
    self.collectionview.bottom = self.superview.height;
    [self.textBar updateWithNewTextViewHeight:newHeight];
}

@end
