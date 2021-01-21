//
//  ImagePickerController.swift
//  final_00757128
//
//  Created by User18 on 2021/1/5.
//


import SwiftUI
import UIKit

struct ImagePickerController:UIViewControllerRepresentable{
    @Binding var showselectPhoto:Bool
    @Binding var selectImage:Image
    
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(imagePickerController:self)
    }
    func makeUIViewController(context:UIViewControllerRepresentableContext<ImagePickerController>) ->UIImagePickerController{
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = context.coordinator
        return controller
    }
    class Coordinator:NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        
        internal init(imagePickerController:ImagePickerController) {
            self.imagePickerController = imagePickerController
        }
        
        let imagePickerController: ImagePickerController
        
        func imagePickerController(_ picker:UIImagePickerController,didFinishPickingMediaWithInfo info:[
            UIImagePickerController.InfoKey:Any]) {
            if let uiImage = info[. originalImage ] as? UIImage {
                imagePickerController.selectImage = Image (uiImage: uiImage)
                
                
                //存照片
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                if let data = try? uiImage.pngData() {
                    let url =
                        documentsDirectory.appendingPathComponent("savedPhoto")
                    try? data.write(to: url)
                }
                //
            }
            imagePickerController.showselectPhoto = false
        }
    }
    
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
}

class UIActivityViewController : UIViewController {
    func share() {
        let items = "This app is my favorite"
        let ac = UIActivityViewController(nibName: items, bundle: nil)
        present(ac, animated: true)
    }
}

