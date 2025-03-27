//
//  PostUIModel.swift
//  pleny task
//
//  Created by Micheal Hany on 26/03/2025.
//

import Foundation

struct PostUIModel{
    
    
    var res:Post
    
    var id:UUID{
        res.uuid
    }
    
    var userImage:String?{
        res.userImage
    }
    
    var userName:String?{
        res.userName
    }
    
    var postDate:Int?{
        res.postDate
    }
    
    var postBody:String?{
        res.body
    }
    
    var postImages:[String]?{
        res.postImages
    }
    
}
