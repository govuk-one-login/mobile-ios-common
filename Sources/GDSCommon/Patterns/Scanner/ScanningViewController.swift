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

public final class ScanningViewController<CaptureSession: GDSCommon.CaptureSession>: BaseViewController,
                                                                                     VoiceOverFocus,
                                                                                     AVCaptureVideoDataOutputSampleBufferDelegate {
    private let captureDevice: any CaptureDevice.Type
    let captureSession: CaptureSession
    private let previewLayer: AVCaptureVideoPreviewLayer
    private(set) var barcodeRequest: VNImageBasedRequest!
    
    private let imageView: UIImageView = .init(image: .init(named: "qrscan", in: .module, compatibleWith: nil))
    
    public var initialVoiceOverView: UIView {
        instructionsLabel
    }
    
    private let cameraView = UIView()
    
    private lazy var instructionsLabel: UILabel = {
        let result = UILabel()
        result .translatesAutoresizingMaskIntoConstraints = false
        result.accessibilityIdentifier = "instructionsLabel"
        result.text = viewModel.instructionText
        result.numberOfLines = 0
        result.textAlignment = .center
        result.font = .init(style: .body, weight: .bold)
        result.textColor = .white
        return result
    }()
    
    private var isScanning: Bool = true
    public var viewModel: QRScanningViewModel
    
    private var overlayView: ScanOverlayView?
    private var imageViewHeightConstraint: NSLayoutConstraint?
    private var imageViewWidthConstraint: NSLayoutConstraint?
    
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
        super.init(viewModel: viewModel as? BaseViewModel, nibName: nil, bundle: .module)
        self.barcodeRequest = requestType.init(completionHandler: detectedBarcode(_:_:))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(cameraView)
        cameraView.bindToSuperviewSafeArea(insetBy: .zero)
        setupInstructionLabel()
        DispatchQueue.main.async {
            var initialVideoOrientation: AVCaptureVideoOrientation = .portrait
            if self.windowOrientation != .unknown, let videoOrientation = AVCaptureVideoOrientation(interfaceOrientation: self.windowOrientation) {
                initialVideoOrientation = videoOrientation
            }
            self.previewLayer.connection?.videoOrientation = initialVideoOrientation
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeScannerCaptureView()
        updateRegionOfInterest()
        addImageOverlay()
        updatePreviewLayerFrame()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let deviceOrientation = UIDevice.current.orientation
        guard let newVideoOrientation = AVCaptureVideoOrientation(deviceOrientation: deviceOrientation)
        else {
            return
        }
        
        previewLayer.connection?.videoOrientation = newVideoOrientation
        cameraView.layer.needsDisplayOnBoundsChange = true
        
        let bounds = view.bounds
        let frame = CGRect(
            x: 0,
            y: 0,
            width: bounds.maxY - bounds.minY,
            height: bounds.maxX - bounds.minX
        )
        
        previewLayer.frame = frame
        updateImageOverlay()
    }
    
    var windowOrientation: UIInterfaceOrientation {
        return view.window?.windowScene?.interfaceOrientation ?? .unknown
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
    
    private func updatePreviewLayerFrame() {
        let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame
        let convertedFrame = cameraView.convert(safeAreaFrame, from: view)
        previewLayer.frame = convertedFrame
    }
    
    private func setupInstructionLabel() {
        view.addSubview(instructionsLabel)
        NSLayoutConstraint.activate([
            instructionsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func makeScannerCaptureView() {
        captureSession.beginConfiguration()
        setupVideoDisplay()
        setupMetadataCapture()
        captureSession.commitConfiguration()
        previewLayer.videoGravity = .resizeAspectFill
        cameraView.clipsToBounds = true
        cameraView.layer.addSublayer(previewLayer)
        startScanning()
        
        overlayView = .init()
        guard let overlayView else { return }
        cameraView.addSubview(overlayView, insetBy: .zero)
    }
    
    private func addImageOverlay() {
        guard let overlayView else { return }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(imageView)
        print("add image overlay \(imageView.frame)")
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: overlayView.viewfinderRect.height * 0.8)
        imageViewWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: overlayView.viewfinderRect.width * 0.8)
        
        imageView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor).isActive = true
        imageViewHeightConstraint?.isActive = true
        imageViewWidthConstraint?.isActive = true
        print("add image overlay \(imageView.frame)")
        
    }
    
    private func updateImageOverlay() {
        guard let overlayView else { return }
        
        imageViewHeightConstraint?.isActive = false
        imageViewWidthConstraint?.isActive = false
        cameraView.layoutIfNeeded()
        imageView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor).isActive = true
        if UIDevice.current.orientation == .portrait {
            imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: overlayView.viewfinderRect.height * 2)
            imageViewWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: overlayView.viewfinderRect.width * 2)
        } else {
            imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: overlayView.viewfinderRect.height)
            imageViewWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: overlayView.viewfinderRect.width)
        }
        imageViewHeightConstraint?.isActive = true
        imageViewWidthConstraint?.isActive = true
        
        print("update image overlay \(imageView.frame)")
        
    }
}

extension AVCaptureVideoOrientation {
    init?(deviceOrientation: UIDeviceOrientation) {
        switch deviceOrientation {
        case .portrait: self = .portrait
        case .portraitUpsideDown: self = .portraitUpsideDown
        case .landscapeLeft: self = .landscapeRight
        case .landscapeRight: self = .landscapeLeft
        default: return nil
        }
    }
    
    init?(interfaceOrientation: UIInterfaceOrientation) {
        switch interfaceOrientation {
        case .portrait: self = .portrait
        case .portraitUpsideDown: self = .portraitUpsideDown
        case .landscapeLeft: self = .landscapeLeft
        case .landscapeRight: self = .landscapeRight
        default: return nil
        }
    }
}
