//
//  busData.swift
//  final_00757128
//
//  Created by User18 on 2020/12/18.
//
import Foundation

struct busRoute : Codable/*, Identifiable*/{
    //var id = UUID()
    let RouteUID : String?
    let RouteID : String?
    //let DepartureStopNameZh : String?
    //let DestinationStopNameZh : String?
    //let TicketPriceDescriptionZh : String?
    let RouteName: Name?
}

struct Name: Codable {
    let Zh_tw, En: String
}

struct positionCoordinate : Codable {
    let PositionLat, PositionLon: Double
}

struct BusRouteResponse: Codable {
   //let resultCount: Int
   let array: [busRoute]?
}

struct busRouteStops : Codable {
    let RouteUID : String?
    let RouteID : String?
    let RouteName : Name?
    let Direction : Int?
    let StopName : Name?
    let StopUID : String?
    let EstimateTime : Int?
}

struct busStopData : Codable {
    let StopUID : String?
    let StopName : Name?
    let StopPosition : positionCoordinate?
}

struct busRouteStopsResponse : Codable {
    let array: [busRouteStops]?
}
