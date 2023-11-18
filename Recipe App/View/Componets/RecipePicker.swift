//
//  Picker.swift
//  Recipe App
//
//  Created by Oluwayomi M on 2023-11-11.
//

import SwiftUI

struct RecipePicker: View {
    typealias MealType = RecipeViewModel.MealType
    
    @Binding var selectedMealType :MealType
    @Binding var isPresented: Bool
    var body: some View {
        
        
        NavigationView {
            VStack {
                ForEach(MealType.grouped, id: \.self) { group in
                    HStack {
                        ForEach(group, id: \.self) { mealType in
                            Picker(selection: $selectedMealType, label: Text(mealType.rawValue.capitalized)) {
                                Text(mealType.rawValue.capitalized).tag(mealType)
                            }
                            .pickerStyle(.segmented)
                            .background(selectedMealType == mealType ? Color.white : Color.clear)
                            .cornerRadius(10)
                            .shadow(color: selectedMealType == mealType ? .gray : .clear, radius: 3)
                                                .onTapGesture {
                                                    selectedMealType = mealType
                                                }
                            
                        }
                       
                    }
                }.padding()
            }.navigationBarItems(trailing: Button("Done"){
                isPresented = false
            })
        .navigationBarTitle(Text("Select Meal Type"), displayMode: .inline)
        }
    }
}

extension RecipeViewModel.MealType {
    static var grouped: [[RecipeViewModel.MealType]] {
        let allTypes = RecipeViewModel.MealType.allCases
        let groupSize = 3
        return stride(from: 0, to: allTypes.count, by: groupSize).map {
            Array(allTypes[$0..<min($0 + groupSize, allTypes.count)])
        }
    }
}

struct RecipePicker_Previews: PreviewProvider {
    @State static var selectedMealType = RecipePicker.MealType.mainCourse
     @State static var isPresent = true
    static var previews: some View {
        RecipePicker(selectedMealType: $selectedMealType, isPresented: $isPresent)
    }
}


