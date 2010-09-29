# PreferencesWindowController.rb
# Timey
#
# Created by Jade Meskill on 9/29/10.
# Copyright 2010 Integrum Technologies, LLC. All rights reserved.


class PreferencesWindowController < NSWindowController

  def show(sender)
    NSApp.activateIgnoringOtherApps(true)
    window.center
    showWindow(sender)
  end

  def close
    window.close
  end
  
end

