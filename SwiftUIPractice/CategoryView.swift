//
//  CategoryView.swift
//  SwiftUIPractice
//
//  Created by 아라 on 9/4/24.
//

import SwiftUI

struct Category: Hashable {
    let id = UUID()
    let name: String
    let count: Int
}

struct CategoryView: View {
    @State private var genre = ["로맨스", "스릴러", "호러", "SF", "애니매이션",
    "다큐멘터리", "미스터리"]
    @State private var recentlyGenre = "장르를 추가해보세요"
    @State private var addGenre: [Category] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    CategoryPresentView(text: recentlyGenre)
                    LazyVStack {
                        ForEach($addGenre, id: \.self) { item in
                            CategoryRowView(genre: item)
                        }
                    }
                }
                .toolbar {
                    Button {
                        let new = Category(name: genre.randomElement() ?? "띠용", count: Int.random(in: 0...100))
                        addGenre.append(new)
                        recentlyGenre = "new! \(new.name)"
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct CategoryPresentView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.title)
    }
}

struct CategoryRowView: View {
    @Binding var genre: Category
    
    var body: some View {
        HStack {
            Text(genre.name)
            Spacer()
            Text(genre.count.formatted())
        }
        .padding()
    }
}

#Preview {
    CategoryView()
}
