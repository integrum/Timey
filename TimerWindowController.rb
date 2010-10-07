# AboutWindowsController.rb
# SimpleTimer
#
# Created by Jade Meskill on 9/28/10.
# Copyright 2010 Integrum Technologies, LLC. All rights reserved.

class TimerWindowController < NSWindowController

  attr_accessor :timeLabel, :startButton, :countdownTimer
  attr_accessor :playButton, :pauseButton, :stopButton, :reloadButton
  attr_accessor :appDelegate

  def show(sender)
    self.appDelegate = sender
    NSApp.activateIgnoringOtherApps(true)
    window
    invalidateTimer
    updateDisplay
    addFObservers
    showWindow(sender)
    setWindowLevel
  end
  
  def addFObservers
    NSNotificationCenter.defaultCenter.addObserver(self, selector:(:defaultsChanged), name:"NSUserDefaultsDidChangeNotification", object:nil)
  end
  
  def defaultsChanged
    setWindowLevel
    invalidateTimer
    resetTime
    appDelegate.updateStatusBar
  end
  
  def setWindowLevel
    if NSUserDefaults.standardUserDefaults.boolForKey("stayOnTop")
      window.level = NSModalPanelWindowLevel
    else
      window.level = NSNormalWindowLevel
    end
  end

  def close
    window.close
  end
  
  def updateDisplay
    timeLabel.stringValue = appDelegate.currentTimeAsString
    appDelegate.updateStatusBar
  end
  
  def resetTime
    appDelegate.resetCurrentTime
    updateDisplay
  end
  
  def invalidateTimer
    @countdownTimer.invalidate if @countdownTimer
    playButton.enabled = true
    pauseButton.enabled = false
    stopButton.enabled = false
  end
  
  def startTime
    close if NSUserDefaults.standardUserDefaults.boolForKey("hideOnTimerStart")
    @countdownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector:(:countDown), userInfo:nil, repeats:true)
    playButton.enabled = false
    stopButton.enabled = true
    pauseButton.enabled = true
  end
  
  def startTimer(sender)
    startTime
  end

  def stopTimer(sender)
    invalidateTimer
    resetTime
  end

  def pauseTimer(sender)
    invalidateTimer
  end

  def reloadTimer(sender)
    invalidateTimer
    resetTime
    startTime
  end
  
  def onTimerComplete
    wc = TimerCompleteController.alloc.initWithWindowNibName("TimerCompleteFullScreen")
    wc.show(self)
  end

  def countDown
    appDelegate.currentTime -= 1
    if appDelegate.currentTime <= 0
      appDelegate.currentTime = 0
      invalidateTimer
      updateDisplay
      onTimerComplete
    end
    updateDisplay
  end
  
end

