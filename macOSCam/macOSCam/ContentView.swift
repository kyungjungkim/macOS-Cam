//
//  ContentView.swift
//  macOSCam
//
//  Created by Kyungjung Kim on 3/13/25.
//

import Cocoa
import AVFoundation

class ContentView: NSView {

    // Capture Session
    var session: AVCaptureSession?
    
    // Photo Output
    let output = AVCapturePhotoOutput()
    
    // Video Preview
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    let captureSession = AVCaptureSession()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        self.setFrameSize(NSSize(width: 500.0, height: 500.0))
        self.layer?.backgroundColor = CGColor.black
        
        previewLayer.frame = self.bounds
        layer = previewLayer
        wantsLayer = true
        
        self.setUpCamera()
    }
    
    func dealloc() {
        self.session?.stopRunning()
    }
 
    private func setUpCamera() {
//        captureSession.sessionPreset = .low
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
        if captureSession.canSetSessionPreset(AVCaptureSession.Preset.iFrame1280x720) {
            captureSession.sessionPreset = AVCaptureSession.Preset.iFrame1280x720
            
            // A preset suitable for capturing 1280 x 720 quality iFrame H.264 video at about 40 Mbits/sec with AAC audio.
            print("B Camera - captureSessionPreset: \(captureSession.sessionPreset)")
        } else if captureSession.canSetSessionPreset(AVCaptureSession.Preset.iFrame960x540) {
            captureSession.sessionPreset = AVCaptureSession.Preset.iFrame960x540
            
            // A preset suitable for capturing 960 x 540 quality iFrame H.264 video at about 30 Mbits/sec with AAC audio.
            print("B Camera - captureSessionPreset: \(captureSession.sessionPreset)")
        } else if captureSession.canSetSessionPreset(AVCaptureSession.Preset.cif352x288) {
            captureSession.sessionPreset = AVCaptureSession.Preset.cif352x288
            
            // A preset suitable for capturing CIF quality (352 x 288 pixel) video output.
            print("B Camera - captureSessionPreset: \(captureSession.sessionPreset)")
        } else if captureSession.canSetSessionPreset(AVCaptureSession.Preset.photo) {
            captureSession.sessionPreset = AVCaptureSession.Preset.photo
            
            // A preset suitable for capturing high-resolution photo quality output.
            print("B Camera - captureSessionPreset: \(captureSession.sessionPreset)")
        } else {
            print("B Camera - failed selectSessionPreset");
        }
    }
}
