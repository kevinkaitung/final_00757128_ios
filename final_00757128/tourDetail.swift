//
//  tourDetail.swift
//  00757128_final
//
//  Created by User18 on 2020/12/13.
//

import SwiftUI
import CoreData

struct tourDetail: View {
    let detailOfTour : TourAttractionStruct
    @EnvironmentObject var travelhistory: travelHistory
    @State private var show = false
    //@State private var beenHere = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.name = detailOfTour.name
            newItem.info = detailOfTour.info
            newItem.nearStop = detailOfTour.nearStop
            newItem.passRoute = detailOfTour.passRoute
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    
    var body: some View {
        VStack {
            if show {
                detailOfTourImage(detailOfTourImg: detailOfTour)
                    .transition(.scale)
            }
            Text(detailOfTour.info)
                .padding()
            //if beenHere {
            List {
                Button(action: {
                    addItem()
                    travelhistory.tourTime+=1
                    //beenHere = false
                }, label: {
                    Text("加到最愛")
                })
                .font(.system(size: 20))
                .foregroundColor(.red)
                .padding()
                .background(Color.yellow)
                .cornerRadius(90)
                Text("我的最愛："+String(travelhistory.tourTime))
                NavigationLink(destination: busList(detailOfTourBus: detailOfTour)) {
                    Text("經過公車站："+detailOfTour.nearStop)
                }
                
            }
            
        }
        .animation(.easeInOut(duration: 1.5))
        .onAppear {
            self.show = true
        }
        .navigationTitle(detailOfTour.name)
    }
}

struct tourDetail_Previews: PreviewProvider {
    static var previews: some View {
        tourDetail(detailOfTour: tourAttractions[0])
            .environmentObject(travelHistory())
    }
}

struct detailOfTourImage: View {
    let detailOfTourImg: TourAttractionStruct
    var body: some View {
        Image(detailOfTourImg.name)
            .resizable()
            .scaledToFill()
            .frame(width: 260, height: 180, alignment: .center)
            .clipped()
    }
}
