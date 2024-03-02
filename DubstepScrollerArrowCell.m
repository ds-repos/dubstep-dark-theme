#include <AppKit/AppKit.h>
#include "DubstepScrollerArrowCell.h"
#include "Dubstep.h"
#import "NSButtonCell+Dubstep.h"

@implementation DubstepScrollerArrowCell

- (void) setArrowType: (DubstepScrollerArrowType) t
{
  scroller_arrow_type = t;
}
- (void) drawBezelWithFrame: (NSRect)cellFrame inView: (NSView *)controlView
{
  GSThemeControlState buttonState = [self themeControlState];
  NSBezierPath * path = [self pathForFrame: cellFrame];
  [(Dubstep*)[GSTheme theme] drawPathButton: path
					in: self
				     state: buttonState];
}
  
- (NSBezierPath*) pathForFrame: (NSRect)cellFrame
{

  CGFloat r = 3;
  cellFrame = NSInsetRect(cellFrame, 1, 1);
  cellFrame.origin.x += 0.5;
  cellFrame.origin.y += 0.5;
  NSRect innerRect = NSInsetRect(cellFrame, r, r);
  NSBezierPath* path = [NSBezierPath bezierPath];
  switch(scroller_arrow_type)
    {
      case DubstepScrollerArrowLeft:
        cellFrame.origin.x += 1.0;
        [path appendBezierPathWithArcWithCenter: NSMakePoint(NSMinX(innerRect), NSMinY(innerRect))
                                         radius: r
                                     startAngle: 180
                                       endAngle: 270];
        [path lineToPoint: NSMakePoint(NSMaxX(cellFrame), NSMinY(cellFrame))];
        [path lineToPoint: NSMakePoint(NSMaxX(cellFrame), NSMaxY(cellFrame))];
        [path appendBezierPathWithArcWithCenter: NSMakePoint(NSMinX(innerRect), NSMaxY(innerRect))
                                         radius: r
                                     startAngle: 90
                                       endAngle: 180];
        [path closePath];
        break;
      case DubstepScrollerArrowRight:
        cellFrame.origin.x -= 1.0;
        [path moveToPoint: NSMakePoint(NSMinX(cellFrame), NSMinY(cellFrame))];
        [path appendBezierPathWithArcWithCenter: NSMakePoint(NSMaxX(innerRect), NSMinY(innerRect))
                                         radius: r
                                     startAngle: 270
                                       endAngle: 360];
        [path appendBezierPathWithArcWithCenter: NSMakePoint(NSMaxX(innerRect), NSMaxY(innerRect))
                                         radius: r
                                     startAngle: 0
                                       endAngle: 90];
        [path lineToPoint: NSMakePoint(NSMinX(cellFrame), NSMaxY(cellFrame))];
        break;
      case DubstepScrollerArrowDown:
        cellFrame.origin.y -= 1.0;
        [path moveToPoint: NSMakePoint(NSMinX(cellFrame), NSMinY(cellFrame))];
        [path moveToPoint: NSMakePoint(NSMaxX(cellFrame), NSMinY(cellFrame))];
        [path appendBezierPathWithArcWithCenter: NSMakePoint(NSMaxX(innerRect), NSMaxY(innerRect))
                                         radius: r
                                     startAngle: 0
                                       endAngle: 90];
        [path appendBezierPathWithArcWithCenter: NSMakePoint(NSMinX(innerRect), NSMaxY(innerRect))
                                         radius: r
                                     startAngle: 90
                                       endAngle: 180];
        [path lineToPoint: NSMakePoint(NSMinX(cellFrame), NSMinY(cellFrame))];
        break;
      case DubstepScrollerArrowUp:
        cellFrame.origin.y += 1.0;
        [path appendBezierPathWithArcWithCenter: NSMakePoint(NSMinX(innerRect), NSMinY(innerRect))
                                         radius: r
                                     startAngle: 180
                                       endAngle: 270];
        [path appendBezierPathWithArcWithCenter: NSMakePoint(NSMaxX(innerRect), NSMinY(innerRect))
                                         radius: r
                                     startAngle: 270
                                       endAngle: 360];
        [path lineToPoint: NSMakePoint(NSMaxX(cellFrame), NSMaxY(cellFrame))];
        [path lineToPoint: NSMakePoint(NSMinX(cellFrame), NSMaxY(cellFrame))];
        [path closePath];
        break;
    }
    return path;
}
@end
