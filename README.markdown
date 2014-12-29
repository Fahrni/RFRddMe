RFRddMe
=========================

* Created by [Rob Fahrni](http://fahrni.me)

What is RFRddMe?
-------------------------

RFRddMe is an Objective-C wrapper for [rdd.me](http://ww1.readability.com/publishers/rdd), the Readability Shortener Service. You'll be able to shorten and expand URL's with the Readability Service for your own Cocoa applications.

It allows you to do the following:

* Shorten a URL
* Expand a URL

How Do I Use It?
-------------------------

Unfortunately there is no sample project, but there are unit tests that execute the two methods this library implements. See RFRddMeTests.

1. Create a new Xcode 4 workspace and include RFRddMe. It's not a Framework, just include the source.
2. Drag RFRddMe.h into your main app's project. This will let you communicate with [rdd.me](http://ww1.readability.com/publishers/rdd).
3. Implement RFRddMeProtocol. There are only three methods to implement. See RFRddMeProtocol.h for the protocol and RFRddMeTests.h/.m for an implementation.
4. Include RFRddMeShortUrl.h, RFRddMeExpandedUrl.h, and RFRddMeError.h in your implementation of RFRddMeProtocol.
5. Write an application that uses the service.

What kind of license are we talking about here?
-------------------------
It's a BSD license, enjoy. See the [LICENSE](https://github.com/Fahrni/RFRddMe/blob/master/LICENSE) file for details.


Find this useful?
-------------------------

If you find this useful I'd love to hear from you! Please contact me, rob@applecorelabs.com, and let me know how you're using it. I'm also available for iOS work, visit [Apple Core Labs](http://applecorelabs.com).

All The Other Stuff
-------------------------

If you have any ideas for how to improve this, please file issues. Patches are always welcome.

---------------------------------------

* 11/19/2011 - **1.0** Initial release
