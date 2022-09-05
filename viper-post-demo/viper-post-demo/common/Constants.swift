
import Foundation
import UIKit

let userDefaults = UserDefaults.standard
let screenSize = UIScreen.main.bounds
let generator = UIImpactFeedbackGenerator(style: .heavy)

var baseURl = "https://........"
var baseURlWeb = "https://....."

//server api request url
var addDevice_url = baseURl + "User/AddDevice"
var getPosts_url = baseURl + "User/Posts"
