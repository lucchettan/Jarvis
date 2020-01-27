//
//  AudioRecorder.swift
//  Jarvis0.0
//
//  Created by Florent Frossard on 26/01/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI
import AVFoundation
import Combine


class AudioRecorder: NSObject, ObservableObject{
/* Here we have the recording functions
     -startRecording()                      -> Launch a recording sessions a create a file at a new url to replay what we be recorded
     -stopRecording()                       -> Endup the current recording session fetching the new data with the rest of them
     -fetchRecordings()                     ->
     -deleteRecording(urlsToDelete: [URL])  -> Delete the files at the specified array of URL's
*/
    
    
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    var audioRecorder: AVAudioRecorder!
    var recordings = [Recording]()
    var recording = false {
        didSet {
        objectWillChange.send(self)
        }
    }
    
    override init() {
        super.init()
        fetchRecordings()
    }
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch { print("Failed to set up recording session") }
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")).m4a")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()
            recording = true
        } catch { print("Could not start recording") }
    }
    
    
    func stopRecording() {
        audioRecorder.stop()
        recording = false
        fetchRecordings()
    }

    func fetchRecordings() {
        recordings.removeAll()
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for audio in directoryContents {
            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
            recordings.append(recording)
        }
        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
        objectWillChange.send(self)
    }
    

    func deleteRecording(urlsToDelete: [URL]) {
        for url in urlsToDelete {
            print(url)
            do { try FileManager.default.removeItem(at: url) } catch { print("File could not be deleted!") }
        }
        fetchRecordings()
    }
}
    
  


