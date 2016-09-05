//
//  WaveformWindowController.swift
//  Example-macOS
//
//  Created by Jonathan on 9/5/16.
//  Copyright © 2016 Jonathan Underwood. All rights reserved.
//

import Cocoa
import AVFoundation
import WaveformView

class WaveformWindowController: NSWindowController {
    @IBOutlet weak var waveformView: WaveformView!

    var audioRecorder: AVAudioRecorder!

    override func windowDidLoad() {
        super.windowDidLoad()
        audioRecorder = audioRecorder(URL(fileURLWithPath:"/dev/null"))
        audioRecorder.record()

        Timer.scheduledTimer(timeInterval: 0.0167, target: self, selector: #selector(updateMeters), userInfo: nil, repeats: true)
    }

    func updateMeters() {
        audioRecorder.updateMeters()
        let normalizedValue = pow(10, audioRecorder.averagePower(forChannel: 0) / 20)
        waveformView.updateWithLevel(CGFloat(normalizedValue))
    }

    func audioRecorder(_ filePath: URL) -> AVAudioRecorder {
        let recorderSettings: [String : AnyObject] = [
            AVSampleRateKey: 44100.0 as AnyObject,
            AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC),
            AVNumberOfChannelsKey: 2 as AnyObject,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue as AnyObject
        ]

        let audioRecorder = try! AVAudioRecorder(url: filePath, settings: recorderSettings)
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()

        return audioRecorder
    }
}
