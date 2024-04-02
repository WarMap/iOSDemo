import UIKit

var greeting = "Hello, playground"

/*:
 
 
 #  Runloop


 ## 资料
 1. [Apple Doc](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Multithreading/RunLoopManagement/RunLoopManagement.html)
 2. [ibireme](https://blog.ibireme.com/2015/05/18/runloop)
 3. [desgard](https://github.com/Desgard/iOS-Source-Probe/blob/master/Objective-C/Foundation/Run%20Loop%20%E8%AE%B0%E5%BD%95%E4%B8%8E%E6%BA%90%E7%A0%81%E6%B3%A8%E9%87%8A.md)

 ## 核心点
 1. runloop与线程绑定
     1. 11对应
     2. 只能通过 `CFRunLoopGetCurrent` 和 `CFRunLoopGetMain` 函数来获得 CFRunLoop 对象
     3. `CFRunLoopGetCurrent` 获取当前线程的 `CFRunLoop` 对象，如果不存在的话会则会创建一个，也即开启当前线程的 run loop
 2. runloop的接口类
      1. CFRunLoopRef
     1. CFRunLoopModeRef
     2. CFRunLoopSourceRef
     3. CFRunLoopTimerRef
     4. CFRunLoopObserverRef
     
     
     ![关系图](runloop_relation.png)
     一个 RunLoop 包含若干个 Mode，每个 Mode 又包含若干个 Source/Timer/Observer。每次调用 RunLoop 的主函数时，只能指定其中一个 Mode，这个Mode被称作 CurrentMode。如果需要切换 Mode，只能退出 Loop，再重新指定一个 Mode 进入。这样做主要是为了分隔开不同组的 Source/Timer/Observer，让其互不影响。

 ## 应用
 1. [RunLoopWorkDistribution](https://github.com/diwu/RunLoopWorkDistribution) runloop 打散，beforewaiting处理任务

 */
