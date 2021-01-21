//
//  tourPage.swift
//  00757128_final
//
//  Created by User18 on 2020/12/13.
//

import SwiftUI

struct tourPage: View {
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: NSLocalizedString("find place", comment: ""))
                List(tourAttractions.filter({searchText.isEmpty ? true : $0.name.contains(searchText)}), id: \.name) { (TourAttractionStruct) in
                    NavigationLink(destination: tourDetail(detailOfTour : TourAttractionStruct)) {
                        Image(TourAttractionStruct.name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 60)
                        .clipped()
                        Text(TourAttractionStruct.name)
                    }
                }
            }
            .navigationTitle("旅遊景點導覽")
        }
    }
}

struct tourPage_Previews: PreviewProvider {
    static var previews: some View {
        tourPage()
    }
}
