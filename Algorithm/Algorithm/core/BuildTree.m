//
//  BuildTree.m
//  Algorithm
//
//  Created by mapeng on 2021/10/17.
//

#import "BuildTree.h"

@implementation BuildTree

+ (void)run {
    int preorder[] = {3,9,2,1,7};
    int inorder[] = {9,3,1,2,7};
    TreeNode *node = [self buildTreeWithPreorder:cArray2ocArray(preorder, 5) inorder:cArray2ocArray(inorder, 5)];
    NSLog(@"tree is :%@", node);
}

+ (TreeNode *)buildTreeWithPreorder:(NSArray<NSNumber *> *)preoder
                      inorder:(NSArray<NSNumber *> *)inorder {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [inorder enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dic[obj] = @(idx);
    }];
    TreeNode *node = [self recurWithProRoot:0
                    inLeft:0
                   inRight:inorder.count-1
                     inDic:dic
                  preorder:preoder];
    return node;
}

+ (TreeNode *)recurWithProRoot:(NSUInteger)preRoot
                        inLeft:(NSInteger)inLeft
                       inRight:(NSInteger)inRight
                         inDic:(NSDictionary *)dic
                      preorder:(NSArray<NSNumber *> *)preorder
{
    NSLog(@"preroot:%d, inleft:%d, inright:%d", preRoot, inLeft, inRight);
    if (inLeft > inRight) {
        return nil;
    }
    TreeNode *node = [[TreeNode alloc] init];
    node.value = preorder[preRoot];
    NSNumber *i = dic[preorder[preRoot]];
    node.left = [self recurWithProRoot:preRoot+1
                                inLeft:inLeft
                               inRight:IV(i)-1
                                 inDic:dic
                              preorder:preorder];
    //    leftTreeNodeCount = IV(i)-inLeft 这个树，做分支的节点个数。 （参照中序遍历
    //。   treeStarter = preroot是这个树的起始位置 （参照前序遍历
    //    treeStarter + leftTreeNodeCount 就是根和左子树
    //    treeStarter + leftTreeNodeCount + 1 就是右子树的开始
    //    右子树开始，参照前序遍历，第一个也就是右子树的根即。preRoot+IV(i)-inLeft+1
    node.right = [self recurWithProRoot:preRoot+IV(i)-inLeft+1
                                 inLeft:IV(i)+1
                                inRight:inRight
                                  inDic:dic
                               preorder:preorder];
    return node;
}
@end
