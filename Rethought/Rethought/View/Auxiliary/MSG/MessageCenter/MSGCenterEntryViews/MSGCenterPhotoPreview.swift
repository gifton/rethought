
import Foundation
import UIKit
import AVFoundation

protocol MSGCenterPhotoBus {
    func photoTaken(_ photo: UIImage, completion: () -> Void)
}

class MSGCenterPreviewPhotoView: UIView {
    
    init(frame: CGRect, bus: MSGCenterPhotoBus) {
        self.bus = bus
        super.init(frame: frame)
        setView()
        backgroundColor = .black
        self.addTapGestureRecognizer {
            self.didTakePhoto()
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: Private vars
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var interactionLabel = UILabel()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var bus: MSGCenterPhotoBus
    
    func setView() {
        // create capture session, .medium for meh quality photos
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        //guard into back camera
        //TODO: add front camera support
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video) else { print("Unable to access back camera"); return }
        
        do {
            // recieve input
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()
            
            // check if input and output is validated
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
        
        
    }
    
    func setupLivePreview() {
        print("setting up live preview")
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.connection?.videoOrientation = .portrait
        layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.previewLayer.frame = self.bounds
            }
        }
        
        
    }
    
    private func didTakePhoto() {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
        print("we took an image!")
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        guard let  image = UIImage(data: imageData) else {
            print ("unable to process photo from session")
            return
        }
        
        bus.photoTaken(image, completion: endSession)
        print("we sent the image!")
    }
    
    public func endSession() {
        print("session ended")
        captureSession.stopRunning()
    }
}

extension MSGCenterPreviewPhotoView: AVCapturePhotoCaptureDelegate { }
