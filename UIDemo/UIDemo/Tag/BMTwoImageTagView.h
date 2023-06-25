//
//  BMTwoImageTagView.h
//  UIDemo
//
//  Created by fengjiu on 2023/6/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BMTwoImageTagView;

@protocol BMTwoImageTagViewDelegate <NSObject>

- (void)twoImageTagViewDidClickRightBtn:(BMTwoImageTagView *)twoImageTagView;

@end

@interface BMTwoImageTagView : UIView

+ (instancetype)tagWithLeftImage:(UIImage *)leftImage
                            text:(NSString *)text
                      rightImage:(UIImage *)rightImage;

@property (nonatomic, weak) id<BMTwoImageTagViewDelegate> delegate;

- (void)updateText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
