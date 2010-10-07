# AboutWindowsController.rb
# Timey
#
# Created by Jade Meskill on 9/28/10.
# Copyright 2010 Integrum Technologies, LLC. All rights reserved.


class AboutWindowController < NSWindowController

  attr_accessor :versionLabel

  def show(sender)
    NSApp.activateIgnoringOtherApps(true)
    window.center
    showWindow(sender)
    populateFields
  end

  def close
    window.close
  end

  def populateFields
    bundleVersion = NSBundle.mainBundle.infoDictionary.objectForKey("CFBundleVersion")
    versionLabel.stringValue = "Version #{bundleVersion}"
  end

  def visitWebsite(sender)
    NSWorkspace.sharedWorkspace.openURL(NSURL.URLWithString("http://integrumtech.com/products/Timey?r=timey-app"))
  end

end

