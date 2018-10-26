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

        imageView.image = createImageWithPipeline(image: UIImage(named: "test")!)

//        createImage(image: UIImage(named: "test")!, completion: { img in
//            self.imageView.image = img
//        })
    }

    private func createImageWithPipeline(image: UIImage) -> UIImage {
        let brightnessEffect = BrightnessAdjustment()
        let contrastEffect = ContrastAdjustment()
        let saturationEffect = SaturationAdjustment()

        brightnessEffect.brightness = 0
        contrastEffect.contrast = 1
        saturationEffect.saturation = 1

        let filteredImage = image.filterWithPipeline { input, output in
            input --> brightnessEffect --> contrastEffect --> saturationEffect --> output
        }

        return filteredImage
    }

    private func createImage(image: UIImage, completion: @escaping (UIImage) -> Void) {
        let input = PictureInput(image: image)
        let output = PictureOutput()
        let brightnessEffect = BrightnessAdjustment()
        let contrastEffect = ContrastAdjustment()
        let saturationEffect = SaturationAdjustment()

        brightnessEffect.brightness = 0
        contrastEffect.contrast = 1
        saturationEffect.saturation = 1

        output.imageAvailableCallback = { image in
            completion(image)
        }

        input --> brightnessEffect --> contrastEffect --> saturationEffect --> output
        input.processImage(synchronously:true)
    }
}

