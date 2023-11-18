//
//  SearchView.swift
//  Recipe App
//
//  Created by Oluwayomi M on 2023-11-10.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationView {
            Text("Categories")
                .navigationTitle("Category")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
