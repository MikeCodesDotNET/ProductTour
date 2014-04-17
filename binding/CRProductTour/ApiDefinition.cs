using System;
using System.Drawing;
using MonoTouch.ObjCRuntime;
using MonoTouch.Foundation;
using MonoTouch.UIKit;

namespace CRProductTour
{
	[BaseType (typeof (UIView), Name="CRBubble")]
	public partial interface Bubble {

		[Export ("attachedView", ArgumentSemantic.Retain)]
		UIView AttachedView { get; set; }

		[Export ("title", ArgumentSemantic.Retain)]
		string Title { get; set; }

		[Export ("description", ArgumentSemantic.Retain)]
		string Description { get; set; }

		[Export ("arrowPosition")]
		ArrowPosition ArrowPosition { get; set; }

		[Export ("color", ArgumentSemantic.Retain)]
		UIColor Color { get; set; }

		[Export ("fontName", ArgumentSemantic.Retain)]
		string FontName { get; set; }

		[Export ("initWithAttachedView:title:description:arrowPosition:andColor:")]
		IntPtr Constructor (UIView view, string title, string description, ArrowPosition arrowPosition, [NullAllowed] UIColor color);

		[Export ("size")]
		SizeF Size { get; }

		[Export ("frame")]
		RectangleF Frame { get; }
	}

	[BaseType (typeof (UIView), Name="CRProductTour")]
	public partial interface ProductTour {

		[Export ("bubblesArray", ArgumentSemantic.Retain)]
		NSMutableArray BubblesArray { get; set; }

		[Export ("bubbles")]
		NSMutableArray Bubbles { set; }

		[Export ("visible")]
		bool Visible { set; }

		[Export ("isVisible")]
		bool IsVisible { get; }
	}

}

