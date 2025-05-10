import ReplayKit
import SwiftUI

struct ScreenRecorderView: View {
    let recorder = RPScreenRecorder.shared()
    @State private var isRecording = false

    var body: some View {
        Button(action: {
            isRecording ? stopRecording() : startRecording()
        }) {
            Text(isRecording ? "Stop Recording" : "Start Recording")
                .padding()
                .background(isRecording ? Color.red : Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }

    func startRecording() {
        guard recorder.isAvailable else {
            print("Recording is not available.")
            return
        }

        recorder.isMicrophoneEnabled = true
        recorder.startRecording { error in
            if let error = error {
                print("Error starting recording: \(error)")
            } else {
                isRecording = true
            }
        }
    }

    func stopRecording() {
        recorder.stopRecording { previewVC, error in
            if let error = error {
                print("Error stopping recording: \(error)")
                return
            }

            isRecording = false

            if let previewVC = previewVC {
                if let rootVC = UIApplication.shared.windows.first?.rootViewController {
                    rootVC.present(previewVC, animated: true)
                }
            }
        }
    }
}
