//
//  BMFloweryCharacterManager.h
//  BeeMediaFileEditor
//
//  Created by fengjiu on 2023/5/16.
//  Copyright © 2023 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^closeTextPanelEvent)(void);

@interface BMFloweryCharacterManager : NSObject

@property (nonatomic, assign, readonly) BOOL showing;
@property (nonatomic, assign, readonly) BOOL editing;
@property (nonatomic, copy) dispatch_block_t closeEvent;
@property (nonatomic, copy) dispatch_block_t closeAnimate;

//构造方法

//可配置项

- (void)showPanelWithContainer:(UIView *)container sibling:(dispatch_block_t _Nullable)sibling;

- (void)hidePanelWithSibling:(dispatch_block_t _Nullable)sibling;

@end

NS_ASSUME_NONNULL_END
