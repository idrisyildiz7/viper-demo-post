import UIKit
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            
            return UIColor(cgColor: color)
        }
        set { layer.borderColor = newValue?.cgColor }
    }
}

extension UIView {
    func embed(_ childView: UIView) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(childView)
        NSLayoutConstraint.activate([
            childView.leftAnchor.constraint(equalTo: leftAnchor),
            childView.topAnchor.constraint(equalTo: topAnchor),
            childView.centerXAnchor.constraint(equalTo: centerXAnchor),
            childView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        layoutIfNeeded()
    }
    
    func makeShadow()
    { 
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 2.0
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
    
    func topBottomMakeShadow(){
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4.0
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
    
    
    func bottomShadowCell(color: UIColor)
    {
        self.layer.cornerRadius = 2
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,y: self.bounds.maxY - layer.shadowRadius,width: bounds.width,height: layer.shadowRadius)).cgPath
    }
    
    func bottomShadowView(color: UIColor)
    {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 1
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
    
    func makeShadow(color: UIColor)
    {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 3.0
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
    func makeBoldShadow(color: UIColor)
    {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4.0
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
}

extension UIView {
    private static let kRotationAnimationKey = "rotationanimationkey"
    
    func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func stopRotating() {
        DispatchQueue.main.async {
            if self.layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
                self.layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
            }
        }
    }
    
}

extension UIView {
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}




extension UIScrollView {
    
    /**
     * Set scrollView contenInset and also adjusts scrollIndicatorInsets by specified value
     * - parameter insets: value which will specify contentInset and scrollIndicatorInsets
     */
    func setupInsets(_ insets: UIEdgeInsets) {
        scrollIndicatorInsets = insets
        contentInset = insets
    }
    
    /**
     * Set scrollView contenInset.top and scrollIndicatorInsets.top by specified value
     * - parameter inset: top inset value. Has default value -  StyleManager.values.topInset
     */
    func setupTopInset(_ inset: CGFloat) {
        let insets = UIEdgeInsets(top: inset, left: 0, bottom: 0, right: 0)
        setupInsets(insets)
    }
}
extension UIView {
    /**
     Set x Position
     
     :param: x CGFloat
     by DaRk-_-D0G
     */
    func setX(x:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    /**
     Set y Position
     
     :param: y CGFloat
     by DaRk-_-D0G
     */
    func setY(y:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.y = y
        self.frame = frame
    }
    /**
     Set Width
     
     :param: width CGFloat
     by DaRk-_-D0G
     */
    func setWidth(width:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.width = width
        self.frame = frame
    }
    /**
     Set Height
     
     :param: height CGFloat
     by DaRk-_-D0G
     */
    func setHeight(height:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.height = height
        self.frame = frame
    }
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

extension UIScrollView {
    
    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y, width: 1,height: self.frame.height), animated: animated)
        }
    }
    
    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    } 
}

extension UIImageView
{
    func setTintColor(color: UIColor)
    {
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}

