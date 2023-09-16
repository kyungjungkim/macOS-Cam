//
//  ContentViewController.swift
//  macOSCam
//
//  Created by Kyungjung Kim on 2022/11/13.
//

import Cocoa
import AVFoundation

class ContentViewController: NSViewController {

    // Capture Session
    var session: AVCaptureSession?
    
    // Photo Output
    let output = AVCapturePhotoOutput()
    
    // Video Preview
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.view.setFrameSize(NSSize(width: 500.0, height: 500.0))
        self.view.layer?.backgroundColor = CGColor.black
        
        previewLayer.frame = self.view.bounds
        view.layer = previewLayer
        view.wantsLayer = true
        
        self.setUpCamera()
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        
        self.session?.stopRunning()
        removeFromParent()
    }
    
    private func setUpCamera() {
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .low
        
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = captureSession
                
                captureSession.startRunning()
                self.session = captureSession
            } catch {
                print(error)
            }
        }
    }
}
