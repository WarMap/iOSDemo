//
//  BMCollectionViewBackgroundViewLayoutAttributes.h
//  UIDemo
//
//  Created by fengjiu on 2023/6/22.
//

#import <UIKit/UIKit.h>
#import "BMBaseEventModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMCollectionViewBackgroundViewLayoutAttributes : UICollectionViewLayoutAttributes

//此属性只是header会单独设置，其他均直接返回其frame属性
@property(nonatomic,assign,readonly)CGRect headerFrame;
@property(nonatomic,assign,readonly)CGRect footerFrame;

@property(nonatomic,copy)NSString* eventName;
@property(nonatomic,copy)id parameter;

- (void)callMethod:(BMBaseEventModel*)eventModel;

@end

NS_ASSUME_NONNULL_END
