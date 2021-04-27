//
//  MealList.swift
//  MealAPI
//
//  Created by MACBOOK on 19/04/21.
//

import SwiftUI
import SDWebImageSwiftUI


struct MealList: View {
    @ObservedObject var mealViewModel = MealViewModel()
    
    
    var body: some View {
        NavigationView{
            List(mealViewModel.data){ item in
                NavigationLink(destination: MealDetail(meal: item)){
                    HStack{
                        //jika fotonya ada
                        if item.image != ""{
                            WebImage(url: URL(string: item.image)!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 170)
                                .background(Image("loader")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 60, height: 30))
                                .cornerRadius(10)
                        }
                        else {
                            Image("loader")
                                .resizable()
                                .frame(width: 120, height: 170)
                                .cornerRadius(10)
                        }
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text(item.title).fontWeight(.bold)
                            
                            Text(item.description).font(.caption)
                                .lineLimit(4)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Meal"))
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
