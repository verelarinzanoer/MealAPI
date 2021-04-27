//
//  FavoriteMealList.swift
//  MealAPI
//
//  Created by MACBOOK on 21/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteMealList: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: FavoriteMeal.entity(), sortDescriptors: []) var favoriteMeal: FetchedResults<FavoriteMeal>
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(favoriteMeal, id: \.self){ item in
                        NavigationLink(destination: FavoriteMealDetail(data: item)){
                            HStack{
                                //jika fotonya ada
                                if item.image != ""{
                                    WebImage(url: URL(string: item.wrappedImage)!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 170)
                                        .background(Image("loader")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 60, height: 30))
                                        .cornerRadius(10)
                                }
                                else{
                                    Image("loader")
                                        .resizable()
                                        .frame(width: 120, height: 170)
                                        .cornerRadius(10)
                                }
                                
                                VStack(alignment: .leading, spacing: 10){
                                    Text(item.wrappedTitle).fontWeight(.bold)
                                    
                                    Text(item.wrappedDesc).font(.caption)
                                        .lineLimit(4)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                        }
                    }.onDelete(perform: deleteMealList)
                }
            }
            .navigationBarTitle(Text("Favorite News"))
        }
    }
    private func deleteMealList(at offsets: IndexSet){
        for index in offsets{
            let favorite = favoriteMeal[index]
            moc.delete(favorite)
            
            do{
                try moc.save()
                
            } catch{
                print(error)
            }
        }
    }
}
