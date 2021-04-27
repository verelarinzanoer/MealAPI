//
//  MealViewModel.swift
//  MealAPI
//
//  Created by MACBOOK on 19/04/21.
//

import Foundation
import Combine
import SwiftyJSON


class MealViewModel: ObservableObject {
    @Published var data = [Meal]()
    
    init() {
        let url = "https://www.themealdb.com/api/json/v1/1/categories.php"

        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!){ (data, _, error) in
            if error != nil{
                print((error?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            let items = json["categories"].array!
            
            for i in items{
                let title = i["strCategory"].stringValue
                let description = i["strCategoryDescription"].stringValue
                let image = i["strCategoryThumb"].stringValue
                
                DispatchQueue.main.async {
                    self.data.append(Meal(title: title, image: image, description: description))
                }
            }
        }.resume()
    }
}
