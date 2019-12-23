//
//  ImageCacher.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/21/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import UIKit
// this property have used to indicates if this image's download is finished or not
private var AssociatedObjectHandle: UInt8 = 0
extension UIImageView {
	private var urlToLoad:String {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as! String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
		
		guard let request = try? ImageRequest(url: url).asURLRequest(), let cached = URLCache.shared.cachedResponse(for: request) else {
			RestService.init(request: ImageRequest(url: url)).run { (result, done) in
				switch result {
				case .success(let base64):
					DispatchQueue.main.async {[weak self] in
						guard let self = self else {return}
						if self.urlToLoad == string {
							self.image = UIImage(data: base64)
						}
					}
				default: return
				}
			}.start()
			return
		}
		
		DispatchQueue.main.async {[weak self] in
			let image = UIImage(data: cached.data)
			self?.image = image
			done?(image)
		}
	}
}
