//
//  TabBar.swift
//  Recipe App
//
//  Created by Oluwayomi M on 2023-11-10.
//

import SwiftUI

struct TabBar: View {
    @State private var selection = 1
    var body: some View {
        VStack {
                    switch selection {
                    case 1:
                        HomeView()
                    case 2:
                        SearchView()
                    case 3:
                        NewRecepieView()
                    case 4:
                        FavoriteView()
                    case 5:
                        SettingsView()
                    default:
                        Text("Selection does not correspond to a tab")
                    }
                    
                    Spacer()
                    CustomTabView(tabSelection: $selection)
                }
            }
        
    }
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
