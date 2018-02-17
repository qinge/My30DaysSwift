//
//  CenterViewController.swift
//  Snapchat Menu & Camera
//
//  Created by qinge on 2018/2/17.
//  Copyright © 2018年 qin. All rights reserved.
//

import UIKit
import AVFoundation


class CenterViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var tempImageView: UIImageView!
    
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .hd1920x1080
        
        let backCamera = AVCaptureDevice.default(for: .video)
        var error: Error?
        var input: AVCaptureDeviceInput!
        
        do {
            input = try AVCaptureDeviceInput(device: backCamera!)
        } catch let e {
            error = e
            input = nil
        }
        
        if (error == nil && (captureSession?.canAddInput(input))!) {
            captureSession?.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            previewLayer?.videoGravity = .resizeAspect
            previewLayer?.connection?.videoOrientation = .portrait
            cameraView.layer.addSublayer(previewLayer!)
            captureSession?.startRunning()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer?.frame = cameraView.bounds
    }
    
    
    

    func didPressTakePhoto() {
        if let videoConnection = stillImageOutput?.connection(with: .video){
            videoConnection.videoOrientation = .portrait
            stillImageOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (sampleBuffer, error) in
                if sampleBuffer != nil{
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer!)
                    let dataProvider  = CGDataProvider(data: imageData! as CFData)
                    let cgImageRef = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
                    
                    let image = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.right)
                    
                    self.tempImageView.image = image
                    self.tempImageView.isHidden = false
                }
            })
        }
    }
    
    var didTakePhoto = Bool()
    
    func didPressTakeAnother(){
        if didTakePhoto == true{
            tempImageView.isHidden = true
            didTakePhoto = false
            
        }
        else{
            captureSession?.startRunning()
            didTakePhoto = true
            didPressTakePhoto()
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        didPressTakeAnother()
    }

}
