//
//  ContentView.swift
//  musicAmbient
//
//  Created by hubevandro on 18/09/23.
//
import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject private var audioManager = AudioManager()
    
    var body: some View {
        Sound()
            .environmentObject(audioManager)
    }
}

struct Sound: View {
    @EnvironmentObject var audioManager: AudioManager
    var body: some View {
        VStack {
            Button(action: {
                if audioManager.isPlaying {
                    audioManager.audioPlayer?.pause()// para a musica
                } else {
                    audioManager.audioPlayer?.play()// toca a musica
                }
                audioManager.isPlaying.toggle() // intercarla para e toca
                }){
                HStack {
                    Image(audioManager.isPlaying ? "speaker" : "speakStop")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                
            }
        }
    }
}
class AudioManager: ObservableObject {
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = true
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(pauseSong), name: UIApplication.didEnterBackgroundNotification, object: nil)
        let musicURL = Bundle.main.url(forResource: "music", withExtension: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: musicURL!)
            // audioPlayer?.play() //  ja inicia tocando
        } catch {
            print(error)
        }
    }
    
    @objc func pauseSong() {
        audioPlayer?.stop()
    }
}





