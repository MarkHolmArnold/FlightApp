

import Foundation

class AppConfig {
    
    struct APIName {
        static let signIn: String = "AppLogin"
        static let signUp: String = "SignUp"
        static let threadList: String = "ListofThreads"
        static let threadDetail: String = "ThreadDetail"
        static let addComment: String = "AddComment"
        static let addReplyAgainstComment: String = "AddReplyAgainstComment"
        static let creatThread: String = "CreateThread"
    }
    
    static let baseUrl: String = "https://forumapp20201218175941.azurewebsites.net/API"
//    static let baseUrl: String = "https://ee999812dfb2.ngrok.io/API"

    static var apiKey: String {
        get {
            return "89w207ttnmbvvcfgta"
        }
    }
    
    static var apiVersion: String {
        get {
            return "1.0"
        }
    }
    
}
