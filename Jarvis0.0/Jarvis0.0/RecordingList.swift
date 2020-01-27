//
//  RecordingList.swift
//  Jarvis0.0
//
//  Created by Florent Frossard on 26/01/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct RecordingList: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        
        List {
            ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                RecordingRow(audioURL: recording.fileURL)
            }
        .onDelete(perform: delete)
         }
      }
        
    func delete(at offsets: IndexSet) {
           
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
      }
    }

struct RecordingList_Previews: PreviewProvider {
    
    static var previews: some View {
        
        RecordingList(audioRecorder: AudioRecorder())
    }
}

struct RecordingRow: View {
    
    var audioURL: URL
    
    @ObservedObject var audioPlayer = AudioPlayer()
    
    var body: some View {
        
     HStack {
            Text("\(audioURL.lastPathComponent)")
            Spacer()
            
        if audioPlayer.isPlaying == false {
            Button(action: {
                self.audioPlayer.startPlayback(audio: self.audioURL)
            })
            {
                Image(systemName: "play.circle")
                    .imageScale(.large)
            }
        } else {
            
            Button(action: {
               self.audioPlayer.stopPlayback()
            }) {
                Image(systemName: "stop.fill")
                    .imageScale(.large)
            }
         }
      }
    }
 }
    

