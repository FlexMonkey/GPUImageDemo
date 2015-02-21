//
//  GPUImageDelegate.swift
//  GPUImageDemo
//
//  Created by Simon Gladman on 21/02/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import Foundation
import GPUImage
import UIKit

class GPUImageDelegate: NSObject
{
    let filters = [ImageFilter.PolarPixellate, ImageFilter.PolkaDot]

    func applyFilter(filter: ImageFilter, values: [CGFloat], sourceImage: UIImage) -> UIImage
    {
        var gpuImageFilter: GPUImageFilter!
        
        switch filter
        {
        case ImageFilter.PolarPixellate:
            gpuImageFilter =  GPUImagePolarPixellateFilter()
            
        case ImageFilter.PolkaDot:
            gpuImageFilter =  GPUImagePolkaDotFilter()
        }
        
        return gpuImageFilter.imageByFilteringImage(sourceImage)
    }
    
    
}

enum ImageFilter: String
{
    case PolarPixellate = "Polar Pixellate"
    case PolkaDot = "Polka Dot"
}
