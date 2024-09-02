//
//  OnboardingView.swift
//  SwiftUIPractice
//
//  Created by 아라 on 9/2/24.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello,\nMy Polaloid")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundStyle(.blue)
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(.gray.opacity(0.3))
                    .frame(width: 300, height: 300)
                    .padding()
                    
                
                NavigationLink {
                    
                } label: {
                    Text("시작하기")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, maxHeight: 56)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                        .padding()
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
