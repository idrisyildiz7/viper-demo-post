
import Foundation
class Dataholder {
    public static let shared = Dataholder()
    init() {}
    var users = [UserModel]()
    var currentUser = UserModel()
    var postItems = [PostModel]()
    var showAllPost = false
 }

