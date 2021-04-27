//
//  SearchList.swift
//  MealAPI
//
//  Created by MACBOOK on 23/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchList: View {
    
    @ObservedObject var searchViewModel = SearchViewModel()
    
    
    var body: some View {
        
        NavigationView{
            VStack{
                HStack(spacing: 15){
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $searchViewModel.search)
                    
            }
                
                .padding(.horizontal)
                .padding(.top, 10)
                
                if searchViewModel.meal.isEmpty{
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    List(searchViewModel.mealFiltered){ item in
                        NavigationLink(destination: MealDetail(meal: item)){
                            HStack{
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
                                else{
                                    Image("loader")
                                        .resizable()
                                        .frame(width: 120, height: 170)
                                        .cornerRadius(10)
                                }
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(item.title).fontWeight(.bold)
                                    
                                    Text(item.description).font(.caption)
                                        .lineLimit(4)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                        }
                    }
                }
        }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
    }
        .navigationViewStyle(StackNavigationViewStyle())
        .onChange(of: searchViewModel.search, perform: { value in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                if value == searchViewModel.search && searchViewModel.search != ""{
                    searchViewModel.filterMeal()
                }
            }
            if searchViewModel.search == ""{
                withAnimation(.linear){
                    searchViewModel.mealFiltered = searchViewModel.meal
                }
            }
        })
        
}
}

