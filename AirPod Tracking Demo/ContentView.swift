//
//  ContentView.swift
//  AirPod Tracking Demo
//
//  Created by Lucas Goldner on 19.10.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var motionTracker = MotionTracker.init()
    
    var body: some View {
        VStack {
            if(motionTracker.isAvailable) {
                VStack {
                    HStack {
                        Text("Connected to airpods")
                        Image(systemName: "airpodspro")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        
                    }
                    Text(motionTracker.infos)
                }
                
            } else {
                HStack {
                    Text("Looking for airpods...")
                    Image(systemName: "airpodspro")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
