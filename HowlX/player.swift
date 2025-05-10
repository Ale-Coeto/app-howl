import AVFoundation

var audioPlayer: AVAudioPlayer?

func playRecording() {
    let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let audioFilename = documentPath.appendingPathComponent("recording.m4a")

    do {
        audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
    } catch {
        print("Playback failed: \(error)")
    }
}

//if let previewVC = previewVC {
//    if let rootVC = UIApplication.shared.windows.first?.rootViewController {
//        rootVC.present(previewVC, animated: true)
//    }
//}
