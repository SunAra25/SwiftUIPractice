//
//  NicknameSettingView.swift
//  SwiftUIPractice
//
//  Created by 아라 on 9/2/24.
//

import SwiftUI

struct NicknameSettingView: View {
    @State private var imgNumber = Int.random(in: 0...11)
    @State private var nicknameInput = ""
    @State private var mbti = [[false, false],
                        [false, false],
                        [false, false],
                        [false, false]]
    
    private var isActive: Bool {
        for type in mbti {
            if !type.contains(true) {
                return false
            }
        }
        
        return !nicknameInput.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    
                } label: {
                    Image("profile_\(imgNumber)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 60))
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(.blue, lineWidth: 4)
                        )
                        .overlay(alignment: .bottomTrailing, content: {
                            Image(systemName: "camera")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .padding(8)
                                .background(.blue)
                                .foregroundStyle(.white)
                                .clipShape(Circle())
                        })
                        .padding()
                }
                
                TextField("nickname", text: $nicknameInput, prompt: Text("닉네임을 입력해주세요 :>"))
                    .padding()
                
                HStack(alignment: .top) {
                    Text("MBTI")
                        .font(.title3)
                        .fontWeight(.black)
                    
                    Spacer()
                    
                    MBTIView(mbti: $mbti)
                }
                .padding()
                
                Spacer()
                
                NavigationLink {
                    
                } label: {
                    Text("완료")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, maxHeight: 56)
                        .background(isActive ? .blue : .gray)
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                        .padding()
                }
                .disabled(!isActive)
            }
            .navigationTitle("PROFILE SETTING")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct MBTIView: View {
    @Binding var mbti: [[Bool]]
    
    var body: some View {
        VStack {
            ForEach(MBTI.Energy.allCases, id: \.self) { item in
                let index = item.rawValue
                mbti(item.type, index: IndexPath(row: index, section: 0))
            }
        }
        
        VStack {
            ForEach(MBTI.Information.allCases, id: \.self) { item in
                let index = item.rawValue
                mbti(item.type, index: IndexPath(row: index, section: 1))
            }
        }
        
        VStack {
            ForEach(MBTI.DecisionMaking.allCases, id: \.self) { item in
                let index = item.rawValue
                mbti(item.type, index: IndexPath(row: index, section: 2))
            }
        }
        
        VStack {
            ForEach(MBTI.Lifestyle.allCases, id: \.self) { item in
                let index = item.rawValue
                mbti(item.type, index: IndexPath(row: index, section: 3))
            }
        }
    }
    
    func mbti(_ title: String, index: IndexPath) -> some View {
        Button {
            mbti[index.section][index.row].toggle()
            
            if !mbti[index.section].contains(false) {
                let row = index.row
                mbti[index.section][row == 0 ? 1 : 0] = false
            }
        } label: {
            Text(title)
                .padding()
                .frame(width: 48, height: 48)
                .foregroundColor(mbti[index.section][index.row] ? .white : .gray)
                .background(mbti[index.section][index.row] ? .blue : .white)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(mbti[index.section][index.row] ? .blue : .gray, lineWidth: 2)
                )
        }
//        .buttonBorderShape(.circle)
    }
}

#Preview {
    NicknameSettingView()
}

enum MBTI {
    enum Energy: Int, CaseIterable {
        case extraversion
        case introversion
        
        var type: String {
            switch self {
            case .extraversion: "E"
            case .introversion: "I"
            }
        }
    }
    
    enum Information: Int, CaseIterable {
        case sensing
        case intuition
        
        var type: String {
            switch self {
            case .sensing: "S"
            case .intuition: "N"
            }
        }
    }
    
    enum DecisionMaking: Int, CaseIterable {
        case thinking
        case feeling
        
        var type: String {
            switch self {
            case .thinking: "T"
            case .feeling: "F"
            }
        }
    }
    
    enum Lifestyle: Int, CaseIterable {
        case judging
        case perception
        
        var type: String {
            switch self {
            case .judging: "J"
            case .perception: "P"
            }
        }
    }
}
