//
//  MealDetail.swift
//  MealAPI
//
//  Created by MACBOOK on 19/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MealDetail: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: FavoriteMeal.entity(), sortDescriptors: []) var favoriteMeal: FetchedResults<FavoriteMeal>
    let meal: Meal
    
    var body: some View { 
        ScrollView{
            VStack(alignment: .leading){
                WebImage(url: URL(string: meal.image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 20){
                    Text(meal.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(meal.description)
                        .font(.body)
                    
                    HStack(alignment: .center){
                        if (checkId(id: meal.id) == true){
                            Button(action: {
                                self.deleteFavoriteMeal(id: meal.id)
                                try? self.moc.save()
                            }){
                                 HStack{
                                    Image(systemName: "trash").foregroundColor(.red)
                                    Text("delete from favorite").foregroundColor(.red)
                                }.padding(7)
                                .cornerRadius(30)
                            }
                        } else {
                            Button(action: {
                                self.addFavoriteMeal(data: meal)
                                try? self.moc.save()
                            }){
                                HStack{
                                    Image(systemName: "heart").foregroundColor(.blue)
                                    Text("add to favorite").foregroundColor(.blue)
                                }.padding(7)
                                .overlay( RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 2)
                                )
                            }
                        }
                    
                }.padding()
            }
        }
        
        
    }
}

private func checkId(id : UUID) -> Bool {
    for meal in favoriteMeal{
        if meal.wrappedId == id{
            return true
        }
    }
    return false
}
private func deleteFavoriteMeal(id: UUID){
    for meal in favoriteMeal{
        if meal.wrappedId == id{
            moc.delete(meal)
        }
    }
}
private func addFavoriteMeal(data: Meal){
    let favorite = FavoriteMeal(context: self.moc)
    favorite.id = data.id
    favorite.title = data.title
    favorite.image = data.image
    favorite.desc = data.description
}
}

