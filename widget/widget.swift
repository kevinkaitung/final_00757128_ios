//
//  widget.swift
//  widget
//
//  Created by User18 on 2021/1/2.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), imgNum: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), imgNum: nil)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        let number = Int.random(in: 1...3)
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate, imgNum: number)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .after(currentDate.addingTimeInterval(60))); completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    @State var imgNum: Int?
}

struct widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.date, style: .time)
            Image(String(entry.imgNum ?? 2))
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
        
        }
    }
}

@main
struct widget: Widget {
    let kind: String = "widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            widgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct widget_Previews: PreviewProvider {
    static var previews: some View {
        widgetEntryView(entry: SimpleEntry(date: Date(), imgNum: nil))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
