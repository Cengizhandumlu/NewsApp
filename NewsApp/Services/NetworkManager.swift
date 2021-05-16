//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Cengizhan DUMLU on 12.05.2021.
//

import Foundation


class NetworkManager {
    
    let imageCache = NSCache<NSString, NSData>()
    
    static let shared = NetworkManager()
    private init(){
    }
    
    private let baseUrlString = "https://newsapi.org/v2/"
    private let USTopHeadline = "top-headlines?country=us"
    
    
    func getNews(completion: @escaping ([News]?) -> Void){ //news array can be empty
        let urlString = "\(baseUrlString)\(USTopHeadline)&apiKey=5aa3104c4eee45b5a9592981e570e6d6"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            let newsEnvelope = try? JSONDecoder().decode(NewsEnvelope.self, from: data)
            newsEnvelope == nil ? completion(nil) : completion(newsEnvelope!.articles)
        }.resume()
        
    }
    
    func getImage(urlString: String, completion: @escaping (Data?)-> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        if let cacheImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cacheImage as Data)
        }else {
            URLSession.shared.dataTask(with: url) { data , response , error  in
                guard error == nil , let data = data else {
                    completion(nil)
                    return
                    
                }
                self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
                completion(data)
                
            }.resume()
        }
    }
    
}
