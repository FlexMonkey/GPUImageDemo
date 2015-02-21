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
    let filters = [ImageFilter.PolarPixellate, ImageFilter.PolkaDot, ImageFilter.Sketch, ImageFilter.ThresholdSketch, ImageFilter.Toon, ImageFilter.SmoothToon, ImageFilter.Emboss, ImageFilter.SphereRefraction, ImageFilter.GlassSphere]

    func applyFilter(filter: ImageFilter, values: [CGFloat], sourceImage: UIImage) -> UIImage
    {
        var gpuImageFilter: GPUImageOutput!
        
        switch filter
        {
        case ImageFilter.PolarPixellate:

            gpuImageFilter =  GPUImagePolarPixellateFilter()
            
            if let gpuImageFilter = gpuImageFilter as? GPUImagePolarPixellateFilter
            {
                if values.count > 0
                {
                    gpuImageFilter.pixelSize = CGSize(width: values[0], height: values[0])
                }
            }
            
        case ImageFilter.PolkaDot:

            gpuImageFilter =  GPUImagePolkaDotFilter()
            
            if let gpuImageFilter = gpuImageFilter as? GPUImagePolkaDotFilter
            {
                if values.count > 1
                {
                    gpuImageFilter.fractionalWidthOfAPixel = values[0]
                    gpuImageFilter.dotScaling = values[1]
                }
            }
            
        case ImageFilter.Sketch:

            gpuImageFilter =  GPUImageSketchFilter()
            
            if let gpuImageFilter = gpuImageFilter as? GPUImageSketchFilter
            {
                if values.count > 0
                {
                    gpuImageFilter.edgeStrength = values[0]
                }
            }
            
        case ImageFilter.ThresholdSketch:

            gpuImageFilter =  GPUImageThresholdSketchFilter()
            
            if let gpuImageFilter = gpuImageFilter as? GPUImageThresholdSketchFilter
            {
                if values.count > 1
                {
                    gpuImageFilter.edgeStrength = values[0]
                    gpuImageFilter.threshold = values[1]
                }
            }
            
        case ImageFilter.Toon:

            gpuImageFilter =  GPUImageToonFilter()
            
            if let gpuImageFilter = gpuImageFilter as? GPUImageToonFilter
            {
                if values.count > 1
                {
                    gpuImageFilter.threshold = values[0]
                    gpuImageFilter.quantizationLevels = values[1] * 10
                }
            }
            
        case ImageFilter.SmoothToon:
            // blurRadiusInPixels, threshold, quantizationLevels
            gpuImageFilter =  GPUImageSmoothToonFilter()
            
        case ImageFilter.Emboss:
            // intensity
            gpuImageFilter =  GPUImageEmbossFilter()
            
        case ImageFilter.SphereRefraction:
            //  radius, refractiveIndex
            gpuImageFilter =  GPUImageSphereRefractionFilter()
            
        case ImageFilter.GlassSphere:
            //radius, refractiveIndex
            gpuImageFilter =  GPUImageGlassSphereFilter()
        }
        
        return gpuImageFilter.imageByFilteringImage(sourceImage)
    }
    
    func getFieldNamesForFilter(filter: ImageFilter) -> [String]
    {
        var fieldNames: [String]!
        
        switch filter
        {
        case ImageFilter.PolarPixellate:
            fieldNames = ["Pixel Size"]
            
        case ImageFilter.PolkaDot:
            fieldNames = ["Width","Dot Scaling"]
            
        case ImageFilter.Sketch:
           fieldNames = ["Edge Strength"]
            
        case ImageFilter.ThresholdSketch:
            fieldNames = ["Edge Strength","Threshold"]
            
        case ImageFilter.Toon:
            fieldNames = ["Threshold","Quantization Levels"]
            
        case ImageFilter.SmoothToon:
            fieldNames = ["Blur Radius","Threshold","Quantization Levels"]
            
        case ImageFilter.Emboss:
           fieldNames = ["Intensity"]
            
        case ImageFilter.SphereRefraction:
            fieldNames = ["Radius","Refractive Index"]
            
        case ImageFilter.GlassSphere:
            fieldNames = ["Radius","Refractive Index"]
        }
        
        return fieldNames
    }
    
    
}

enum ImageFilter: String
{
    case PolarPixellate = "Polar Pixellate"
    case PolkaDot = "Polka Dot"
    case Sketch = "Sketch"
    case ThresholdSketch = "ThresholdSketch"
    case Toon = "Toon"
    case SmoothToon = "Smooth Toon"
    case Emboss = "Emboss"
    case SphereRefraction = "Sphere Refraction"
    case GlassSphere = "Glass Sphere"
}
