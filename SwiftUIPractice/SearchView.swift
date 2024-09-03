//
//  SearchView.swift
//  SwiftUIPractice
//
//  Created by 아라 on 9/4/24.
//

import SwiftUI

struct Coin: Hashable {
    let title: String
    let market: String
    var isLike: Bool = false
}

struct SearchView: View {
    @State private var input: String = ""
    @State private var coinList = [Coin(title: "Bitcoin", market: "BTC"),
    Coin(title: "Ethereum", market: "ETH"),
    Coin(title: "Ripple", market: "XRP"),
    Coin(title: "Ravencoin", market: "RVN")]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach($coinList, id: \.self) { item in
                        CoinRow(item: item)
                    }
                }
                .navigationTitle(Text("Search"))
                .searchable(text: $input, prompt: Text("Search"))
            }
        }
    }
    
}

private struct CoinRow: View {
    @Binding var item: Coin
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 48, height: 48)
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.title3)
                Text(item.market)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Button {
                item.isLike.toggle()
            } label: {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(item.isLike ? .primary : .quaternary)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 6)
    }
}
#Preview {
    SearchView()
}
