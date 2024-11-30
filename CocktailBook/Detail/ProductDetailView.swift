//
//  ProductDetailView.swift
//  CocktailBook
//
//  Created by Sujoy Adhikary on 28/11/24.
//


import SwiftUI


struct ProductDetailView: View {
    
    @ObservedObject var viewModel : ProductDetailViewModel
    var onFavoriteToggle:(CocktailDataModelResponse) -> Void
    
    
    var body: some View {
        
        let product = viewModel.product
        
        
        ScrollView{
            LazyVStack(spacing: 8){
                LazyVStack(alignment: .leading,spacing: 2) {
                    //cocktail name
                    Text(product.name)
                        .font(.system(size: 34, weight: .bold))
                    
                    HStack(spacing: 0){
                        //preparation time image
                        Image(systemName: LocalImage.clock)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray)
                        
                        //preparation time text
                        Text("\(product.preparationMinutes) \(LocalString.minutes)")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .bold))
                    }
                    .padding(.leading, -4)
                }
                .padding(.horizontal, 20)
                
                //image
                Image(product.imageName)
                    .resizable(resizingMode: .stretch)
                    .frame(height: 300)
                //Description
                Text(product.longDescription)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                    .padding(.horizontal,30)
                
                
                LazyVStack(alignment: .leading){
                    //ingredients heading
                    Text(LocalString.ingredients)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 20)
                    //Ingredients list
                    ForEach(product.ingredients, id: \.self) { ingredient in
                        HStack{
                            Image(systemName: LocalImage.playFill)
                                .foregroundColor(.gray)
                                .frame(width: 10, height: 10)
                            Text(ingredient)
                                .font(.system(size: 16, weight: .medium))
                                .padding(.leading, 8)
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                
            }
            .padding(.bottom,30)
            .toolbar {
                let isFavorite = product.isFavorite ?? false
                //Favourite Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        withAnimation(.bouncy) {viewModel.favoriteButtonTapped()}
                    }label: {
                        Image(systemName: isFavorite ? LocalImage.heartFill : LocalImage.heart)
                            .foregroundStyle(isFavorite ? Color.Custom.isFavorite : .gray)
                    }
                }
            }
            .onDisappear{
                //calling the closure to update the favourite status
                onFavoriteToggle(viewModel.product)
            }
        }
    }
}


#Preview {
    NavigationView{
        ProductDetailView(viewModel: .init(product: CocktailDataModelResponse.itemMojito), onFavoriteToggle: { _ in })
    }
}
