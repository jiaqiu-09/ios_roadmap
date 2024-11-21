//
//  ViewController.swift
//  CoreAudioDemo
//
//  Created by Jason Qiu on 2024/11/20.
//

import UIKit
import AVFoundation
import MediaPlayer


class ViewController: UIViewController {
    var playButton: UIButton!
    var stopButton: UIButton!
    var audioPlayer: AVAudioPlayer?
    var volumeSlider: UISlider!
    var volumeView: MPVolumeView!
    var recordButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
        
        if let url = Bundle.main.url(forResource: "sample", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                volumeSlider.value = audioPlayer?.volume ?? 1.0
            } catch {
                print("Audio file loading failed: \(error.localizedDescription)")
            }
        }
    }

    private func setupUI() {
        playButton = UIButton(type: .system)
        playButton.setTitle("Play", for: .normal)
        playButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        playButton.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playButton)
        
        stopButton = UIButton(type: .system)
        stopButton.setTitle("Stop", for: .normal)
        stopButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        stopButton.addTarget(self, action: #selector(stopAudio), for: .touchUpInside)
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stopButton)
        
        volumeSlider = UISlider()
        volumeSlider.minimumValue = 0.0
        volumeSlider.maximumValue = 1.0
        volumeSlider.value = 1.0
        volumeSlider.addTarget(self, action: #selector(volumeChanged), for: .valueChanged)
        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(volumeSlider)
        
        volumeView = MPVolumeView()
        volumeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(volumeView)
        
        recordButton = UIButton(type: .system)
        recordButton.setTitle("Record Page", for: .normal)
        recordButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        recordButton.addTarget(self, action: #selector(gotoRecordPage), for: .touchUpInside)
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recordButton)
        

        
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 20),
            
            volumeSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            volumeSlider.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 30),
            volumeSlider.widthAnchor.constraint(equalToConstant: 250),
            
            volumeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            volumeView.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 90),
            volumeView.widthAnchor.constraint(equalToConstant: 250),
            volumeView.heightAnchor.constraint(equalToConstant: 40),
            
            recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordButton.topAnchor.constraint(equalTo: volumeView.bottomAnchor, constant: 90),

        ])
    }
    
    @objc func playAudio() {
        audioPlayer?.play()
    }
    
    @objc func stopAudio() {
        audioPlayer?.stop()
    }
    
    @objc func volumeChanged() {
        audioPlayer?.volume = volumeSlider.value
    }
    
    @objc func gotoRecordPage() {
        DispatchQueue.main.async {
            let recordVC = RecordViewController()
            recordVC.title = "Record Page"
            
            self.navigationController?.pushViewController(recordVC, animated: true)
        }
        
    }

}

