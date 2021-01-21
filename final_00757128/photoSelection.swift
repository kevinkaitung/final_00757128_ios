//
//  photoSelection.swift
//  final_00757128
//
//  Created by User18 on 2020/12/19.
//

import SwiftUI

struct photoSelection: View {
    @State private var image = Image(systemName: "photo")
    @State private var showSelectPhoto = false
    @State private var showPhotoPicker = false
    var uiviewController: UIActivityViewController?
            
    var body: some View {
        VStack {
            Text("PhotoSeletion")
            Button(action: {uiviewController!.share()}, label: {
                Text("share")
            })
            Button(action: {showSelectPhoto=true}, label: {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width:200, height:200)
                    .onAppear() {
                        //讀出照片
                        let documentsDirectory =
                        FileManager.default.urls(for: .documentDirectory,
                        in: .userDomainMask).first!
                        let imageUrl =
                        documentsDirectory.appendingPathComponent("savedPhoto")
                        if let img = UIImage(contentsOfFile: imageUrl.path) {
                            image = Image(uiImage: img)
                        }
                    }
            })
            .sheet(isPresented: $showSelectPhoto) {
                ImagePickerController(showselectPhoto: $showPhotoPicker, selectImage: $image)
            }
        }
    }
}

struct photoSelection_Previews: PreviewProvider {
    static var previews: some View {
        photoSelection()
    }
}
