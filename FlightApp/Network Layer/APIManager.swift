//
//  APIManager.swift
//  FlightApp
//
//  Created by Mark on 04/04/2022.
//

import Foundation
import Alamofire

private let contentType = "application/json"

enum NetworkResult<T> {
    case success(T)
    case failure(String)
}

class NetworkState {
    class func isConnected() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class APIManager {
    static let sharedInstance = APIManager()
    private var sessionManager = Alamofire.Session()
    private let baseURL: URL = URL(string: "https://api.spacexdata.com/")!
    
    private init() {
    }
    
    
    fileprivate func networkErrorCode(_ error: (AFError)) -> NetworkError{
        switch error.responseCode ?? 0 {
        case NetworkError.Error.badRequest.rawValue:
            return NetworkError(code: error.responseCode ?? 0, error: .badRequest)
        default:
            return NetworkError(code: error.responseCode ?? 0, error: .badRequest)
        }
    }
    
    fileprivate func networkUnknownError() -> NetworkError {
        return NetworkError(code: NetworkError.Error.unknown.rawValue, error: .unknown)
    }
    
    private func dataRequest<T: Decodable>(for urlRequest: URLRequestConvertible, completeOn queue: DispatchQueue, completion: @escaping NetworkManagerResultHandler<T>) -> DataRequest {
        
        return self.sessionManager
            .request(urlRequest)
            .responseData(completionHandler: {[weak self] response in
                
                switch response.result {
                case .success(let rawData):
                    Log.d(String(decoding: rawData, as: UTF8.self))
                    guard let response = try? JSONDecoder().decode(T.self, from: rawData) else {
                        queue.async { [weak self] in
                            guard let `self` = self else { return }
                            completion(.failure(self.networkUnknownError()))
                        }
                        return
                    }
                    queue.async { completion(.success(response)) }
                    
                case .failure(let error):
                    
                    if let data = response.data {
                        Log.e(String(decoding: data, as: UTF8.self))
                    }
                    queue.async { [weak self] in
                        guard let `self` = self else { return }
                        completion(.failure(self.networkErrorCode(error)))
                    }
                }
            })
        
    }
    
    static func buildSessionManager() -> Session {
        let sessionManager = Session.buildDefaultConfiguration()
        return sessionManager
    }
    
    func jsonToData(json: Any) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch let myJSONError {
            Log.e(myJSONError)
        }
        return nil;
    }
    
    private func urlRequest(for resource: Endpoint, language: String = "en", systemVersion: String = UIDevice.current.systemVersion) -> URLRequestConvertible? {
        return URLRequest(baseURL: self.baseURL, endpoint: resource)
        
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}

extension Session {
    static func buildDefaultConfiguration() -> Session {
        
        let configuration = URLSessionConfiguration.default
        return Session(configuration: configuration)
        
    }
    
    static func  buildNoCacheableConfiguration() -> Session {
        
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        
        return Session(configuration: configuration)
        
    }
}

// MARK: - NetworkManager Delegates
extension APIManager: NetworkManager {
    func execute<T: Decodable>(_ endpoint: Endpoint, completion: @escaping NetworkManagerResultHandler<T>) {
        execute(endpoint, completeOn: .main, completion: completion)
    }
    
    func execute<T: Decodable>(_ endpoint: Endpoint, completeOn queue: DispatchQueue, completion: @escaping NetworkManagerResultHandler<T>) {
        
        guard let apiURLRequest = self.urlRequest(for: endpoint) else { return }
        let dataRequest = self.dataRequest(for: apiURLRequest, completeOn: queue, completion: completion)
        
        
        Log.d(dataRequest)
        dataRequest.resume()
    }
    
    func cancelTask(for resource: Endpoint, considerUrlParams: Bool) {
        
        guard let apiURLRequest = self.urlRequest(for: resource),
              let urlRequest = try? apiURLRequest.asURLRequest() else { return }
        
        self.sessionManager.session.getAllTasks { (tasks) in
            tasks.filter({
                if considerUrlParams { return $0.originalRequest?.url?.absoluteString == urlRequest.url?.absoluteString }
                else { return  $0.originalRequest?.url?.path == urlRequest.url?.path }
            }).forEach{ $0.cancel() }
        }
    }
    
    func download(_ url: URL, to destiantionUrl: URL, progressHandler: ProgressHandler?, completion: @escaping DownloadResultHandler) {
        
        self.sessionManager.download(url, to:  { (_, _) -> (URL, DownloadRequest.Options) in
            return (destiantionUrl, [.removePreviousFile])
            
        }).downloadProgress { progress in
            let percentage = Float(progress.completedUnitCount) / Float(progress.totalUnitCount)
            progressHandler?(percentage)
        }.validate()
            .responseData { response in
                switch response.result {
                case .success: completion(.success(destiantionUrl))
                case .failure(let error): completion(.failure(self.networkErrorCode(error)))
                }
            }.resume()
    }
    
    func uploadFile<T: Codable>(endPoint: String,
                                headers: [String:String] = ["Content-type": "multipart/form-data"],
                                withParams: [String: Any] = [:],
                                withName: String,
                                fileData: Data,
                                fileName: String,
                                mimeType: String,
                                andMethod method:HTTPMethod = .post,
                                encoding: ParameterEncoding = JSONEncoding.default,
                                completeOn queue: DispatchQueue,
                                completion: @escaping NetworkManagerResultHandler<T>) {        if NetworkState.isConnected() {
        let urlString = "\(self.baseURL)\(endPoint)"
        
        _ = AF.upload(multipartFormData: { multipartFormData in
            
            multipartFormData.append(fileData, withName: withName, fileName: fileName, mimeType: mimeType)
            for key in withParams.keys{
                let name = String(key)
                if let value = withParams[name] as? String {
                    guard let valueData = value.data(using: .utf8) else { continue }
                    multipartFormData.append(valueData, withName: name)
                }
            }
        }, to: urlString, method: method.alamoFireMethod).responseData(completionHandler: { response in
            
            switch response.result {
            case .success(let rawData):
                Log.d(String(decoding: rawData, as: UTF8.self))
                guard let response = try? JSONDecoder().decode(T.self, from: rawData) else {
                    queue.async { [weak self] in
                        guard let `self` = self else { return }
                        completion(.failure(self.networkUnknownError()))
                    }
                    return
                }
                queue.async { completion(.success(response)) }
                
            case .failure(let error):
                
                if let data = response.data {
                    Log.e(String(decoding: data, as: UTF8.self))
                }
                queue.async { [weak self] in
                    guard let `self` = self else { return }
                    completion(.failure(self.networkErrorCode(error)))
                }
            }
        })
    }
        else{
            print("Please make sure your phone has active internet connection and try again.")
            completion(.failure(self.networkUnknownError()))
        }
    }
    func requestApi<T: Codable>(endPoint: String,
                                withParams: [String: Any],
                                andMethod method:HTTPMethod = .post,
                                encoding: ParameterEncoding = JSONEncoding.default,
                                completeOn queue: DispatchQueue,
                                completion: @escaping NetworkManagerResultHandler<T>){
        
        if NetworkState.isConnected() {
            let urlString = "\(self.baseURL)\(endPoint)"
            AF.request(urlString, method: method.alamoFireMethod, parameters: withParams, encoding: encoding, headers: ["Content-Type" : "application/json"]).responseData(completionHandler: { response in
                switch response.result {
                case .success(let rawData):
                    Log.d(String(decoding: rawData, as: UTF8.self))
                    guard let response = try? JSONDecoder().decode(T.self, from: rawData) else {
                        queue.async { [weak self] in
                            guard let `self` = self else { return }
                            completion(.failure(self.networkUnknownError()))
                        }
                        return
                    }
                    queue.async { completion(.success(response)) }
                    
                case .failure(let error):
                    
                    if let data = response.data {
                        Log.e(String(decoding: data, as: UTF8.self))
                    }
                    queue.async { [weak self] in
                        guard let `self` = self else { return }
                        completion(.failure(self.networkErrorCode(error)))
                    }
                }
            })
        }
        
        else{
            print("Please make sure your phone has active internet connection and try again.")
            completion(.failure(self.networkUnknownError()))
        }
    }
}


