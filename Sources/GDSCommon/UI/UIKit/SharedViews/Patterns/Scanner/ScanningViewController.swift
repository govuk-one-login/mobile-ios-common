import AVFoundation
import UIKit
import Vision

/// View Controller for the `Scanner` storyboard XIB
/// It is initialised with a `viewModel` of type: `QRScanningViewModel`
/// and a `scanningController` of type: `ScanningController`
///
/// This screen includes the following views:
///   - `cameraView` (type: `UIView`)
///   - `instructionsLabel` (type: `UILabel`)
///   - `imageView`  (type: `UIImageView`)
///  This screen is used to scan a QR code, you can provide a format within the `viewModel`.
///
///  The `instructionsLabel` and `cameraView` are within `view`. The view controller adds the `childView`

public final class ScanningViewController<CaptureSession: GDSCommon.CaptureSession>: BaseViewController, VoiceOverFocus,
                                                                                     AVCaptureVideoDataOutputSampleBufferDelegate {
    private let captureDevice: any CaptureDevice.Type
    let captureSession: CaptureSession
    private let previewLayer: AVCaptureVideoPreviewLayer
    private(set) var barcodeRequest: VNImageBasedRequest!
    
    private let imageView: UIImageView = .init(image: .init(named: "qrscan", in: .module, compatibleWith: nil))
    
    var initialVoiceOverView: UIView {
        instructionsLabel
    }
    
    @IBOutlet private var cameraView: UIView!
    
    /// Instructions label: `UILabel`
    @IBOutlet private var instructionsLabel: UILabel! {
        didSet {
            instructionsLabel.accessibilityIdentifier = "instructionsLabel"
            instructionsLabel.text = viewModel.instructionText
            instructionsLabel.font = .init(style: .body, weight: .bold)
            instructionsLabel.textColor = .white
        }
    }
    
    private var isScanning: Bool = true
    public var viewModel: QRScanningViewModel
    
    private var overlayView: ScanOverlayView?
    
    let processingQueue = DispatchQueue(label: "barcodeScannerQueue",
                                        qos: .userInitiated,
                                        attributes: [],
                                        autoreleaseFrequency: .workItem)
    
    /// Initialiser for the `Scanning` view controller.
    /// Requires a single parameter.
    /// - Parameter viewModel: `QRScanningViewModel`
    public init(viewModel: QRScanningViewModel,
                captureDevice: any CaptureDevice.Type = AVCaptureDevice.self,
                captureSession: CaptureSession = AVCaptureSession(),
                requestType: VNImageBasedRequest.Type = VNDetectBarcodesRequest.self) {
        self.viewModel = viewModel
        self.captureDevice = captureDevice
        self.captureSession = captureSession
        self.previewLayer = captureSession.layer
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "Scanner", bundle: .module)
        self.barcodeRequest = requestType.init(completionHandler: detectedBarcode(_:_:))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeScannerCaptureView()
        updateRegionOfInterest()
        addImageOverlay()
        previewLayer.frame = cameraView.layer.bounds
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    private func updateRegionOfInterest() {
        previewLayer.layoutIfNeeded()
        cameraView.layoutIfNeeded()
    }
    
    func startAnimation() {
        UIView.animate(withDuration: 1.0) {
            self.imageView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 1.0) {
                self.imageView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            } completion: { _ in
                self.startAnimation()
            }
        }
    }
    
    /// Function to process the detected scanned barcode.
    /// Called as soon as a QR Code is detected
    /// Pulls out the first scanned ID
    private func detectedBarcode(_ request: VNRequest, _ error: Error?) {
        guard let results = request.results else {
            return
        }
        let qrCodes = results
            .compactMap { $0 as? VNBarcodeObservation }
            .compactMap { $0.payloadStringValue }
        guard let qrCode = qrCodes.first else { return }
        Task {
            await didScan(string: qrCode)
        }
    }
    
    @MainActor
    func didScan(string: String) async {
        isScanning = false
        await viewModel.didScan(value: string, in: overlayView ?? view)
        isScanning = true
    }
    
    // - MARK: AVCaptureVideoDataOutputSampleBufferDelegate
    
    public func captureOutput(_ output: AVCaptureOutput,
                              didOutput sampleBuffer: CMSampleBuffer,
                              from connection: AVCaptureConnection) {
        guard isScanning,
              let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer,
                                            options: [:])
        do {
            try handler.perform([barcodeRequest])
        } catch {
            preconditionFailure("Error with capturing output")
        }
    }
}

extension ScanningViewController {
    // Initiate the scanning process
    func startScanning() {
        if !captureSession.isRunning {
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
            }
        }
    }
    
    // End the scanning process
    func stopScanning() {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
}

extension ScanningViewController {
    private func setupVideoDisplay() {
        guard let videoCaptureDevice = captureDevice.for(mediaType: .video),
              let videoInput = try? videoCaptureDevice.input as? CaptureSession.Input else {
            preconditionFailure("Device does not have a video capture device")
        }
        guard captureSession.canAddInput(videoInput) else {
            assertionFailure("Can't add video input for detecting barcodes")
            return
        }
        captureSession.addInput(videoInput)
    }
    
    private func setupMetadataCapture() {
        let videoDataOutput = AVCaptureVideoDataOutput()
        guard captureSession.canAddOutput(videoDataOutput) else {
            assertionFailure("Can't add video output for detecting barcodes")
            return
        }
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.setSampleBufferDelegate(self, queue: processingQueue)
        
        captureSession.addOutput(videoDataOutput)
    }
    
    private func makeScannerCaptureView() {
        captureSession.beginConfiguration()
        setupVideoDisplay()
        setupMetadataCapture()
        captureSession.commitConfiguration()
        startScanning()
        previewLayer.videoGravity = .resizeAspectFill
        cameraView.layer.addSublayer(previewLayer)
        
        overlayView = .init()
        guard let overlayView else { return }
        cameraView.addSubview(overlayView, insetBy: .zero)
        
        NSLayoutConstraint.activate([
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func addImageOverlay() {
        guard let overlayView else { return }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: overlayView.viewfinderRect.height * 0.8).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: overlayView.viewfinderRect.width * 0.8).isActive = true
    }
}
