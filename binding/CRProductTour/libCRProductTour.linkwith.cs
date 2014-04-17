using System;
using MonoTouch.ObjCRuntime;

[assembly: LinkWith ("libCRProductTour.a", LinkTarget.ArmV7 | LinkTarget.ArmV7s | LinkTarget.Simulator, Frameworks = "Foundation UIKit CoreGraphics", ForceLoad = true)]
