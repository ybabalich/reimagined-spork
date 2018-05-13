//
//  ImageLoaderView.swift
//  FadFed
//
//  Created by Yaroslav Babalich on 2/1/18.
//  Copyright © 2018 Wefaaq Co. All rights reserved.
//

import UIKit

typealias ImageLoaderViewLoadedImageClosure = (_ loadedImage: UIImage?, _ isCached: Bool) -> ()

class ImageLoaderView: UIImageView {

    // MARK: - Variables
    var imageLoader: ImageLoaderProtocol = {
        return ImageLoaderService.instance
    }()
    fileprivate var latestDownloadURLString: String?

    // MARK: - Public methods
    func loadImageFrom(url: String) {
        loadImageFrom(url: url, startLoading: true) { (loadedImage, isCached) in
            self.image = loadedImage
        }
    }
    
    func loadImageFrom(url: String, completion: @escaping ImageLoaderViewLoadedImageClosure) {
        loadImageFrom(url: url, startLoading: true, completion: completion)
    }
    
    func loadImageFrom(url: String, startLoading: Bool, completion: @escaping ImageLoaderViewLoadedImageClosure) {
        self.latestDownloadURLString = url
        
        imageLoader.loadImage(url: url, type: .gif, startLoading: startLoading) { (loadedImage, isCached) in
            if self.latestDownloadURLString == url {
                ui {
                    completion(loadedImage, isCached)
                }
            }
        }
    }

}
