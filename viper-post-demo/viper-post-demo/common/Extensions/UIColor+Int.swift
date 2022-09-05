
import UIKit

extension UIColor {
    convenience init(hex: Int) {
        let r = CGFloat((hex >> 16) & 0x0000ff)
        let g = CGFloat((hex >> 8) & 0x0000ff)
        let b = CGFloat((hex) & 0x0000ff)
        self.init(red: r/0xff, green: g/0xff, blue: b/0xff, alpha: 1.0)
    }
}
extension UIColor {
    static func random(from colors: [UIColor]) -> UIColor? {
        return colors.randomElement()
    }
}
