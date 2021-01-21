//
//  busRow.swift
//  final_00757128
//
//  Created by User18 on 2020/12/18.
//

import SwiftUI

struct busRow: View {
    let busDetail: busRoute
    var body: some View {
        HStack {
            VStack {
                Text(busDetail.RouteUID!)
                Text(busDetail.RouteID!)
            }
            //Text(busDetail.DepartureStopNameZh! + "-")
            //Text(busDetail.DestinationStopNameZh!)
            Text(busDetail.RouteName!.Zh_tw)
        }
    }
}

/*struct busRow_Previews: PreviewProvider {
    static var previews: some View {
        busRow()
    }
}*/
