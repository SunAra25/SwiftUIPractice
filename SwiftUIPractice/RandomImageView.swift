//
//  RandomImageView.swift
//  SwiftUIPractice
//
//  Created by 아라 on 9/4/24.
//

import SwiftUI

struct Section {
    let id = UUID()
    var title: String
}
struct RandomImageView: View {
    @State private var number = 0
    @State private var title = [Section(title: "첫 번째"),
                                Section(title: "두 번째"),
                                Section(title: "세 번째"),
                                Section(title: "네 번째")]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach($title, id: \.id) { item in
                    VStack(alignment: .leading) {
                        Text(item.title.wrappedValue)
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(0..<10) { _ in
                                    let random = Int.random(in: 0...100)
                                    imageView(number: random)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    func imageView(number: Int) -> some View {
        AsyncImage(url: URL(string: "https://picsum.photos/id/\(number)/200/300")) { result in
            switch result {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .frame(width: 150, height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            case .failure:
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
}


struct ImageDetailView: View {
    @Binding var title: String
    
    var body: some View {
        VStack {
           
            TextField("Title", text: $title)
        }
        .padding()
    }
}

#Preview {
    RandomImageView()
}
