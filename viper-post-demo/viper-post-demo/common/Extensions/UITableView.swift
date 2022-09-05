
import Foundation
import UIKit
extension UITableView{
    func reloadDataWithoutScrolling(){
        let contentOffset = self.contentOffset
        self.reloadData()
        self.layoutIfNeeded()
        self.setContentOffset(contentOffset, animated: false)
    }
}
