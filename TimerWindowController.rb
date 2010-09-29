# AboutWindowsController.rb
# SimpleTimer
#
# Created by Jade Meskill on 9/28/10.
# Copyright 2010 Integrum Technologies, LLC. All rights reserved.


class TimerWindowController < NSWindowController

  attr_accessor :timeLabel, :startButton, :countdownTimer, :startingTime

  def show(sender)
    NSApp.activateIgnoringOtherApps(true)
    window.center
    showWindow(sender)
    @startingTime = 15 * 60
    populateFields
  end

  def close
    window.close
  end

  def populateFields
    m = sprintf("%02i", (startingTime % 3600) / 60)
    s = sprintf("%02i", (startingTime % 60))
    timeLabel.stringValue = "#{m}:#{s}"
  end
  
  def startTimer(sender)
    if startButton.title == "Stop"
      startButton.title = "Start"
      @countdownTimer.invalidate if @countdownTimer
    else
      @countdownTimer.invalidate if @countdownTimer
      @countdownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector:(:countDown), userInfo:nil, repeats:true)
      startButton.title = "Stop"
    end
  end

  def countDown
    @startingTime -= 1
    populateFields
  end

end

