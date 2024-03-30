//
//  MyScrollDelegate.m
//  UIDemo
//
//  Created by fengjiu on 2024/3/14.
//

#import "MyScrollDelegate.h"

@implementation MyScrollDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    // 计算UIScrollView的大小
     CGSize viewSize = scrollView.bounds.size;
     
     // 根据水平滚动或垂直滚动计算目标页面的索引
     // 对于水平滚动的UIScrollView，使用targetContentOffset->x
     // 对于垂直滚动的UIScrollView，使用targetContentOffset->y
     NSInteger targetPageIndex = targetContentOffset->y / viewSize.height;
     
     // 打印目标页面的索引
     NSLog(@"UIScrollView将要停在页面: %ld", (long)targetPageIndex);
}

// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

@end
