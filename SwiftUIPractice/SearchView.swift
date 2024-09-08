//
//  SearchView.swift
//  SwiftUIPractice
//
//  Created by 아라 on 9/4/24.
//

import SwiftUI

struct SearchView: View {
    @State private var input: String = ""
    @State private var filterList: Markets = []
    @State private var markets: Markets = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach($filterList, id: \.self) { item in
                        NavigationLink {
                            NavigationLazyView(CoinDetailView(data: item))
                        } label: {
                            CoinRow(item: item)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .navigationTitle(Text("Search"))
                .searchable(text: $input, prompt: Text("Search"))
                .onSubmit(of: .search) {
                    filterList = markets.filter {$0.koreanName.contains(input)}
                }
                .onChange(of: input) { _, newValue in
                    if !newValue.isEmpty {
                        // 실시간 검색이 필요하면 이곳에서 하면 될 듯
                        return
                    }
                    
                    filterList = markets
                }
            }
        }
        .task {
            do {
                markets = try await CoinAPI.fetchMarket()
                filterList = markets
            } catch {
                print("error")
            }
        }
    }
    
}

private struct CoinRow: View {
    @Binding var item: Market
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 48, height: 48)
            
            VStack(alignment: .leading) {
                Text(item.koreanName)
                    .font(.title3)
                Text(item.englishName)
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

struct CoinDetailView: View {
    @Binding var data: Market
    
    var body: some View {
        VStack {
            Text(data.koreanName)
                .font(.title)
            Text(data.englishName)
        }
        .navigationTitle(Text(data.market))
    }
}
#Preview {
    SearchView()
}
