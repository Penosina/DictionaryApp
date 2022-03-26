import AVFoundation

final class AudioService {
    // MARK: - Properties
    private var audioPlayer: AVPlayer?
    
    // MARK: - Public Methods
    func playSound(audioURL: URL) {
        let playerItem = AVPlayerItem(url: audioURL)
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer?.play()
    }
}
