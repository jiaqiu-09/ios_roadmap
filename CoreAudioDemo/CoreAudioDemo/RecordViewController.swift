//
//  RecordViewController.swift
//  CoreAudioDemo
//
//  Created by Jason Qiu on 2024/11/21.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController {
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var audioFilePath: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        requestMicrophonePermission()
    }

    func requestMicrophonePermission() {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            if !granted {
                print("Microphone permission denied")
            }
        }
    }

    func setupUI() {
        // Record button
        let recordButton = UIButton(type: .system)
        recordButton.setTitle("Start Recording", for: .normal)
        recordButton.addTarget(self, action: #selector(toggleRecording(_:)), for: .touchUpInside)
        recordButton.frame = CGRect(x: 50, y: 100, width: 200, height: 50)
        view.addSubview(recordButton)

        // Play button
        let playButton = UIButton(type: .system)
        playButton.setTitle("Play Recording", for: .normal)
        playButton.addTarget(self, action: #selector(playRecording), for: .touchUpInside)
        playButton.frame = CGRect(x: 50, y: 200, width: 200, height: 50)
        view.addSubview(playButton)
    }

    @objc func toggleRecording(_ sender: UIButton) {
        if let recorder = audioRecorder, recorder.isRecording {
            // Stop recording
            recorder.stop()
            sender.setTitle("Start Recording", for: .normal)
        } else {
            // Start recording
            startRecording()
            sender.setTitle("Stop Recording", for: .normal)
        }
    }

    func startRecording() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)

            // File path for the recording
            let fileManager = FileManager.default
            let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let audioFileName = UUID().uuidString + ".m4a"
            let audioFilePath = documentsPath.appendingPathComponent(audioFileName)
            self.audioFilePath = audioFilePath

            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]

            audioRecorder = try AVAudioRecorder(url: audioFilePath, settings: settings)
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()

            print("Recording started: \(audioFilePath)")
        } catch {
            print("Failed to start recording: \(error)")
        }
    }

    @objc func playRecording() {
        guard let filePath = audioFilePath else {
            print("No recording available to play.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: filePath)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            print("Playing recording: \(filePath)")
        } catch {
            print("Failed to play recording: \(error)")
        }
    }
}

extension RecordViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Finished playing")
    }
}

