//
//  TreeNode.h
//  Algorithm
//
//  Created by mapeng on 2021/10/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TreeNode : NSObject<NSCopying>

@property (nonatomic, strong) TreeNode *left;
@property (nonatomic, strong) TreeNode *right;
@property (nonatomic, strong) NSNumber *value;

+ (instancetype)treeWithArray:(NSArray<NSNumber *> *)array;
@end

NS_ASSUME_NONNULL_END
