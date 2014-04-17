using System;
using System.Drawing;
using MonoTouch.Foundation;
using MonoTouch.UIKit;
using CRProductTour;

namespace Sample
{
	public class FirstViewController : UIViewController
	{
		ProductTour productTour;

		UIButton AwesomeButton;
		UIButton HelpButton;
		UIButton KindaAwesomeButton;

		public FirstViewController ()
		{
			Title = "First";
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			View.BackgroundColor = UIColor.White;

			AwesomeButton = new UIButton (UIButtonType.RoundedRect) {
				Frame = new RectangleF (100, 25, 125, 15)
			};
			AwesomeButton.SetTitle ("Awesome", UIControlState.Normal);
			AwesomeButton.SetTitleColor (UIColor.Black, UIControlState.Normal);
			AwesomeButton.TouchUpInside += delegate(object sender, EventArgs e) {
				new UIAlertView ("", "Whoops, I lied.", null, "Jerk", null).Show ();
			};


			KindaAwesomeButton = new UIButton (UIButtonType.RoundedRect) {
				Frame = new RectangleF (100, 225, 125, 15)
			};
			KindaAwesomeButton.SetTitle ("Kinda Awesome", UIControlState.Normal);
			KindaAwesomeButton.SetTitleColor (UIColor.Black, UIControlState.Normal);
			KindaAwesomeButton.TouchUpInside += delegate(object sender, EventArgs e) {
				new UIAlertView ("", "Lied again.", null, "Jerk", null).Show ();
			};

			HelpButton = new UIButton (UIButtonType.RoundedRect) {
				Frame = new RectangleF (5, 300, 100, 15)
			};
			HelpButton.SetTitle ("Toggle Help", UIControlState.Normal);
			HelpButton.SetTitleColor (UIColor.Black, UIControlState.Normal);
			HelpButton.TouchUpInside += delegate(object sender, EventArgs e) {
				ToggleHelp ();
			};

			SetupProductTour ();

			View.Add (AwesomeButton);
			View.Add (KindaAwesomeButton);
			View.Add (HelpButton);
		}

		void SetupProductTour ()
		{
			productTour = new ProductTour ();
			productTour.Frame = new RectangleF (0, 0, View.Bounds.Width, View.Bounds.Height);

			var bubble = new Bubble (AwesomeButton, "THE FIRST BUTTON", "Click this button for more\nawesome all around!", ArrowPosition.Top, null);
			bubble.FontName = "SourceSansPro-Bold";

			var bubble2 = new Bubble (KindaAwesomeButton, "THE SECOND BUTTON", "Click this button. Just do it.", ArrowPosition.Bottom, null);
			bubble2.FontName = "SourceSansPro-Bold";

			var bubble3 = new Bubble (HelpButton, "HELP BUTTON", "Click to toggle.", ArrowPosition.Right, null);
			bubble3.FontName = "SourceSansPro-Bold";

			var bubbleArray = new NSMutableArray (3);
			bubbleArray.Add (bubble);
			bubbleArray.Add (bubble2);
			bubbleArray.Add (bubble3);
			productTour.Bubbles = bubbleArray;

			Add (productTour);
		}

		void ToggleHelp ()
		{
			var visible = !productTour.IsVisible;
			productTour.Visible = visible;
		}
	}
}

