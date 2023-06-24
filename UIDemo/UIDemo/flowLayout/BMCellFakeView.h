//
//  BMCellFakeView.h
//  UIDemo
//
//  Created by fengjiu on 2023/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMCellFakeView : UIView

@property (nonatomic, weak)UICollectionViewCell *cell;
@property (nonatomic, strong)UIImageView *cellFakeImageView;
@property (nonatomic, strong)UIImageView *cellFakeHightedView;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, assign)CGPoint originalCenter;
@property (nonatomic, assign)CGRect cellFrame;

- (instancetype)initWithCell:(UICollectionViewCell *)cell;
- (void)changeBoundsIfNeeded:(CGRect)bounds;
- (void)pushFowardView;
- (void)pushBackView:(void(^)(void))completion;


@end

NS_ASSUME_NONNULL_END
