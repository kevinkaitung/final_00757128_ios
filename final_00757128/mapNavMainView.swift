//
//  mapNavMainView.swift
//  final_00757128
//
//  Created by User06 on 2021/1/6.
//

import SwiftUI
import MapKit
import CryptoKit

struct mapNavMainView: View {
    @Binding var showMap:Bool
    @State var busstopuid : String
    @State var busStop = [busStopData]()
    
    func fetchStopData(stopUID: String) {
        let query = "https://ptx.transportdata.tw/MOTC/v2/Bus/Stop/City/Keelung?$filter=StopUID eq \'" + stopUID + "\'&$top=100&$format=JSON"
        let urlStr = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let url = URL(string: urlStr!) {
            let appId = "b7456197365c4eceb2b309a01e56a063"
            let appKey = "PinSPp69yMT7PoczN42w_nOxspc"
            let xdate = getTimeString()
            let signDate = "x-date: \(xdate)"
            let key = SymmetricKey(data: Data(appKey.utf8))
            let hmac = HMAC<SHA256>.authenticationCode(for: Data(signDate.utf8), using: key)
            let base64HmacString = Data(hmac).base64EncodedString()
            let authorization = """
            hmac username="\(appId)", algorithm="hmac-sha256", headers="x-date", signature="\(base64HmacString)"
            """
            var request = URLRequest(url: url)
            request.setValue(xdate, forHTTPHeaderField: "x-date")
            request.setValue(authorization, forHTTPHeaderField: "Authorization")
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                            let searchResponse = try! decoder.decode([busStopData].self, from: data)
                            print(searchResponse)
                            self.busStop = searchResponse
                            coordinate = CLLocationCoordinate2D(latitude: busStop.first?.StopPosition?.PositionLat ?? 0, longitude: busStop.first?.StopPosition?.PositionLon ?? 0)
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    @State var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 25.1505994, longitude: 121.7790957)
    
    var body: some View {
        VStack {
            mapView(coordinate:$coordinate, stopName: busStop.first?.StopName?.Zh_tw)
            Button(action: {showMap = false}, label: {
                Text("關閉頁面")
            })
        }
        .onAppear {
            self.fetchStopData(stopUID: busstopuid)
        }
    }
}
