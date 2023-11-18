//
//  CustomTabView.swift
//  Recipe App
//
//  Created by Oluwayomi M on 2023-11-13.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var tabSelection: Int
    @Namespace private var animationNameSpace
    
    let tabBarItems:[(image: String, title: String)] = [
    ("house", "Home"),
    ("magnifyingglass", "Search"),
    ("plus", "Add"),
    ("heart", "Favorites"),
    ("gear", "Setting")
    
    ]
    var body: some View {
        ZStack{
            Capsule()
                .frame(height: 80)
                .foregroundColor(Color(.secondarySystemBackground))
                .shadow(radius: 2)
            
            HStack{
                ForEach(0..<5){ index in
                    Button{
                        tabSelection = index + 1
                    } label: {
                        VStack(spacing: 8) {
                            Spacer()
                            Image(systemName: tabBarItems[index].image)
                            Text(tabBarItems[index].title)
                                .font(.caption)
                                .foregroundColor(.green)
                                .bold()
                            
                            //Conditional Statement
                            if index + 1 == tabSelection{
                                Capsule()
                                    .frame(height: 8)
                                    .foregroundColor(.green)
                                    .matchedGeometryEffect(id: "selectedTabId", in: animationNameSpace)
                                    .offset(y: 3)
                            } else {
                                Capsule()
                                    .frame(height: 8)
                                    .foregroundColor(.clear)
                                    .offset(y: 3)
                                
                            }
                        }
                        .foregroundColor(index + 1 == tabSelection ? .green : .gray)
                    }
                }
            }
            .frame(height: 80)
            .clipShape(Capsule())
        }
        .padding(.horizontal)
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(tabSelection: .constant(0))
            .previewLayout(.sizeThatFits)
            .padding(.vertical)
    }
}
