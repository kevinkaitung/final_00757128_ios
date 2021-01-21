//
//  busTimeRow.swift
//  final_00757128
//
//  Created by User18 on 2021/1/2.
//

import SwiftUI

struct busTimeRow: View {
    var busTimeDetail : busRouteStops
    var body: some View {
        HStack {
            Text(busTimeDetail.StopName!.Zh_tw)
            Spacer()
            if busTimeDetail.EstimateTime != nil {
                Text(String(busTimeDetail.EstimateTime! / 60)+"分")
            }
            else {
                Text("未發車")
            }
        }
    }
}

/*struct busTimeRow_Previews: PreviewProvider {
    static var previews: some View {
        busTimeRow()
    }
}*/
