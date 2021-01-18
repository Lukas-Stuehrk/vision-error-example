import XCTest
import AVFoundation
import Vision

class VisionCrashTests: XCTestCase {

    func testVision() throws {
        let assetUrl = Bundle(for: VisionCrashTests.self).url(forResource: "Video", withExtension: "mov")!
        let asset = AVAsset(url: assetUrl)
        let reader = try AVAssetReader(asset: asset)
        let output = AVAssetReaderTrackOutput(track: asset.tracks.first!, outputSettings: [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange
        ])
        reader.add(output)
        reader.startReading()
        while let sample = output.copyNextSampleBuffer() {
            performVisionRequest(sampleBuffer: sample)
        }
    }

    func performVisionRequest(sampleBuffer: CMSampleBuffer) {
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        let request = VNRecognizeTextRequest(completionHandler: processResults(request:error:))
        request.recognitionLevel = .fast
        request.usesLanguageCorrection = false
        // The cropping is causing the issue. If you comment out the next line, everything will work on the simulator.
        request.regionOfInterest = CGRect(x: 0, y: 0, width: 1, height: 0.2)
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:])
        try! requestHandler.perform([request])

    }

    func processResults(request: VNRequest?, error: Error?) {

    }
}
