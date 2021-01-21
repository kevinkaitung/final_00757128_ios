//
//  busListViewModel.swift
//  final_00757128
//
//  Created by User18 on 2020/12/18.
//

import Foundation
import CryptoKit

func getTimeString() -> String {
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "EEE, dd MMM yyyy HH:mm:ww zzz"
    dateFormater.locale = Locale(identifier: "en_US")
    dateFormater.timeZone = TimeZone(secondsFromGMT: 0)
    let time = dateFormater.string(from: Date())
    return time
}


class busListViewModel: ObservableObject {
    
    @Published var busRoutes = [busRoute]()
    @Published var busRoutes2 = [[busRoute]]()

    
    func fetch() {
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
        let url = URL(string: "https://ptx.transportdata.tw/MOTC/v2/Bus/StopOfRoute/City/Keelung/103?$top=30&$format=JSON")!
        var request = URLRequest(url: url)
        request.setValue(xdate, forHTTPHeaderField: "x-date")
        request.setValue(authorization, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    self.busRoutes = try decoder.decode([busRoute].self, from: data)
                    print(self.busRoutes)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func fetchData(passR: [String]) {
        
        
        for i in 0..<passR.count {
            let query = "https://ptx.transportdata.tw/MOTC/v2/Bus/StopOfRoute/City/Keelung/" + passR[i] + "?$top=30&$format=JSON"
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
                            DispatchQueue.main.async {
                                self.busRoutes2.append(try! decoder.decode([busRoute].self, from: data))
                            }
                            //print(self.busRoutes2[i])
                        } catch {
                            print(error)
                        }
                    }
                }.resume()
            }
        }
    }
    
    /*func fetchData(passR: [String]) {
     
     for i in 1..<passR.count {
     if let urlStr = "    https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/Keelung/\(passR[i])?$top=30&$format=JSON".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
     URLSession.shared.dataTask(with: url) { (data, response ,error) in
     let decoder = JSONDecoder()
     decoder.dateDecodingStrategy = .iso8601
     if let data = data {
     self.busRoutes = try! JSONDecoder().decode([busRoute].self, from: data)
     }
     }.resume()
     }
     }
     }*/
    /*func fetchData() {
        if let urlStr = "https://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/Keelung/103?$top=30&$format=JSON".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { [self] (data, response ,error) in
                let decoder = JSONDecoder()
                if let data = data,
                   let busRouteResults = try?
                    decoder.decode(BusRouteResponse.self, from: data) {
                    //busRoutes = busRouteResults.array
                }
            }.resume()
        }
    }*/
}
