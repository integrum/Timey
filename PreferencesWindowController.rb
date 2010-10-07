# PreferencesWindowController.rb
# Timey
#
# Created by Jade Meskill on 9/29/10.
# Copyright 2010 Integrum Technologies, LLC. All rights reserved.

require 'NSWindowControllerHelper'

class PreferencesWindowController < NSWindowController

  attr_accessor :updateView, :timerView, :appearanceView
  attr_accessor :updateToolbarItem, :timerToolbarItem, :appearanceToolbarItem
  attr_accessor :currentView
  
  include NSWindowControllerHelper

  def show(sender)
    NSApp.activateIgnoringOtherApps(true)
    window.center
    showWindow(sender)
  end

  def windowDidLoad
    switchToView(timerView, item:timerToolbarItem, animate:false)
  end
  
  def windowDidResignKey(notification)
    # TODO: Text fields should resign focus and file lists should be reloaded
    window.makeFirstResponder(nil)
  end


  def close
    window.close
  end
  
  def showAppearanceView(sender)
    switchToView(appearanceView, item:appearanceToolbarItem, animate:false)  
  end
  
  def showUpdateView(sender)
    switchToView(updateView, item:updateToolbarItem, animate:false)  
  end
  
  def showTimerView(sender)
    switchToView(timerView, item:timerToolbarItem, animate:false)
  end
  
  def switchToView(view, item:toolbarItem, animate:animate)
    window.toolbar.setSelectedItemIdentifier(toolbarItem.itemIdentifier)

    if (currentView.respondsToSelector("removeFromSuperview"))
      currentView.removeFromSuperview
    end

    view.setFrameOrigin([0,0])
    window.contentView.addSubview(view)
    setCurrentView(view)

    borderHeight = window.frame.size.height - window.contentView.frame.size.height

    newWindowFrame = window.frame
    newWindowFrame.size.height = view.frame.size.height + borderHeight
    newWindowFrame.origin.y += window.frame.size.height - newWindowFrame.size.height

    window.setFrame(newWindowFrame, display:true, animate:true)
  end
  
end

