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
    
    let captureSession = AVCaptureSession()
    
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
//        captureSession.sessionPreset = .low
//        captureSession.sessionPreset = .hd4K3840x2160
        selectSessionPreset()
        
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
    
    private func selectSessionPreset() {
        /*if captureSession.canSetSessionPreset(AVCaptureSession.Preset.hd4K3840x2160) {
            captureSession.sessionPreset = AVCaptureSession.Preset.hd4K3840x2160;
            
            //        A preset suitable for capturing 2160p-quality (3840 x 2160 pixels) video output.
            print("B Camera - captureSessionPreset: \(captureSession.sessionPreset)")
        } else if captureSession.canSetSessionPreset(AVCaptureSession.Preset.hd1920x1080) {
            captureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080
            
            //        A preset suitable for capturing 1080p-quality (1920 x 1080 pixels) video output.
            print("B Camera - captureSessionPreset: \(captureSession.sessionPreset)")
        } else if captureSession.canSetSessionPreset(AVCaptureSession.Preset.hd1280x720) {
            captureSession.sessionPreset = AVCaptureSession.Preset.hd1280x720
            
            //        A preset sitable for capturing 720p quality (1280 x 720 pixel) video output.
            print("B Camera - captureSessionPreset: \(captureSession.sessionPreset)")
        } else */ if captureSession.canSetSessionPreset(AVCaptureSession.Preset.iFrame1280x720) {
            captureSession.sessionPreset = AVCaptureSession.Preset.iFrame1280x720
            
            //        A preset suitable for capturing 1280 x 720 quality iFrame H.264 video at about 40 Mbits/sec with AAC audio.
            print("B Camera - captureSessionPreset: \(captureSession.sessionPreset)")
        } else if captureSession.canSetSessionPreset(AVCaptureSession.Preset.iFrame960x540) {
            captureSession.sessionPreset = AVCaptureSession.Preset.iFrame960x540
            
            //        A preset suitable for capturing 960 x 540 quality iFrame H.264 video at about 30 Mbits/sec with AAC audio.
            print("B Camera - captureSessionPreset: \(captureSession.sessionPreset)")
        } else if captureSession.canSetSessionPreset(AVCaptureSession.Preset.cif352x288) {
            captureSession.sessionPreset = AVCaptureSession.Preset.cif352x288
            
            //        A preset suitable for capturing CIF quality (352 x 288 pixel) video output.
            print("B Camera - captureSessionPreset: \(captureSession.sessionPreset)")
        } else if captureSession.canSetSessionPreset(AVCaptureSession.Preset.photo) {
            captureSession.sessionPreset = AVCaptureSession.Preset.photo
            
            //        A preset suitable for capturing high-resolution photo quality output.
            print("B Camera - captureSessionPreset: \(captureSession.sessionPreset)")
        } else {
            print("B Camera - failed selectSessionPreset");
        }
    }
}
