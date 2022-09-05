import UIKit
import Toast_Swift

extension UIViewController {
    func addChild(_ childController: UIViewController, to containerView: UIView) {
        guard let childView = childController.view else { return }
        addChild(childController)
        containerView.addSubview(childView)
        childView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            childView.topAnchor.constraint(equalTo: containerView.topAnchor),
            childView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            childView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            ])
        containerView.layoutIfNeeded()
        childController.didMove(toParent: self)
    }

    func removeFromParentFully() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }

    func hasChild<T: UIViewController>(ofType type: T.Type) -> Bool {
        return indexOfChild(ofType: type) != nil
    }

    private func indexOfChild<T: UIViewController>(ofType type: T.Type) -> Int? {
        if let index = children.index(where: { $0 is T }) {
            return index
        } else {
            return nil
        }
    }

    func removeChild<T: UIViewController>(ofType type: T.Type) {
        if let index = indexOfChild(ofType: type) {
            children[index].removeFromParentFully()
        }
    }
    
    func BG(_ block: @escaping ()->Void) {
        DispatchQueue.global(qos: .default).async(execute: block)
    }
    
    func UI(_ block: @escaping ()->Void) {
        DispatchQueue.main.async(execute: block)
    }
    
    func showToastMessageWithIcon(title:String, msg:String, color: UIColor = StyleManager.colors.colorPrimary)
    {
        var style = ToastStyle()
        style.messageColor = StyleManager.colors.white
        style.titleColor =  StyleManager.colors.white
        style.fadeDuration = 0.5
        style.backgroundColor  = color
        self.view.makeToast(msg, duration: 1.5, position: .top, image: UIImage(named: "popupLogo"), style: style)
        ToastManager.shared.isTapToDismissEnabled = true
        ToastManager.shared.isQueueEnabled = true
    }
    
    func showToastMessage(title:String, msg:String, color: UIColor = StyleManager.colors.colorPrimary)
    {
        var style = ToastStyle()
        style.messageColor = StyleManager.colors.white
        style.titleColor =  StyleManager.colors.white
        style.fadeDuration = 0.5
        style.backgroundColor  = color
        self.view.makeToast(msg, duration: 1.5, position: .top, style: style)
        ToastManager.shared.isTapToDismissEnabled = true
        ToastManager.shared.isQueueEnabled = true
    }
     
}

// MARK: - ONSUCCESS LOADING SPINNER
extension UIViewController {
    class func displayLayoutLoading(onView : UIView,backgroundColor:UIColor? = .clear) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = onView.backgroundColor
        let nav = UIActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        nav.style = .gray
        nav.color = StyleManager.colors.loading
        nav.startAnimating()
        nav.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(nav)
            onView.addSubview(spinnerView)
        }
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

extension UIViewController {
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
 
    func addHeader(cell:UITableViewCell, title:String) {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: cell.frame.width, height: 60))
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = title
        label.font = UIFont(name: "Avenir-Black", size: 12) ?? UIFont.systemFont(ofSize: 17)
        label.textColor = StyleManager.colors.blueGrey
        headerView.addSubview(label)
        cell.addSubview(headerView)
    }
}




extension UIViewController {
    func add(_ parent: UIViewController) {
        parent.addChild(self)
        parent.view.addSubview(view)
        didMove(toParent: parent)
    }

    func remove() {
        guard parent != nil else { return }

        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
 

 

extension UIViewController
{
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
