# AboutWindowsController.rb
# SimpleTimer
#
# Created by Jade Meskill on 9/28/10.
# Copyright 2010 Integrum Technologies, LLC. All rights reserved.


class TimerWindowController < NSWindowController

  attr_accessor :timeLabel, :startButton, :countdownTimer, :currentTime
  attr_accessor :playButton, :pauseButton, :stopButton, :reloadButton

  def show(sender)
    NSApp.activateIgnoringOtherApps(true)
    window.center
    invalidateTimer
    resetTime
    showWindow(sender)
  end

  def close
    window.close
  end

  def updateDisplay
    m = sprintf("%02i", (currentTime % 3600) / 60)
    s = sprintf("%02i", (currentTime % 60))
    timeLabel.stringValue = "#{m}:#{s}"
  end
  
  def resetTime
    @currentTime = NSUserDefaults.standardUserDefaults.integerForKey("defaultStartingTime") * 60
    updateDisplay
  end
  
  def invalidateTimer
    @countdownTimer.invalidate if @countdownTimer
    playButton.enabled = true
    pauseButton.enabled = false
    stopButton.enabled = false
  end
  
  def startTime
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
    @currentTime -= 1
    if @currentTime <= 0
      @currentTime = 0
      invalidateTimer
      updateDisplay
      onTimerComplete
    end
    updateDisplay
  end

end

