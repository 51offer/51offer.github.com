/*:
 
 # Swift 的 Playground 学习
 
 > 我们一开始知道 ***Playground***，也知道然后查看一些变量及变量的历史记录。偶尔还知道可以做视图甚至动画展示但是，现在，你特么看到的是 ***MarkDown*** 语法，有没有。
 
 ### 参考文献
 - [XCPlayground介绍&实践](http://nshipster.cn/xcplayground/)
 - [XCPlayground苹果官网文档](https://developer.apple.com/library/mac/documentation/Miscellaneous/Reference/XCPlaygroundModuleRef/XCPlayground.html)
 
 ### 使用优势
 - 快速学习swift
 - 快速测试代码效果
 - 验证API
 - 富文本注释
 
 ![简单介绍](swift-playground.jpg)
 ![网络加载](https://avatars1.githubusercontent.com/u/5317671?v=3&s=460)
 
---
*/


import UIKit

/*:
 ### 变量
 > 至上而下执行，显示变量的当前值及历史记录的变化。
*/
var name = "杨志"
name += "平"


var graph = 0.0
for i in 0...100 {
    graph = sin(Double(i)/10.0)
}

/*:
 ### UI视图
 > 简单显示UI的基础元素
 */

let redView = UIView(frame:CGRectMake(0,0,100,100))
redView.backgroundColor = UIColor.redColor()
redView.layer.cornerRadius = 20
redView.layer.borderWidth = 3
redView.layer.borderColor = UIColor.whiteColor().CGColor

let circle = UIView(frame:CGRectMake(25,25,50,50))
circle.backgroundColor = UIColor.yellowColor()
circle.layer.cornerRadius = 80
redView.addSubview(circle)

/*:
 ## 重头戏
 ### 动画展示 & 网络请求
 >: 这里需要对 XCPlayground 有一点了解，好像还对SpriteKit做了支持[文章连接](http://letvar.com/blog/2014/06/swift-and-playgrounds-learn-to-program-in-a-fun-way-2/)
 */

// 这个库需要import
import XCPlayground


let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
containerView.backgroundColor = UIColor.yellowColor()
XCPlaygroundPage.currentPage.liveView = containerView

let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
view.center = CGPoint(x: containerView.center.x, y: containerView.center.y-100)
view.backgroundColor = UIColor.redColor()
containerView.addSubview(view)

UIView.animateWithDuration(3, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 6, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
        view.center.y += 100
    }, completion:{ (animation: Bool) in
        view.center.y -= 100
    }
)

// 异步操作：网络在家图片
// 旧接口：XCPSetExecutionShouldContinueIndefinitely(true)
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let url = NSURL(string: "https://avatars1.githubusercontent.com/u/5317671?v=3&s=460")!
let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
    data, _, _ in
    let image = UIImage(data: data!)
}
task.resume()


// 快速检查API接口
let url2 = NSURL(string: "http://www.test.51offer.com/mobile/abroad/query_school_by_name?name=%E4%B8%80")!
let task2 = NSURLSession.sharedSession().dataTaskWithURL(url2) {
    data, _, _ in
    let str = String(NSString(data: data!, encoding: NSUTF8StringEncoding))
    
}
task2.resume()


/*:
 ## 结构介绍
 - sources
 > 我们直接在 Playground 上面写代码，然后编译器会实时编译我们代码，并将结果显示出来。但是效率很低，source的作用就可以发挥出来
 
 - resources
 > 可以作为sandbox使用
 
*/

// 直接使用PicButton 这个class.
// 注意点：PicButton的类及初始化方法必须是public的

let btn = PicButton(frame: CGRectMake(0,0,200,100))



// 如上述：在resources中放入jpg图片，加载本地资源

if let path = NSBundle.mainBundle().pathForResource("swift-playground", ofType: "jpg") {
    let image = UIImage(contentsOfFile:path)
    let imageView = UIImageView(image: image)
    
}

/*:
 ### 代码注入[Injection for Xcode](https://github.com/johnno1962/injectionforxcode)
 > 虽然还没有亲测，但是看起来逼格满满的
 
 ![gif特效图](https://github.com/johnno1962/injectionforxcode/blob/master/documentation/images/injected.gif)
 */
// 有待下一步测试

