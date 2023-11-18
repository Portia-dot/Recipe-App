//
//  SettingsView.swift
//  Recipe App
//
//  Created by Oluwayomi M on 2023-11-10.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20){
                Text("V.1.1")
                    .font(.caption)
                    .foregroundColor(.green)
                    .bold()
                    .navigationTitle("Settings")
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.green)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
