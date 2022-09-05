import Foundation
extension Optional where Wrapped: Collection {

    var isNilOrEmpty: Bool {
        switch self {
        case .some(let value):
            return value.isEmpty
        case .none:
            return true
        }
    }
}
