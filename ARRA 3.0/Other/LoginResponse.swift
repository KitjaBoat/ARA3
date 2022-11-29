import UIKit


enum WebAPIKey: String {
    case SELECT = "SELECT"
    case INSERT = "INSERT"
    case UPDATE = "UPDATE"
    case DELETE = "DELETE"
    case UPLOAD = "UPLOAD"
}

enum RoleStatus: Int {
    case DIRECTOR = 1
    case EXECUTIVE = 2
    case SALE_MANAGER = 3
    case PRE_SALE = 4
    case SALE_SUPERVISOR = 5
    case SALE = 6
    case SALE_MA = 30
}


class Welcome: Codable {
    let status: Int
    let message: String
    let entries: LoginResponse
}


class LoginResponse:Codable{
    
    static var cacheKey = "Login"
    static var current: LoginResponse?
    
     let user: User?
     var allowModule: [String]?
     var webService: [WebService]?
     var environments: [Environment]?
     var token: String?
     var BUSelected: BusinessUnit?
    
   
    
//    static func getCache() -> LoginResponse? {
////        if LoginResponse.current == nil {
////            if let cacheModel = CacheManager.getCache(key: cacheKey), let modelData = cacheModel.data {
////                LoginResponse.current = LoginResponse( modelData )
////            }
////        }
////
////        return LoginResponse.current
//    }
    
//    static func shouldLoginEnv() -> Bool {
//        if let loginResponse = LoginResponse.getCache() {
//            if loginResponse.environments?.count ?? 0 > 0 {
//                return true
//            }
//        }
//
//        return false
//    }

  
}




