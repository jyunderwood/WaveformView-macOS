//
//  AppDelegate.swift
//  Example-macOS
//
//  Created by Jonathan on 9/5/16.
//  Copyright © 2016 Jonathan Underwood. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var waveformWindowController: WaveformWindowController!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let waveformWindowController = WaveformWindowController(windowNibName: "WaveformWindowController")
        waveformWindowController.showWindow(self)
        self.waveformWindowController = waveformWindowController
    }
}
