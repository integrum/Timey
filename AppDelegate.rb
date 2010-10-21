# Copyright (c) 2010, Integrum Technologies, LLC
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, are permitted provided
# that the following conditions are met:
#
# Redistributions of source code must retain the above copyright notice, this list of conditions and the
# following disclaimer.
#
# Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided with the distribution.
#
# Neither the name of the <ORGANIZATION> nor the names of its contributors may be used to endorse or promote
# products derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
# DAMAGE.

# AppDelegate.rb
# Timey
#
# Created by Jade Meskill on 9/28/10.
# Copyright 2010 Integrum Technologies, LLC. All rights reserved.


class AppDelegate

  attr_accessor :statusMenu, :aboutWindowController, :timerWindowController, :preferencesWindowController
  attr_accessor :statusItem, :currentTime, :statusBarMenuType, :origStartingTime

  def self.registrationDefaults
    {
      "showStatusBarMenu"   => true,
      "defaultStartingTime" => 15,
      "stayOnTop"           => false,
      "hideOnTimerStart"    => false,
      "menuBarDisplayType"  => 0,
      "timerMessage"        => "Timey Time!"
    }
  end

  def applicationWillFinishLaunching(aNotification)
    NSUserDefaults.standardUserDefaults.registerDefaults(AppDelegate.registrationDefaults)
  end

  def applicationDidFinishLaunching(aNotification)
    if NSUserDefaults.standardUserDefaults.boolForKey("showStatusBarMenu")
      createStatusBarMenu
    end

    # Force loading of help index for searching
    NSHelpManager.sharedHelpManager
    
    resetCurrentTime

    showTimer(self)
  end

  def createStatusBarMenu
    self.statusItem = NSStatusBar.systemStatusBar.statusItemWithLength(NSVariableStatusItemLength)
    self.statusItem.setMenu(statusMenu)
    self.statusItem.setHighlightMode(true)
    self.statusItem.setToolTip("Timey")
  end
  
  def updateStatusBar
    self.statusBarMenuType = NSUserDefaults.standardUserDefaults.integerForKey("menuBarDisplayType")
    self.statusItem.setImage(NSImage.imageNamed("statusItemIcon.png")) if self.statusBarMenuType < 2
    self.statusItem.setTitle(currentTimeAsString) if self.statusBarMenuType > 0
    self.statusItem.setImage(nil) if self.statusBarMenuType == 2
    self.statusItem.setTitle(nil) if self.statusBarMenuType == 0
  end

  def application(sender, openFile:path)
  end

  def showPreferences(sender)
    if !@preferencesWindowController
      self.preferencesWindowController =
        windowControllerForNib("PreferencesWindow")
    end
    preferencesWindowController.show(self)
  end

  def showTimer(sender)
    self.timerWindowController =
      windowControllerForNib("TimerWindow")
    timerWindowController.show(self)
  end
  
  def showTimey(sender)
    self.timerWindowController.showWindow(self)
    NSApp.activateIgnoringOtherApps(true)
  end

  def hideTimey(sender)
    self.timerWindowController.close
  end

  def showAbout(sender)
    if (!aboutWindowController)
      self.aboutWindowController = windowControllerForNib("AboutWindow")
    end
    aboutWindowController.show(self)
  end

  def validateMenuItem(menuItem)
    return true
  end
  
  def currentTimeAsString
    minutes = (currentTime % 3600) / 60
    seconds = (currentTime % 60)
    minutes = 60 if currentTime == 3600
    m = sprintf("%02i", minutes)
    s = sprintf("%02i", seconds)
    "#{m}:#{s}"
  end
  
  def resetCurrentTime
    @origStartingTime = NSUserDefaults.standardUserDefaults.integerForKey("defaultStartingTime")
    @currentTime = @origStartingTime * 60 * 0
  end
  
  private
  def windowControllerForNib nibName
    klass = Object.const_get "#{nibName}Controller"
    klass.alloc.initWithWindowNibName(nibName)
  end

end

