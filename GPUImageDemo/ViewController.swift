//
//  ViewController.swift
//  GPUImageDemo
//
//  Created by Simon Gladman on 21/02/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit
import GPUImage

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    let pickerView = UIPickerView(frame: CGRectZero)
    
    let sourceImageView = UIImageView(frame: CGRectZero)
    let targetImageView = UIImageView(frame: CGRectZero)
    
    let gpuImageDelegate = GPUImageDelegate()
    
    var sourceImage: UIImage?
    {
        didSet
        {
            if let sourceImage = sourceImage
            {
                sourceImageView.image = sourceImage
                applyFilter(gpuImageDelegate.filters[pickerView.selectedRowInComponent(0)])
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.darkGrayColor()
        
        view.addSubview(sourceImageView)
        sourceImageView.contentMode = UIViewContentMode.ScaleAspectFit
        sourceImageView.layer.backgroundColor = UIColor.blackColor().CGColor
        sourceImageView.layer.borderColor = UIColor.blackColor().CGColor
        sourceImageView.layer.borderWidth = 5
        
        view.addSubview(targetImageView)
        targetImageView.contentMode = UIViewContentMode.ScaleAspectFit
        targetImageView.layer.backgroundColor = UIColor.blackColor().CGColor
        targetImageView.layer.borderColor = UIColor.blackColor().CGColor
        targetImageView.layer.borderWidth = 5
        
        view.addSubview(pickerView)
        pickerView.delegate = self
        pickerView.dataSource = self
   
        sourceImage = UIImage(named: "DSC00776.jpg")
    }
    
    func applyFilter(filter: ImageFilter)
    {
        targetImageView.image = gpuImageDelegate.applyFilter(filter, values: [0], sourceImage: sourceImage!)
    }
    
    // MARK: Picker View Support
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        applyFilter(gpuImageDelegate.filters[row])
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return gpuImageDelegate.filters[row].rawValue
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return gpuImageDelegate.filters.count
    }
    
    // MARK: Layout stuff
    
    override func viewDidLayoutSubviews()
    {
        let top = topLayoutGuide.length
        let imageViewWidth = CGFloat(view.frame.width / 2)
        
        sourceImageView.frame = CGRect(x: 0, y: top, width: imageViewWidth, height: imageViewWidth).rectByInsetting(dx: 10, dy: 10)
        targetImageView.frame = CGRect(x: imageViewWidth, y: top, width: imageViewWidth, height: imageViewWidth).rectByInsetting(dx: 10, dy: 10)
        
        pickerView.frame = CGRect(x: 0, y: view.frame.height - 162 - top, width: view.frame.width * 0.333, height: 162).rectByInsetting(dx: 10, dy: 0)
        
    }
    
    override func supportedInterfaceOrientations() -> Int
    {
        return Int(UIInterfaceOrientationMask.Landscape.rawValue)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

