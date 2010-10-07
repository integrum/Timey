# AboutWindowsController.rb
# Timey
#
# Created by Jade Meskill on 9/28/10.
# Copyright 2010 Integrum Technologies, LLC. All rights reserved.


class TimerCompleteController < NSWindowController

  attr_accessor :stopButton, :reloadButton, :timerWindow, :displayLabel

  def show(sender)
    self.timerWindow = sender
    NSApp.activateIgnoringOtherApps(true)
    window.center
    showWindow(sender)
  end

  def close
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

  # Custom windows that use the NSBorderlessWindowMask can't become key by default.  Therefore, controls in such windows
  # won't ever be enabled by default. Thus, we override this method to change that.
  def canBecomeKeyWindow
    true
  end

end

