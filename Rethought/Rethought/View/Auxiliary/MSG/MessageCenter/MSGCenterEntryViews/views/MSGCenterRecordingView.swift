//
//  MSGCenterRecordingView.swift
//  Rethought
//
//  Created by Dev on 5/12/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MSGCenterRecordingView: UIView {
    init(bus: EntryComponentBus, thoughtIsCompleted: Bool) {
        self.bus = bus
        super.init(frame: .zero)
        backgroundColor = Device.colors.recording
        setView(); styleView()
        if !(thoughtIsCompleted) {
            setForIncompleteCredentials()
        }
        setupRecorder()
    }
    
    // MARK: private variables
    private var bus: EntryComponentBus
    private var recordingSession: AVAudioSession?
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    
    // MARK: Objects
    private let recordButton = UIButton()

    private let playButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 32.5
        btn.backgroundColor = Device.colors.green
        
        return btn
    }()
    private let titleLabel = UILabel()
    private let finishedRecordingView = UIView()
    
    // set initial view
    private func setView() {
        addSubview(recordButton)
        addSubview(finishedRecordingView)
        addSubview(titleLabel)
        
        //set height width - sets autotranslat... to false
        recordButton.setHeightWidth(width: 65, height: 65)
        recordButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50).isActive = true
        recordButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        recordButton.addTapGestureRecognizer {
            self.beginRecording()
        }
        
        titleLabel.setTopAndLeading(top: topAnchor, leading: leadingAnchor, paddingTop: 25, paddingLeading: 25)
        finishedRecordingView.setAnchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 20, paddingLeading: 30, paddingBottom: 0, paddingTrailing: 30)
        finishedRecordingView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    // apply view styles
    private func styleView() {
        titleLabel.text = "New Recording"
        titleLabel.font = Device.font.title(ofSize: .xXXLarge)
        titleLabel.textColor = Device.colors.lightGray
        
        finishedRecordingView.layer.cornerRadius = 12.5
        finishedRecordingView.layer.borderColor = Device.colors.lightGray.cgColor
        finishedRecordingView.layer.borderWidth = 0.5
        
        recordButton.layer.cornerRadius = 32.5
        recordButton.backgroundColor = .white
        recordButton.layer.borderWidth = 0.5
        recordButton.layer.borderColor = UIColor.black.cgColor
        recordButton.doesEnable()
    }
    
    // set view if no thought is completed
    private func setForIncompleteCredentials() {
        let view = UIView(frame: frame)
        view.blurBackground(type: .regular)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
        
        let warningLbl = UILabel()
        warningLbl.font = Device.font.mediumTitle()
        warningLbl.text = "Add a new thought before adding an entry!"
        warningLbl.numberOfLines = 2
        warningLbl.translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(warningLbl)
        warningLbl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        warningLbl.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        warningLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func isDoneRecording() {
        print("recording is finally ended")
        recordButton.isDisabled()
        addSubview(playButton)
        
        playButton.setHeightWidth(width: 100, height: 35)
        playButton.setTitle("play", for: .normal)
        playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150).isActive = true
        playButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playButton.addTapGestureRecognizer {
            self.playRecording()
        }
    }
    
    private func didBeginRecording() {
        recordButton.removeTapGestureRecognizer {
            self.beginRecording()
        }
        recordButton.addTapGestureRecognizer {
            self.endRecording(success: true)
        }
        recordButton.backgroundColor = Device.colors.red
        print("updated button")
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension MSGCenterRecordingView: AVAudioPlayerDelegate , AVAudioRecorderDelegate {
    // playing and stopping audio
    // start recording audio
    private func beginRecording() {
        print("begining recording")
        let audioFilename = getFileURL()
        print(audioFilename)
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            
            print("was able to begin recording")
            //update UI
            didBeginRecording()
        } catch {
            print(error)
            endRecording(success: false)
        }
    }
    
    // end recording audio
    private func endRecording(success: Bool) {
        audioRecorder?.stop()
        audioRecorder = nil
        
        if success {
            print("recording ended from success")
            isDoneRecording()
        } else {
            print("there was a problem saving your recording")
            recordButton.isDisabled()
        }
    }
    
    func playRecording() {
        print("pressed play recording")
        playButton.backgroundColor = Device.colors.blue
        playButton.removeTapGestureRecognizer {
            self.playRecording()
        }
        playButton.addTapGestureRecognizer {
            self.stopPlayingRecording()
        }
        setupPlayer()
        audioPlayer?.play()
    }
    
    
    private func stopPlayingRecording() {
        audioPlayer?.stop()
        removeSubviews()
        setView()
    }
    
    
    
    // setting up recorders
    private func setupPlayer() {
        var audioError: NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: getFileURL())
        } catch let err as NSError {
            audioError = err
            audioPlayer = nil
        }
        
        if let err = audioError {
            print("AVAudioPlayer error: \(err.localizedDescription)")
        } else {
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.volume = 10.0
        }
    }
    private func setupRecorder() {
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession?.setCategory(.playAndRecord)
            try recordingSession?.setActive(true)
            
            recordingSession?.requestRecordPermission() {[ unowned self ] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.recordButton.doesEnable()
                    } else {
                        print("failed to load redorder")
                    }
                }
            }
            
        } catch {
            print(error)
        }
    }
    
    // get doc info
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func getFileURL() -> URL {
        let path = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        return path as URL
    }
}
