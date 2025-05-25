//
//  RecordingSheetVM.swift
//  HowlX
//
//  Created by Alejandra Coeto on 10/05/25.
//

import AVFoundation
import Foundation

class RecordingSheetVM: NSObject, ObservableObject {
    @Published var hasRecording = true
    @Published var audioRecorder: AVAudioRecorder?
    @Published var isRecording = false
    @Published var selectedClient: Client? = nil

    @Published var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var playbackProgress: Double = 0
    private var playbackTimer: Timer?
    @Published var clients: [Client] = []
    
    private var audioFileURL: URL {
        let documentPath = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask)[0]
        return documentPath.appendingPathComponent("recording.m4a")
    }

    override init() {
        super.init()
        guard let token = loadTokenFromKeychain() else {
            print("No token available")
            return
        }
        
        fetchClients(token: token) { result in
            switch result {
            case .success(let clients):
                print("Fetched \(clients.count) clients")
                DispatchQueue.main.async {
                    self.clients = clients
//                    self.selectedClient = clients.first!
                }
                // Update your state or UI here
            case .failure(let error):
                print("Error fetching calls: \(error)")
            }
        }
        
    }
    
    func uploadRecording() {
        
    }
    
    func getDisplayName(_ client: Client?) -> String {
        guard let client = client else {
            return ""
        }
        
        return client.firstname + " " + client.lastname
    }
    
    func getCompanyName(_ client: Client?) -> String {
        guard let client = client else {
            return ""
        }
        
        return client.company.name
    }

    func handleCancel() {
        hasRecording = false
    }

   
    func startRecording() {
        // First request permission
        AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if granted {
                    self.setupAndStartRecording()
                } else {
                    print("Microphone permission denied")
                }
            }
        }
    }

    private func setupAndStartRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)

            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]

            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
            audioRecorder?.record()
            isRecording = true
        } catch {
            print("Failed to start recording: \(error)")
        }
    }

    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        hasRecording = FileManager.default.fileExists(atPath: audioFileURL.path)
    }
    
    func playRecording() {
            guard FileManager.default.fileExists(atPath: audioFileURL.path) else {
                print("No recording exists at \(audioFileURL)")
                hasRecording = false
                return
            }
            
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
                audioPlayer = try AVAudioPlayer(contentsOf: audioFileURL)
                audioPlayer?.delegate = self
                audioPlayer?.play()
                isPlaying = true
                
                // Start progress updates
                playbackTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                    guard let self = self, let player = self.audioPlayer else { return }
                    self.playbackProgress = player.currentTime / player.duration
                }
            } catch {
                print("Playback failed: \(error)")
            }
        }
        
        func stopPlayback() {
            audioPlayer?.stop()
            isPlaying = false
            playbackProgress = 0
            playbackTimer?.invalidate()
        }
        
        func togglePlayback() {
            if isPlaying {
                stopPlayback()
            } else {
                playRecording()
            }
        }
        
        deinit {
            stopPlayback()
        }
}

extension RecordingSheetVM: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
        playbackProgress = 0
        playbackTimer?.invalidate()
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Playback error: \(error?.localizedDescription ?? "unknown")")
        isPlaying = false
        playbackProgress = 0
        playbackTimer?.invalidate()
    }
}
