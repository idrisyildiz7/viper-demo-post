
import UIKit

class AlertHelper {
    
    static func showUIAlert(withTitle title: String, message: String, actions: [UIAlertAction] = [], vc:UIViewController) {
        let uiAlert = getUIAlert(with: title, message: message, actions: actions)
        vc.present(uiAlert, animated: true, completion: nil)
    }
    
    fileprivate static func getUIAlert(with title: String, message: String, actions: [UIAlertAction] = []) -> UIAlertController {
        let uiAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            uiAlert.addAction(action)
        }
        return uiAlert
    }
}
