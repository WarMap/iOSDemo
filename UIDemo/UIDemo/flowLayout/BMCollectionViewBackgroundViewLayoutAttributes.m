//
//  BMCollectionViewBackgroundViewLayoutAttributes.m
//  UIDemo
//
//  Created by fengjiu on 2023/6/22.
//

#import "BMCollectionViewBackgroundViewLayoutAttributes.h"

@implementation BMCollectionViewBackgroundViewLayoutAttributes

@synthesize headerFrame = _headerFrame;
@synthesize footerFrame = _footerFrame;

+ (instancetype)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind withIndexPath:(NSIndexPath *)indexPath orginalFrmae:(CGRect)orginalFrame{
    BMCollectionViewBackgroundViewLayoutAttributes *layoutAttributes = [super layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    [layoutAttributes setValue:[NSValue valueWithCGRect:orginalFrame] forKey:@"orginalFrame"];
    layoutAttributes.frame = orginalFrame;
    return layoutAttributes;
}

-(CGRect)orginalFrame {
    if ([self.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        return _headerFrame;
    } else if ([self.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        return _footerFrame;
    } else {
        return self.frame;
    }
}

- (void)callMethod:(BMBaseEventModel*)eventModel {
    NSAssert([eventModel isKindOfClass:[BMBaseEventModel class]], @"callMethod必须传入BMBaseEventModel类型参数");
    if (eventModel == nil) {
        return;
    }
    if (eventModel.eventName != nil) {
        self.eventName = eventModel.eventName;
    }
    if (eventModel.parameter) {
        self.parameter = eventModel.parameter;
    }
}


@end
