//
//  News.swift
//  NewsApp
//
//  Created by Cengizhan DUMLU on 12.05.2021.
//

import Foundation


struct News : Decodable {
    
    let author : String?
    let title : String?
    let description : String?
    let url : String?
    let urlToImage : String?
    
    
}

struct NewsEnvelope : Decodable {
    let status : String
    let totalResults : Int
    let articles : [News]
    
    
    
}
