//
//  ViewController.swift
//  PitchPerfect2
//
//  Created by bao on 5/31/15.
//  Copyright (c) 2015 baoca. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
   
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    @IBAction func recordButton(sender: AnyObject) {
   recordingProgress.hidden = false
        tabToRecord.hidden = true
        stopButton.hidden = false
        recordingButtonProgress.enabled = false
      
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        // save
        if (flag) {
        recordedAudio = RecordedAudio()
        recordedAudio.filePathUrl = recorder.url
        recordedAudio.title = recorder.url.lastPathComponent
        
        
        // move to screen
        self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            println("Recording was not successful")
            recordingButtonProgress.enabled = true
            stopButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        recordingProgress.hidden = true
        recordingButtonProgress.enabled = true
        tabToRecord.hidden = false
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
    }
    
    
    @IBOutlet weak var tabToRecord: UILabel!
    @IBOutlet weak var recordingButtonProgress: UIButton!
    @IBOutlet weak var recordingProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

