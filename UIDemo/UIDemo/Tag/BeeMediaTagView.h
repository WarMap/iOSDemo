//
//  BeeMediaTagView.h
//  BeeMediaFileEditor
//
//  Created by fengjiu on 2023/6/19.
//  Copyright © 2023 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BeeMediaTagView;
@class BMTagModel;

@protocol BeeMediaTagViewDelegate <NSObject>

/// 某个tag被选中
/// - Parameters:
///   - tagView: <#tagView description#>
///   - model: <#model description#>
- (void)tagView:(BeeMediaTagView *)tagView tagSelected:(BMTagModel *)model;


/// tagview的高度发生变化
/// - Parameters:
///   - tagView: <#tagView description#>
///   - height: <#height description#>
- (void)tagView:(BeeMediaTagView *)tagView heightChanged:(CGFloat)height;


@end

@interface BeeMediaTagView : UIView

@property (nonatomic, assign) BOOL twoCol;
@property (nonatomic, weak) id<BeeMediaTagViewDelegate> delegate;


/// 默认标签view的高度（两行）
+ (CGFloat)defaultHeight;

/// 选中标签后的高度
+ (CGFloat)selectedHeight;

@end

NS_ASSUME_NONNULL_END
