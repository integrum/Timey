# Description:  This is the implementation file for the CustomWindow class, which is our subclass of NSWindow.  We need to subclass
#               NSWindow in order to configure the window properly in #initWithContentRect(contentRect, styleMask:aStyle, backing:bufferingType, defer:flag)
#               to have a custom shape and be transparent.  We also override the #mouseDown and #mouseDragged metohds,
#               to allow for dragging the window by clicking on its content area (since it doesn't have a title bar to drag).

class CustomWindow < NSWindow
  attr_accessor :initialLocation

  # In Interface Builder we set CustomWindow to be the class for our window, so our own initializer is called here.
  # the original method is being extended but still called thanks to the `super` call
  def initWithContentRect(contentRect, styleMask:aStyle, backing:bufferingType, defer:flag)
    # Call NSWindow's version of this function, but pass in the all-important value of NSBorderlessWindowMask
    #for the styleMask so that the window doesn't have a title bar
    
    result = super(NSScreen.mainScreen.frame, NSBorderlessWindowMask, NSBackingStoreBuffered, false)
    # Set the background color to clear so that (along with the setOpaque call below) we can see through the parts
    # of the window that we're not drawing into
    result.setBackgroundColor(NSColor.colorWithDeviceWhite(0.2, alpha:0.7))
    # This next line pulls the window up to the front on top of other system windows.  This is how the Clock app behaves;
    # generally you wouldn't do this for windows unless you really wanted them to float above everything.
    result.setLevel(NSStatusWindowLevel)
    # Let's start with no transparency for all drawing into the window
    result.setAlphaValue(0.9)
    # but let's turn off opaqueness so that we can see through the parts of the window that we're not drawing into
    result.setOpaque(false)
    # and while we're at it, make sure the window has a shadow, which will automatically be the shape of our custom content.
    result.setHasShadow(true)
    result
  end

  # Custom windows that use the NSBorderlessWindowMask can't become key by default.  Therefore, controls in such windows
  # won't ever be enabled by default. Thus, we override this method to change that.
  def canBecomeKeyWindow
    true
  end

end