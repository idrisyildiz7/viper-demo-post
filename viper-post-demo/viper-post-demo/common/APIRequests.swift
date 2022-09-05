
import Foundation
import SwiftyJSON
import Alamofire
import JGProgressHUD

class APIRequests: NSObject {
    
    static let shared = APIRequests()
    var headers: HTTPHeaders!
    
    func header()
    {
        if userDefaults.string(forKey: requestParams.token.rawValue) != nil {
            headers = [
                .authorization("Bearer \(userDefaults.string(forKey: requestParams.token.rawValue) ?? "")"),
                .accept("application/json")
            ]
        }else{
            headers = [
                .accept("application/json")
            ]
        }
    }
    
    
    func headerFile()
    {
        if userDefaults.string(forKey: requestParams.token.rawValue) != nil {
            headers = [
                .authorization("Bearer \(userDefaults.string(forKey: requestParams.token.rawValue) ?? "")"),
                .accept("application/json"),
                .contentType("multipart/form-data")
            ]
        }else{
            headers = [
                .accept("application/json"),
                .contentType("multipart/form-data")
            ]
        }
    }
    
    func request(method:HTTPMethod, url: String, parameters:[String: Any], completion: @escaping (_ jsonObject: JSON?, _ isSuccess:Bool) -> Void)
    {
        header()
        
        if NetworkReachabilityManager()!.isReachable
        {
            AF.request(url, method: method, parameters: parameters, headers: headers)
                .validate(statusCode: 200..<501)
                .responseData { response in
                    switch response.result {
                    case .success(let value):
                        print(value)
                        if JSON(value)["meta"]["code"].intValue == 200 {
                            completion(JSON(value),true)
                        }else
                        {
                            completion(JSON(value),false)
                        }
                    case .failure(let error):
                        print(error)
                        completion(nil, false)
                    }
                }
            
        }else
        {
            completion(nil, false)
        }
    }
}

enum requestParams: String {
    case email
    case password
    case token
}

enum StateCode:Int
{
    case  Informational = 100
    case  Success = 200
    case  Redirection = 300
    case  ClientError = 400
    case  ServerError = 500
    case  AuthenticationError = 501
}

