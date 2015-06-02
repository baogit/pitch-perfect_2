//
//  PlaySoundsViewController.swift
//  PitchPerfect2
//
//  Created by bao on 5/31/15.
//  Copyright (c) 2015 baoca. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    
    var audioFile: AVAudioFile!
    
    @IBAction func playDarthAudio(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
  
    @IBAction func playChipAudio(sender: AnyObject) {
    playAudioWithVariablePitch(1000)
    }
    
        func playAudioWithVariablePitch (pitch: Float) {
            audioPlayer.stop()
            audioEngine.stop()
            audioEngine.reset()
            
             var audioPlayerNode = AVAudioPlayerNode()
            audioEngine.attachNode(audioPlayerNode)
            
            var changePitchEffect = AVAudioUnitTimePitch()
            changePitchEffect.pitch = pitch
            audioEngine.attachNode(changePitchEffect)
            
            audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
            audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
    audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
    audioEngine.startAndReturnError(nil)
            
    audioPlayerNode.play()
    
    }
    
    @IBAction func playFastAudio(sender: AnyObject) {
        audioPlayer.stop()
        audioEngine.stop()
        audioPlayer.rate = 2
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        audioPlayer.stop()
        audioEngine.stop()
    }
    
    @IBAction func playSlowAudio(sender: AnyObject) {
        audioPlayer.stop()
        audioEngine.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    override func viewDidLoad() {
        super.viewDidLoad()


        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl , error: nil )
        audioPlayer.enableRate = true
        
         audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    


}
