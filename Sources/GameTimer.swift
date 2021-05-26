//
//  GameTimer.swift
//  TimeFlies
//
//  Created by Shaun Ku on 2021/4/8.
//

import Foundation
import AVFoundation

class GameTimer: ObservableObject
{
    private var frequency:Double = 0.001
    private var timer: Timer?
    private var startDate: Date?
    @Published public var targetTime:Double
    @Published public var timeElapsed:Double = 0.000
    @Published public var overTime = false
    @Published public var isTimeRunning:Bool = false
    @Published public var soundHint:Bool = false
    @Published public var disappearTime:Double = 0.000
    @Published public var timeDisappear:Bool = false
    init(targetTime:Double){
        self.targetTime = targetTime
    }
    func timerStart(){
        timeElapsed = 0.000
        isTimeRunning = true
        overTime = false
        timeDisappear = false
        startDate = Date()
        if(soundHint){
            AVPlayer.setupSoundHint(volume: 1)
            AVPlayer.shQueuePlayer.seek(to: .zero)
            AVPlayer.shQueuePlayer.play()
        }
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true){
            timer in
            if let startDate = self.startDate {
                self.timeElapsed = Double(timer.fireDate.timeIntervalSince1970-startDate.timeIntervalSince1970)
            }
            if(!(self.disappearTime==0.000)&&(self.targetTime-self.timeElapsed)<=self.disappearTime+0.500){
                self.timeDisappear = true
            }
            if(self.timeElapsed>=self.targetTime+5.00){
                self.overTime = true
                self.timerStop()
            }
        }
    }
    
    func timerStop(){
        isTimeRunning = false
        timeDisappear = false
        if(soundHint){
            AVPlayer.shQueuePlayer.pause()
        }
        timer?.invalidate()
        timer = nil
    }
}
