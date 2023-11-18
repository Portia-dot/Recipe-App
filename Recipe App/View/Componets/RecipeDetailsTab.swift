//
//  RecipeDetailsTab.swift
//  Recipe App
//
//  Created by Oluwayomi M on 2023-11-13.
//

import SwiftUI
import WebKit

struct RecipeDetailsTab: View {
    enum Tab{
        case ingredients , instruction
    }
    @State private var selectedTab  :Tab = .ingredients
    @State private var webViewHeight: CGFloat = .zero
    var ingredients : [String]
    var instruction: String
    
    init(ingredients: [String], instruction: String) {
        self.ingredients = ingredients
        self.instruction = instruction
        let appearance = UISegmentedControl.appearance()
        appearance.backgroundColor = UIColor.green.withAlphaComponent(0.15)
        appearance.selectedSegmentTintColor = .green
        appearance.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        appearance.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        print("Ingredients: \(ingredients)")
    }
    
    var body: some View {
        VStack{
            Picker("Select", selection: $selectedTab){
                Text("Ingredients").tag(Tab.ingredients)
                Text("Instruction").tag(Tab.instruction)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Group {
                if selectedTab == .ingredients{
                    
                    ScrollView {
                        ForEach(ingredients, id: \.self) { ingredient in
                            
                            VStack(alignment: .leading) {
                                Text(ingredient)
                                    .padding(.horizontal)
                                    .bold()
                                Divider()
                            }
                        }
                    }

                } else {
                    if instruction.isEmpty {
                        Text("No Instruction Avaliable")
                            .padding()
                    }else{
                        ScrollView {
                            if instruction.isHTML{
                                WebView(htmlContent: instruction, dynamicHeight: $webViewHeight)
                                    .padding()
                                    .foregroundColor(.black)
                                    .font(.caption)
                                    .bold()
                            } else {
                                Text(instruction)
                                    .padding()
                            }
                        }
                    }
                    
                }
            }
        }
        
    }
    
    

}

struct RecipeDetailsTab_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsTab(ingredients: ["Mage", "MM"], instruction: "Yello")
    }
}






extension String {
    var isHTML: Bool {
        return self.contains("<") && self.contains(">")
    }
}
