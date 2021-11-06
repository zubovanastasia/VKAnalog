//
//  SearchCommunitiesAPI.swift
//  SearchCommunitiesAPI
//
//  Created by Anastasiia Zubova on 20.10.2021.
//

import Foundation
import Alamofire

final class SearchCommunitiesAPI {
    
    let baseURL = "https://api.vk.com/method"
    let token = Session.shared.token
    let userId = Session.shared.userId
    let version = "5.81"

    func getSearchGroups(complition: @escaping([SearchGroupModel]) -> ()) {
        
        let method = "/groups.search"
        
        let parameters: Parameters = [
            "access_token": token,
            "v": version,
            "q": "Music"
        ]
        let url = baseURL + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            guard let data = response.data else { return }
            
            debugPrint(response.data?.prettyJSON as Any)
            
            do {
                let jsonContainer: Any = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                let object = jsonContainer as! [String: Any]
                let response = object["response"] as! [String: Any]
                let items = response["items"] as! [Any]
                
                let searchGroups = items.map{SearchGroupModel(item: $0 as! [String: Any])}
                complition(searchGroups)
                
            } catch {
                print(error)
            }
        }
    }
}
