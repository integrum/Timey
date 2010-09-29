# AboutWindowsController.rb
# SimpleTimer
#
# Created by Jade Meskill on 9/28/10.
# Copyright 2010 Integrum Technologies, LLC. All rights reserved.


class TimerCompleteController < NSWindowController

  attr_accessor :stopButton, :reloadButton, :timerWindow, :displayLabel

  def show(sender)
    self.timerWindow = sender
    NSApp.activateIgnoringOtherApps(true)
    showWindow(sender)
    window.backgroundColor = NSColor.clearColor
    window.setOpaque(false)
    window.contentView.enterFullScreenMode(NSScreen.mainScreen, withOptions:nil)
  end

  def close
    window.contentView.exitFullScreenModeWithOptions(nil)
    window.close
  end

  def stopTimer(sender)
    close
    timerWindow.stopTimer(sender)
  end

  def reloadTimer(sender)
    close
    timerWindow.reloadTimer(sender)
  end

end

