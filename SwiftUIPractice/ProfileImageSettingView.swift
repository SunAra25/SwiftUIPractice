//
//  ProfileImageSettingView.swift
//  SwiftUIPractice
//
//  Created by 아라 on 9/2/24.
//

import SwiftUI

struct ProfileImageSettingView: View {
    @Binding var imageNum: Int
    
    var body: some View {
        VStack {
            Image("profile_\(imageNum)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(.blue, lineWidth: 4)
                )
                .overlay(alignment: .bottomTrailing, content: {
                    Image(systemName: "camera")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                        .fontWeight(.bold)
                        .padding(8)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Circle())
                })
                .padding(.bottom)
                .padding(.vertical)
            
            ForEach(0..<3) { i in
                HStack {
                    ForEach(0..<4) { j in
                        ProfileImageView(selectedImg: $imageNum, imageNum: i * 4 + j)
                            .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
                    }
                }
            }
            
            Spacer()
        }
        .navigationTitle("PROFILE SETTING")
        .navigationBarTitleDisplayMode(.inline)
        .accentColor(.black)
    }
}

struct ProfileImageView: View {
    @Binding private var selectedImg: Int
    private let imageNum: Int
    
    init(selectedImg: Binding<Int>, imageNum: Int) {
        self._selectedImg = selectedImg
        self.imageNum = imageNum
    }
    
    var body: some View {
        Button {
            selectedImg = imageNum
        } label: {
            Image("profile_\(imageNum)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(selectedImg == imageNum ? .blue : .gray, lineWidth: 2)
                )
                .opacity(selectedImg == imageNum ? 1.0 : 0.5)
        }
    }
}

//#Preview {
//    ProfileImageSettingView()
//}
