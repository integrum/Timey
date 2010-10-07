# AppDelegate.rb
# SimpleTimer
#
# Created by Jade Meskill on 9/28/10.
# Copyright 2010 Integrum Technologies, LLC. All rights reserved.


class AppDelegate

  attr_accessor :statusMenu, :aboutWindowController, :timerWindowController, :preferencesWindowController

  def self.registrationDefaults
    {
      "showStatusBarMenu"   => true,
      "defaultStartingTime" => 15,
      "stayOnTop"           => false,
      "hideOnTimerStart"    => false,
      "menuBarDisplayType"  => 0
    }
  end

  def applicationWillFinishLaunching(aNotification)
    NSUserDefaults.standardUserDefaults.registerDefaults(AppDelegate.registrationDefaults)
  end

  def applicationDidFinishLaunching(aNotification)
    if NSUserDefaults.standardUserDefaults.boolForKey("showStatusBarMenu")
      createStatusBarMenu
    end
    # HACK: Load window and immediately close it so menu validation
    # doesn't accidentally show it.
    # fuzzyWindowController.window.close

    # Force loading of help index for searching
    NSHelpManager.sharedHelpManager

    showTimer(self)

    #unless NSUserDefaults.standardUserDefaults.boolForKey("hasBeenRunAtLeastOnce")
    #end
  end

  def createStatusBarMenu
    statusItem =
      NSStatusBar.systemStatusBar.statusItemWithLength(NSVariableStatusItemLength)
    statusItem.setMenu(statusMenu)
    statusItem.setHighlightMode(true)
    statusItem.setToolTip("SimpleTimer")
    statusItem.setImage(NSImage.imageNamed("statusItemIcon.png"))
  end

  ##
  # Do something with the dropped file.

  def application(sender, openFile:path)
#    fuzzyWindowController.show(self)
#    fuzzyWindowController.loadFilesFromProjectRoot(path)
  end

  def showPreferences(sender)
    # TODO: If visible
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
    NSApp.activateIgnoringOtherApps(true)
  end

  def showReleaseNotesWindow(sender)
    if fuzzyWindowController.respondsToSelector(:close)
      fuzzyWindowController.close
    end
    if !@releaseNotesWindowController
      self.releaseNotesWindowController =
        windowControllerForNib("ReleaseNotesWindow")
    end
    releaseNotesWindowController.show(self)
  end

  def showAbout(sender)
    if (!aboutWindowController)
      self.aboutWindowController = windowControllerForNib("AboutWindow")
    end
    aboutWindowController.show(self)
  end

  def refreshFileList(sender)
    fuzzyWindowController.refreshFileList(sender)
  end

  ##
  # Returns true if the menu item should be enabled.

  def validateMenuItem(menuItem)
    return true
  end
  
  private

  # Given +nibName+, allocate and initialize the appropriate window
  # controller for the NIB.
  def windowControllerForNib nibName
    klass = Object.const_get "#{nibName}Controller"
    klass.alloc.initWithWindowNibName(nibName)
  end

  def fuzzyWindowController
    @fuzzyWindowController ||= windowControllerForNib("FuzzyWindow")
  end

end

