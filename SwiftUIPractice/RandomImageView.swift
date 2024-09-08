//
//  RandomImageView.swift
//  SwiftUIPractice
//
//  Created by 아라 on 9/4/24.
//

import SwiftUI

struct Section: Hashable, Identifiable {
    let id = UUID()
    var title: String
}
struct RandomImageView: View {
    @State private var number = 0
    @State private var title = [Section(title: "첫 번째"),
                                Section(title: "두 번째"),
                                Section(title: "세 번째"),
                                Section(title: "네 번째")]
    
    init() {
        print("랜덤 이닛")
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach($title, id: \.id) { item in
                    VStack(alignment: .leading) {
                        SectionView(item: item)
                    }
                    .padding()
                }
            }
        }
    }
    
}

struct ImageView: View {
    let number: Int
    
    init(number: Int) {
        self.number = number
    }
    
    var body: some View {
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
struct NavigationLazyView<Content: View>: View {
    let closure: () -> Content
    
    init(_ closure: @autoclosure @escaping () -> Content) {
        self.closure = closure
    }
    
    var body: some View {
        closure()
    }
}

struct SectionView: View {
    @Binding var item: Section
    
    var body: some View {
        Text($item.title.wrappedValue)
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<10) { _ in
                    let random = Int.random(in: 0...100)
                    let image = ImageView(number: random)
                    NavigationLink {
                        NavigationLazyView(
                        ImageDetailView(title: $item.title,
                                        imageView: image))
                    } label: {
                        image
                    }
                }
            }
        }
    }
}

struct ImageDetailView: View {
    @Binding var title: String
    let imageView: ImageView
    
    var body: some View {
        VStack {
            imageView
            TextField("Title", text: $title)
        }
        .padding()
    }
}

#Preview {
    RandomImageView()
}
