//
//  ImageLoaderService.swift
//  FadFed
//
//  Created by Yaroslav Babalich on 2/2/18.
//  Copyright © 2018 Wefaaq Co. All rights reserved.
//

import UIKit

enum ImageType {
    case `static`
    case gif
}

protocol ImageLoaderProtocol {
    typealias ImageLoaderLoadedImageClosure = (_ loadedImage: UIImage?, _ isCached: Bool) -> ()
    
    func suspendAllTasks()
    func resumeAllTasks()
    func startTasks(names: [String])
    func image(by urlKey: String) -> UIImage?
    func loadImage(url: String, type: ImageType, startLoading: Bool, completion: @escaping ImageLoaderLoadedImageClosure)
}

class ImageLoaderService: NSObject {

    class ImageLoaderQueue {
        
        class ImageLoaderTask: Equatable {
            
            // MARK: - Variables
            let url: String
            var task: URLSessionDataTask?
            var completions: [ImageLoaderProtocol.ImageLoaderLoadedImageClosure]
            
            // MARK: - Initialization methods
            init(url: String, completion: @escaping ImageLoaderProtocol.ImageLoaderLoadedImageClosure) {
                self.url = url
                completions = [completion]
            }
            
            // MARK: - Public methods
            func performCompletions(image: UIImage?, isCached: Bool) {
                completions.forEach { (completion) in
                    completion(image, isCached)
                }
            }
            
            // MARK: - Equatable
            static func ==(lhs: ImageLoaderService.ImageLoaderQueue.ImageLoaderTask,
                           rhs: ImageLoaderService.ImageLoaderQueue.ImageLoaderTask) -> Bool
            {
                return lhs.url == rhs.url
            }
            
        }
        
        // MARK: - Variables
        let name: String
        let cache: NSCache<NSString, UIImage>
        var tasks: [ImageLoaderTask]
        
        // MARK: - Initialization methods
        init(name: String, cache: NSCache<NSString, UIImage>) {
            self.name = name
            self.cache = cache
            tasks = []
        }
        
        // MARK: - Public methods
        func containTask(url: String) -> (Int, ImageLoaderTask)? {
            for (i, currentTask) in tasks.enumerated() {
                if currentTask.url == url {
                    return (i, currentTask)
                }
            }
            return nil
        }
        
        func resume() {
            tasks.forEach { (imageLoaderTask) in
                imageLoaderTask.task!.resume()
            }
        }
        
        func suspend() {
            tasks.forEach { (imageLoaderTask) in
                imageLoaderTask.task!.suspend()
            }
        }
        
        func append(task: ImageLoaderTask, startLoading: Bool) {
            let newTask = mergeOrCreate(task: task)
            if newTask.task == nil {
                start(task: newTask, startLoading: startLoading)
            } else {
                newTask.task!.resume()
            }
        }
        
        func removeTask(url: String) {
            if let (indexOfTask, _) = containTask(url: url) {
                tasks.remove(at: indexOfTask)
            }
        }
        
        func removeAll() {
            tasks.removeAll()
        }
        
        // MARK: - Private methods
        private func start(task: ImageLoaderTask, startLoading: Bool) {
            if let imageURL = URL(string: task.url) {
                task.task = URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, urlResponse, error) in
                    if let data = data {
                        let image = UIImage(data: data)
                        if image != nil {
                            self.cache.setObject(image!, forKey: task.url as NSString)
                        }
                        
                        task.performCompletions(image: image, isCached: false)
                        self.removeTask(url: task.url)
                    } else {
                        task.performCompletions(image: nil, isCached: false)
                        self.removeTask(url: task.url)
                    }
                })
                if startLoading {
                    task.task!.resume()
                }
            } else {
                task.performCompletions(image: nil, isCached: false)
                self.removeTask(url: task.url)
            }
        }
        
        private func mergeOrCreate(task: ImageLoaderTask) -> ImageLoaderTask {
            if let (_, currentTask) = containTask(url: task.url) {
                currentTask.completions.append(task.completions.first!)
                return currentTask
            } else {
                let queue = DispatchQueue(label: "Some")
                queue.async(execute: {
                    self.tasks.append(task)
                })
                return task
            }
        }
    }
    
    // MARK: - Variables
    fileprivate var _cache: NSCache<NSString, UIImage> = {
        return NSCache<NSString, UIImage>()
    }()
    fileprivate lazy var queue: ImageLoaderQueue = {
        return ImageLoaderQueue(name: "Loading gif images queue", cache: self._cache)
    }()
    
    // MARK: - Singleton
    static let instance = ImageLoaderService()
}

extension ImageLoaderService: ImageLoaderProtocol {
    func startTasks(names: [String]) {
        names.forEach { (taskName) in
            if let (_, task) = self.queue.containTask(url: taskName) {
                self.queue.append(task: task, startLoading: true)
            }
        }
        
        queue.tasks.forEach { (imageLoaderTask) in
            print(imageLoaderTask.task?.state.rawValue ?? "")
        }
        
    }
    
    func suspendAllTasks() {
        queue.suspend()
    }
    
    func resumeAllTasks() {
        queue.resume()
    }
    
    func image(by urlKey: String) -> UIImage? {
        return _cache.object(forKey: urlKey as NSString)
    }
    
    func loadImage(url: String,
                   type: ImageType,
                   startLoading: Bool,
                   completion: @escaping ImageLoaderProtocol.ImageLoaderLoadedImageClosure)
    {
        DispatchQueue.global(qos: .background).async { [unowned self] in
            if let image = self.image(by: url) {
                completion(image, true)
                return
            }
            
            let imageLoaderTask = ImageLoaderQueue.ImageLoaderTask(url: url, completion: completion)
            self.queue.append(task: imageLoaderTask, startLoading: startLoading)
        }
    }
}
