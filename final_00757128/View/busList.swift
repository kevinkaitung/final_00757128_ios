//
//  busList.swift
//  final_00757128
//
//  Created by User18 on 2020/12/18.
//

import SwiftUI



struct busList: View {
    @StateObject var BusListViewModel = busListViewModel()
    let detailOfTourBus : TourAttractionStruct
    
    var body: some View {
        VStack{
            List(BusListViewModel.busRoutes2.indices, id: \.self) { (index)  in
                NavigationLink(destination: busEstimateArrival(busUId: (BusListViewModel.busRoutes2[index].first)!.RouteUID, stopuid: "KEE10")) {
                    busRow(busDetail: (BusListViewModel.busRoutes2[index].first)!)
                }
            }
            .onAppear(perform: {
                if BusListViewModel.busRoutes2.isEmpty {
                BusListViewModel.fetchData(passR: detailOfTourBus.passRoute)
                }
            })
            .navigationTitle("經過路線")
        }
    }
}

struct busList_Previews: PreviewProvider {
    static var previews: some View {
        busList(detailOfTourBus: tourAttractions[0])
    }
}
