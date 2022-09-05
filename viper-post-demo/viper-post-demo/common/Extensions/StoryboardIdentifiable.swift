
import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String { return String(describing: self) }
}

extension StoryboardIdentifiable where Self: UIView {
    static var storyboardIdentifier: String { return String(describing: self) }
}

extension UIViewController: StoryboardIdentifiable {}
extension UITableViewCell: StoryboardIdentifiable {}
extension UICollectionReusableView: StoryboardIdentifiable {}
extension UITableViewHeaderFooterView: StoryboardIdentifiable {}

extension UIStoryboard {

    func instantiateViewController<T: UIViewController>(withIdentifier identifier: String = T.storyboardIdentifier) -> T {
        guard let controller = self.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("There is no view controller with \(identifier) identifier")
        }

        return controller
    }

    func instantiateViewController<T: RawRepresentable>(withIdentifier identifier: T) -> UIViewController where T.RawValue == String {
        return instantiateViewController(withIdentifier: identifier.rawValue)
    }
}

// MARK: - Dequeuing Cells

extension UICollectionView {

    func dequeueReusableCell<T: UICollectionViewCell>(at indexPath: IndexPath, withIdentifier identifier: String = T.storyboardIdentifier) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("There is no cell with \(identifier) identifier")
        }

        return cell
    }
}

extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(at indexPath: IndexPath, withIdentifier identifier: String = T.storyboardIdentifier) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("There is no cell with \(identifier) identifier")
        }

        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withIdentifier identifier: String = T.storyboardIdentifier) -> T {
        guard let header = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            fatalError("There is no header/footer with \(identifier) identifier")
        }

        return header
    }
}

// MARK: - Registering

extension UITableView {

    func register<T: UITableViewCell>(class aClass: T.Type, identifier: String = T.storyboardIdentifier) {
        register(aClass, forCellReuseIdentifier: identifier)
    }

    func register<T: UITableViewCell>(nib: T.Type, nibName: String = T.storyboardIdentifier, identifier: String = T.storyboardIdentifier) {
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: identifier)
    }

    func register<T: UITableViewHeaderFooterView>(class aClass: T.Type, identifier: String = T.storyboardIdentifier) {
        register(aClass, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func register<T: UITableViewHeaderFooterView>(nib: T.Type, nibName: String = T.storyboardIdentifier, identifier: String = T.storyboardIdentifier) {
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
}

extension UICollectionView {

    func register<T: UICollectionViewCell>(nib: T.Type, nibName: String = T.storyboardIdentifier, identifier: String = T.storyboardIdentifier) {
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: identifier)
    }

    func register<T: UICollectionViewCell>(class aClass: T.Type, identifier: String = T.storyboardIdentifier) {
        register(aClass, forCellWithReuseIdentifier: identifier)
    }
}

extension UICollectionView {

    enum ElementKind {
        case header, footer

        fileprivate var name: String {
            switch self {
            case .header: return UICollectionView.elementKindSectionHeader
            case .footer: return UICollectionView.elementKindSectionFooter
            }
        }
    }
}

extension UICollectionView {

    func register<T: UICollectionReusableView>(class aClass: T.Type, elementKind kind: ElementKind, identifier: String = T.storyboardIdentifier) {
        register(aClass, forSupplementaryViewOfKind: kind.name, withReuseIdentifier: identifier)
    }

    func register<T: UICollectionReusableView>(nib: T.Type, nibName: String = T.storyboardIdentifier, elementKind kind: ElementKind, identifier: String = T.storyboardIdentifier) {
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind.name, withReuseIdentifier: identifier)
    }
}

// MARK: - Instantiating view from UINib
extension UINib {
    static func instantiate<T: StoryboardIdentifiable>(nibName: String = T.storyboardIdentifier, owner: Any? = nil, options: [AnyHashable: Any]? = nil, bundle: Bundle? = nil) -> T {
        guard let view = UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: owner, options: (options as! [UINib.OptionsKey : Any])).first as? T else {
            fatalError("There is no nib with name \(nibName)")
        }
        return view
    }
}
