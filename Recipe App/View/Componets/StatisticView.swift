//
//  StatisticView.swift
//  Recipe App
//
//  Created by Oluwayomi M on 2023-11-11.
//

import SwiftUI

struct StatisticView: View {
    var name: String
    var current: Double
    var goal: Double?
    var body: some View {
        VStack{
            Text(name)
                .font(.caption)
                .foregroundColor(.green)
            ZStack{
                Circle()
                    .stroke(lineWidth: 7)
                    .opacity(0.3)
                    .foregroundColor(color(for: name))
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(Double(current) / Double(goal ?? 0), 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round))
                    .foregroundColor(color(for: name))
                    .rotationEffect(Angle(degrees: 270))
                Text("\(current, specifier: "%.1f")\(goal != nil ? "/ \(goal!)" : "")")
                    .font(.caption)
                    .foregroundColor(color(for: name))
            }
            .frame(width: 60, height: 60)
        }
    }
    private func color(for name: String) -> Color{
        switch name {
        case "Fat":
            return Color.orange
        case "Protein":
            return Color.green
        case "Carbs":
            return Color.blue
        default:
            return Color.gray
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(name: "Fat", current: 10, goal: 100)
    }
}
