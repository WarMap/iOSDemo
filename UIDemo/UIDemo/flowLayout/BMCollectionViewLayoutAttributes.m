//
//  BMCollectionViewLayoutAttributes.m
//  UIDemo
//
//  Created by fengjiu on 2023/6/22.
//

#import "BMCollectionViewLayoutAttributes.h"

@implementation BMCollectionViewLayoutAttributes
@synthesize orginalFrame = _orginalFrame;

+ (instancetype)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind
                                          withIndexPath:(NSIndexPath *)indexPath
                                           orginalFrmae:(CGRect)orginalFrame
{
    BMCollectionViewLayoutAttributes *layoutAttributes = [super layoutAttributesForDecorationViewOfKind:decorationViewKind
                                                                                          withIndexPath:indexPath];
    [layoutAttributes setValue:[NSValue valueWithCGRect:orginalFrame] forKey:@"orginalFrame"];
    layoutAttributes.frame = orginalFrame;
    return layoutAttributes;
}

- (CGRect)orginalFrame
{
    if ([self.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        return _orginalFrame;
    } else {
        return self.frame;
    }
}

@end
