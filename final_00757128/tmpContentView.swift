//
//  tmpContentView.swift
//  final_00757128
//
//  Created by User18 on 2020/12/19.
//

import SwiftUI
import MapKit

struct tmpContentView: View {
    let travelhistory = travelHistory()
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        TabView {
            tourPage()
                .tabItem {
                    Image(systemName: "leaf")
                    Text("旅遊景點")
                }
            photoSelection()
                .tabItem {
                    Image(systemName: "circle")
                    Text("旅遊紀錄")
                }
            favoriteTourAttractions()
                .tabItem {
                    Image(systemName: "heart")
                    Text("最愛")
                }
        }
        .environmentObject(travelhistory)
    }
}

struct tmpContentView_Previews: PreviewProvider {
    static var previews: some View {
        tmpContentView()
    }
}
