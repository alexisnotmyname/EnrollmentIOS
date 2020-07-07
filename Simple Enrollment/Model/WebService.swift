//
//  WebService.swift
//  Simple Enrollment
//
//  Created by Alexander Roca on 7/5/20.
//  Copyright © 2020 Alexander Roca. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct WebService {
    
    
    static func getAllData(completion: @escaping (_ success: [EnrollmentInfo]) -> Void) {
        let url = Constants.baseUrl+"/api/v1/enrollment"
        NSLog("API CALL: \(url)")
        AF.request(url).responseDecodable(of: [EnrollmentInfo].self) { (response) in
            guard let data = response.value else { return }
            completion(data)
        }
    }
    
    static func enroll(data_img: Data?, json: [String: Any], completion: @escaping (_ success: Response) -> Void) {
        let url = Constants.baseUrl+"/api/v1/enrollment/create"
        NSLog("API CALL: \(url)")
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
    
        AF.upload(multipartFormData: { multipartFormData in
            if let imgData = data_img {
                multipartFormData.append(imgData, withName: "imageFile", fileName: Util.getTempFileName(), mimeType: "image/jpg")
            }
            guard let data = try? JSONSerialization.data(withJSONObject: json, options: []) else {return}
            guard let convertedString = String(data: data, encoding: String.Encoding.utf8) else {return}
            multipartFormData.append(Data(convertedString.utf8), withName: "data")
            
        }, to: url, method: .post, headers: headers)
        .responseDecodable(of: Response.self) { (response) in
            guard let respData = response.value else {return}
            completion(respData)
        }
    }
    
    static func delete(idNo: String, completion: @escaping (_ success: Response) -> Void) {
        let params: Parameters = [
            "idNo": idNo
        ]
        let url = Constants.baseUrl+"/api/v1/enrollment/delete"
        AF.request(url, method: .delete, parameters: params, headers: nil)
            .responseDecodable(of: Response.self) { (response) in
                guard let respData = response.value else {return}
                completion(respData)
        }
    }
}

