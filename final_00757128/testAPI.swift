//
//  testAPI.swift
//  final_00757128
//
//  Created by User18 on 2020/12/23.
//

import SwiftUI
import CryptoKit
import Foundation



struct testAPI: View {
    
    func getTimeString() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "EEE, dd MMM yyyy HH:mm:ww zzz"
        dateFormater.locale = Locale(identifier: "en_US")
        dateFormater.timeZone = TimeZone(secondsFromGMT: 0)
        let time = dateFormater.string(from: Date())
        return time
    }

    
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
        let url = URL(string: "https://ptx.transportdata.tw/MOTC/v2/Rail/THSR/Station?$top=30&$format=JSON")!
        var request = URLRequest(url: url)
        request.setValue(xdate, forHTTPHeaderField: "x-date")
        request.setValue(authorization, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let content = String(data: data, encoding: .utf8) ?? ""
                print("bbbbb")
                print(content)
            } else {
                print("aaaaa")
            }
        }.resume()
    }
    var body: some View {
        Text("Hello, World!").onAppear(perform: {
            fetch()
        })
    }
}

struct testAPI_Previews: PreviewProvider {
    static var previews: some View {
        testAPI()
    }
}
