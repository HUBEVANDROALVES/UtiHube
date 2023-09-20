//
//  ContentView.swift
//  musicAmbient
//
//  Created by hubevandro on 18/09/23.
//
import SwiftUI
import AVFoundation

struct ContentView: View {
    var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = true
    
    init() {
        let musicURL = Bundle.main.url(forResource: "music", withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: musicURL!)
            audioPlayer?.play() //  ja inicia tocando
            
    
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack {
            Button(action: {
                if isPlaying {
                    audioPlayer?.pause()// para a musica
                } else {
                    audioPlayer?.play()// toca a musica
                }
                isPlaying.toggle() // intercarla para e toca
                
            }) {
                HStack {
                    Image(isPlaying ? "speaker" : "speakStop" )
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
        }
    }
        func onDisappear() {
                audioPlayer?.stop()
        
    }
}





