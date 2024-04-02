import UIKit

var greeting = "Hello, playground"

//:# hello




/*:
 
 backboardd 负责转发硬件相关事件
 
 Adaptive-Sync是由美国的非营利性标准制定组织VESA提出的基于DisplayPort接口的可变帧率显示技术，目的是为了解决画面撕裂和卡顿掉帧的问题；
 * item
 
 ProMotion `120Hz` 的可用性限制

 ProMotion 的120Hz并不总是可用帧速率，用户可以在辅助功能设置中打开限制帧速率动态变换，将最大帧率限制至60Hz；当设备负载过大，出现过热情况时，系统会限制120Hz的可用性；在iPadOS 15和iOS 15中，低电量模式的的设备会强制限制ProMotion最大帧率为60Hz。对于上述情况，绝大多数App都无需特别适配。但如果您的App执行逐帧的自定义绘制，那么您需要处理上述帧速率限制事件。
 
 ![IMG_20240311_105011.png](https://fgimg.top/thumbnails/caebef3b4475a1be14cc59b97b5d53e6.png)
 
 */
