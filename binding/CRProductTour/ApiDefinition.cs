using System;
using System.Drawing;
using MonoTouch.Foundation;
using MonoTouch.UIKit;
using MonoTouch.ObjCRuntime;
using MonoTouch.CoreGraphics;

namespace CRProductTourBinding {

	[BaseType (typeof (UIView))]
	public partial interface CRBubble {

		[Export ("attachedView", ArgumentSemantic.Retain)]
		UIView AttachedView { get; set; }

		[Export ("title", ArgumentSemantic.Retain)]
		string Title { get; set; }

		[Export ("description", ArgumentSemantic.Retain)]
		string Description { get; set; }

		[Export ("arrowPosition")]
		CRArrowPosition ArrowPosition { get; set; }

		[Export ("color", ArgumentSemantic.Retain)]
		UIColor Color { get; set; }

		[Export ("fontName", ArgumentSemantic.Retain)]
		string FontName { get; set; }

		[Export ("initWithAttachedView:title:description:arrowPosition:andColor:")]
		IntPtr Constructor (UIView view, string title, string description, CRArrowPosition arrowPosition, UIColor color);

		[Export ("size")]
		SizeF Size { get; }

		[Export ("frame")]
		RectangleF Frame { get; }
	}

	[BaseType (typeof (UIView))]
	public partial interface CRProductTour {

		[Export ("bubblesArray", ArgumentSemantic.Retain)]
		NSMutableArray BubblesArray { get; set; }

		[Export ("bubbles")]
		NSMutableArray Bubbles { set; }

		[Export ("isVisible")]
		bool IsVisible { get; }
	}
}