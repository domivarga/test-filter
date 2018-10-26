//
//  ViewController.swift
//  TestFilter
//
//  Created by Varga Domonkos on 2018. 10. 26..
//  Copyright © 2018. BME AUT. All rights reserved.
//

import UIKit
import GPUImage

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        var image = createImageWithPipeline(image: UIImage(named: "test")!, filter: GPUImageBrightnessFilter())
        image = createImageWithPipeline(image: image, filter: GPUImageContrastFilter())
        imageView.image = createImageWithPipeline(image: image, filter: GPUImageSaturationFilter())         
    }

    private func createImageWithPipeline(image: UIImage, filter: GPUImageFilter) -> UIImage {
        let stillImageSource = GPUImagePicture(image: image)

        stillImageSource?.addTarget(filter)
        filter.useNextFrameForImageCapture()
        stillImageSource?.processImage()

        guard let img = stillImageSource?.imageFromCurrentFramebuffer(with: .up) else { return UIImage() }

        return img
    }
}

