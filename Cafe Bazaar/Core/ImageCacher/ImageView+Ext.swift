//
//  ImageView+Ext.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/23/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import UIKit
// this property have used to indicates if this image's download is finished or not
private var AssociatedObjectHandle: UInt8 = 0
private var AssociatedObjectTaskHandle: UInt8 = 0
extension UIImageView {
	private var urlToLoad:String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
	
	private var downloadTask:URLSessionDataTask? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectTaskHandle) as? URLSessionDataTask
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectTaskHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
	
	
	/// load an image from a url(or cache). every image will be cached by system after it download is finished.
	/// - Parameters:
	///   - string: url string
	///   - done: a callback that will call after image is ready
	func fromURL(string: String, done: ((UIImage?)->Void)? = nil) {
		self.urlToLoad = string
		guard let url = URL(string: string) else {
			return
		}
		self.downloadTask?.stop()
		
		if let cachedImage = ImageCacher.shared.load(key: url.absoluteString){
			DispatchQueue.main.async {[weak self] in
				let image = cachedImage
				self?.image = image
				done?(image)
			}
		} else {
			let downloadTask = RestService.init(request: ImageRequest(url: url)).run { (result, done) in
				switch result {
				case .success(let base64):
					guard let image =  UIImage(data: base64) else {return}
					ImageCacher.shared.add(key: url.absoluteString, image: image)
					DispatchQueue.main.async {[weak self] in
						guard let self = self else {return}
						if self.urlToLoad == string {
							self.image = image
						}
					}
				default: return
				}
			}
			self.downloadTask = downloadTask as! URLSessionDataTask
			self.downloadTask?.start()
			return
		}
	}
}
