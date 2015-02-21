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
    let sliderOne = ParameterWidget(frame: CGRectZero)
    let sliderTwo = ParameterWidget(frame: CGRectZero)
    let sliderThree = ParameterWidget(frame: CGRectZero)
    
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
                sliderChangeHandler()
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
    
        pickerView.backgroundColor = UIColor.darkGrayColor()
        pickerView.layer.cornerRadius = 5
        pickerView.layer.shadowColor = UIColor.blackColor().CGColor
        pickerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        pickerView.layer.shadowOpacity = 0.5
   
        for slider in [sliderOne, sliderTwo, sliderThree]
        {
            view.addSubview(slider)
            slider.addTarget(self, action: "sliderChangeHandler", forControlEvents: UIControlEvents.ValueChanged)
        }
        
        sourceImage = UIImage(named: "DSC00776.jpg")
        populateLabels(gpuImageDelegate.filters[pickerView.selectedRowInComponent(0)])
    }
    
    func populateLabels(filter: ImageFilter)
    {
        let fieldNames = gpuImageDelegate.getFieldNamesForFilter(filter)
  
        for (idx: Int, slider: ParameterWidget) in enumerate([sliderOne, sliderTwo, sliderThree])
        {
            if fieldNames.count > idx
            {
                slider.fieldName = fieldNames[idx]
                slider.value = 0.5
                UIView.animateWithDuration(0.25, animations: {slider.alpha = 1})
            }
            else
            {
                slider.fieldName = nil
                UIView.animateWithDuration(0.25, animations: {slider.alpha = 0})
            }
        }
        
        sliderChangeHandler()
    }

    func sliderChangeHandler()
    {
        let values = [CGFloat(sliderOne.value), CGFloat(sliderTwo.value), CGFloat(sliderThree.value)]
        let filter = gpuImageDelegate.filters[pickerView.selectedRowInComponent(0)]
        
        targetImageView.image = gpuImageDelegate.applyFilter(filter, values: values, sourceImage: sourceImage!)
    }
    
    // MARK: Picker View Support
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        populateLabels(gpuImageDelegate.filters[row])
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
        let pickerViewHeight : CGFloat = 216
        
        sourceImageView.frame = CGRect(x: 0, y: top, width: imageViewWidth, height: imageViewWidth).rectByInsetting(dx: 10, dy: 10)
        targetImageView.frame = CGRect(x: imageViewWidth, y: top, width: imageViewWidth, height: imageViewWidth).rectByInsetting(dx: 10, dy: 10)
        
        pickerView.frame = CGRect(x: 0, y: view.frame.height - pickerViewHeight - top, width: view.frame.width * 0.333, height: pickerViewHeight).rectByInsetting(dx: 10, dy: 0)
        
        sliderOne.frame = CGRect(x: view.frame.width * 0.333, y: view.frame.height - pickerViewHeight - top - 5, width: view.frame.width * 0.666, height: pickerViewHeight / 3).rectByInsetting(dx: 10, dy: 5)
        
        sliderTwo.frame = CGRect(x: view.frame.width * 0.333, y: view.frame.height - (pickerViewHeight / 1.5) - top, width: view.frame.width * 0.666, height: pickerViewHeight / 3).rectByInsetting(dx: 10, dy: 5)
        
        sliderThree.frame = CGRect(x: view.frame.width * 0.333, y: view.frame.height - (pickerViewHeight / 3) - top + 5, width: view.frame.width * 0.666, height: pickerViewHeight / 3).rectByInsetting(dx: 10, dy: 5)
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

