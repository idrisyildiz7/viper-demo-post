import UIKit.UIStoryboard
extension UIStoryboard {
    convenience init(name: String) {
        self.init(name: name, bundle: nil)
    }
    static var Main: UIStoryboard { return UIStoryboard(name: "Main") }
    static var Start: UIStoryboard { return UIStoryboard(name: "Start") }
    static var CreatePost: UIStoryboard { return UIStoryboard(name: "CreatePost") }

}
