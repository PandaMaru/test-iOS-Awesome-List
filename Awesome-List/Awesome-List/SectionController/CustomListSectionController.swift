//
//  CustomListSectionController.swift
//  Awesome-List
//
//  Created by PandaMaru on 7/21/2560 BE.
//  Copyright © 2560 amuse. All rights reserved.
//

import UIKit
import IGListKit
import Kingfisher

protocol CustomListSectionDelegate {
    func updateSelfSizingCell(model: List)
}

class CustomListSectionController: ListSectionController {
    private var model: List?
    private var coverImage: UIImage?
    
    public var delegate: CustomListSectionDelegate?
    
    override func sizeForItem(at index: Int) -> CGSize {
        if let _coverImage = coverImage {
            return CGSize(width: collectionContext!.containerSize.width, height: _coverImage.size.height + 20)
        } else {
            return CGSize(width: collectionContext!.containerSize.width, height: 55)
        }
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        if model?.type == .track {
            guard let cell = collectionContext?.dequeueReusableCellFromStoryboard(withIdentifier: "TrackCollectionViewCell", for: self, at: index) as? TrackCollectionViewCell else {
                fatalError()
            }
            
            if let _coverImage = coverImage {
                cell.img_cover.image = _coverImage
            } else {
                let p = ResizingImageProcessor(referenceSize: cell.img_cover.frame.size, mode: .aspectFit)
                ImageDownloader.default.downloadImage(with: URL(string: model!.cover)!, retrieveImageTask: nil, options: [.processor(p)], progressBlock: nil, completionHandler: { [weak self] (image, error, cacheType, imageUrl) in
                    
                    if let _image = image {
                        self?.coverImage = _image
                        self?.delegate?.updateSelfSizingCell(model: self!.model!)
                    } else {
                        cell.img_cover.backgroundColor = UIColor.red
                    }
                })
            }
            
            cell.lbl_name.text = model?.name
            
            return cell
        } else if model?.type == .video {
            guard let cell = collectionContext?.dequeueReusableCellFromStoryboard(withIdentifier: "VideoCollectionViewCell", for: self, at: index) as? VideoCollectionViewCell else {
                fatalError()
            }
            
            if let _coverImage = coverImage {
                cell.img_cover.image = _coverImage
            } else {
                let p = ResizingImageProcessor(referenceSize: cell.img_cover.frame.size, mode: .aspectFill)
                ImageDownloader.default.downloadImage(with: URL(string: model!.cover)!, retrieveImageTask: nil, options: [.processor(p)], progressBlock: nil, completionHandler: { [weak self] (image, error, cacheType, imageUrl) in
                    
                    if let _image = image {
                        self?.coverImage = _image
                        self?.delegate?.updateSelfSizingCell(model: self!.model!)
                    } else {
                        cell.img_cover.backgroundColor = UIColor.red
                    }
                })
            }
            
            return cell
        } else if model?.type == .ads {
            guard let cell = collectionContext?.dequeueReusableCellFromStoryboard(withIdentifier: "AdsCollectionViewCell", for: self, at: index) as? AdsCollectionViewCell else {
                fatalError()
            }
            
            if let _coverImage = coverImage {
                cell.img_cover.image = _coverImage
            } else {
                let p = ResizingImageProcessor(referenceSize: cell.img_cover.frame.size, mode: .aspectFill)
                ImageDownloader.default.downloadImage(with: URL(string: model!.cover)!, retrieveImageTask: nil, options: [.processor(p)], progressBlock: nil, completionHandler: { [weak self] (image, error, cacheType, imageUrl) in
                    
                    if let _image = image {
                        self?.coverImage = _image
                        self?.delegate?.updateSelfSizingCell(model: self!.model!)
                    } else {
                        cell.img_cover.backgroundColor = UIColor.red
                    }
                })
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    override func didUpdate(to object: Any) {
        model = object as? List
    }
}
