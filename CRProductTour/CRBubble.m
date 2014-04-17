//
//  CRBubble.m
//  ProductTour
//
//  Created by Clément Raussin on 12/02/2014.
//  Copyright (c) 2014 Clément Raussin. All rights reserved.
//

#import "CRBubble.h"
#define CR_PADDING 8
#define CR_RADIUS 6
#define COLOR_BLUE [UIColor colorWithRed:0.2314 green:0.6039 blue:0.7294 alpha:1.0]
#define COLOR_WHITE [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0]
#define CR_TITLE_FONT_SIZE 17
#define CR_DESCRIPTION_FONT_SIZE 15

#define SHOW_ZONE NO

@implementation CRBubble
@synthesize fontName;

#pragma mark - Constructor


-(id)initWithAttachedView:(UIView*)view title:(NSString*)title description:(NSString*)description arrowPosition:(CRArrowPosition)arrowPosition andColor:(UIColor*)color
{
    self = [super init];
    if(self)
    {
        if(color!=nil)
            self.color=color;
        else
            self.color=COLOR_BLUE;
        self.attachedView = view;
        self.title = title;
        self.description = description;
        self.arrowPosition = arrowPosition;
        [self setBackgroundColor:[UIColor clearColor]];
        if(fontName==NULL)
            fontName=@"BebasNeue";
    }
    
    float actualXPosition = [self offsets].width+CR_PADDING;
    float actualYPosition = [self offsets].height+CR_PADDING;
    float actualWidth =self.frame.size.width;
    float actualHeight = CR_TITLE_FONT_SIZE;
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(actualXPosition, actualYPosition, actualWidth, actualHeight)];
    [titleLabel setTextColor:COLOR_WHITE];
    [titleLabel setFont:[UIFont fontWithName:fontName size:CR_TITLE_FONT_SIZE]];
    [titleLabel setText:title];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:titleLabel];
    
    
    
    stringArray=[self.description componentsSeparatedByString:@"\n"];
    
    for (NSString *descriptionLine in stringArray) {
        
        actualYPosition+=actualHeight;
        
        actualWidth =self.frame.size.width;
        actualHeight =CR_DESCRIPTION_FONT_SIZE;
        
        UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(actualXPosition, actualYPosition, actualWidth, actualHeight+CR_ARROW_SPACE)];
        [descriptionLabel setTextColor:COLOR_WHITE];
        [descriptionLabel setFont:[UIFont systemFontOfSize:CR_DESCRIPTION_FONT_SIZE]];
        [descriptionLabel setText:descriptionLine];
        [descriptionLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:descriptionLabel];
        
    }
    
    if(SHOW_ZONE){
        UIView *myview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.attachedView.frame.size.width, self.attachedView.frame.size.height)];
        [myview setBackgroundColor:self.color];
        [myview setAlpha:0.3];
        [myview setUserInteractionEnabled:NO];
        [self.attachedView addSubview:myview];
    }
    
    [self setFrame:[self frame]];
    [self setNeedsDisplay];
    return self;
}


#pragma mark - Customs methods


-(void)setFontName:(NSString *)theFontName
{
    fontName=theFontName;
    [titleLabel setFont:[UIFont fontWithName:fontName size:CR_TITLE_FONT_SIZE]];
    
}

#pragma mark - Drawing methods


-(CGRect)frame
{
    //Calculation of the bubble position
    float x = self.attachedView.frame.origin.x;
    float y = self.attachedView.frame.origin.y;
    
    if(self.arrowPosition==CRArrowPositionLeft||self.arrowPosition==CRArrowPositionRight)
    {
        y+=self.attachedView.frame.size.height/2-[self size].height/2;
        x+=(self.arrowPosition==CRArrowPositionLeft)? CR_ARROW_SPACE+self.attachedView.frame.size.width : -(CR_ARROW_SPACE*2+[self size].width);
        
    }else if(self.arrowPosition==CRArrowPositionTop||self.arrowPosition==CRArrowPositionBottom)
    {
        x+=self.attachedView.frame.size.width/2-[self size].width/2;
        y+=(self.arrowPosition==CRArrowPositionTop)? CR_ARROW_SPACE+self.attachedView.frame.size.height : -(CR_ARROW_SPACE*2+[self size].height);
    }
    
    return CGRectMake(x, y, [self size].width+CR_ARROW_SIZE, [self size].height+CR_ARROW_SIZE);
}

-(CGSize)size
{
    //Cacultation of the bubble size
    float height = CR_PADDING*3;
    float width = CR_PADDING*3;
    
    float titleWidth = [self.title length]*CR_TITLE_FONT_SIZE/2;
    
    if(self.title && ![self.title isEqual:@""])
    {
        height+=CR_TITLE_FONT_SIZE+CR_PADDING;
        
    }
    height-=CR_DESCRIPTION_FONT_SIZE;
    float descriptionWidth=0;
    for (NSString *descriptionLine in  stringArray) {
        if(descriptionWidth<[descriptionLine length]*CR_DESCRIPTION_FONT_SIZE/2.1)
            descriptionWidth=[descriptionLine length]*CR_DESCRIPTION_FONT_SIZE/2.1;
        height+=CR_DESCRIPTION_FONT_SIZE;
    }
    
    if (descriptionWidth>titleWidth) {
        // width+=descriptionWidth;
        if (descriptionWidth > width) {
            width = descriptionWidth + CR_PADDING;
        }
    }else{
        width+=titleWidth;
    }
    
    return CGSizeMake(width, height);
}

-(CGSize) offsets
{
    return CGSizeMake((self.arrowPosition==CRArrowPositionLeft)? CR_ARROW_SIZE : 0, (self.arrowPosition==CRArrowPositionTop)? CR_ARROW_SIZE : 0);
}


- (void)drawRect:(CGRect)rect
{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    
    CGPathRef clippath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake([self offsets].width,[self offsets].height, [self size].width, [self size].height) cornerRadius:CR_RADIUS].CGPath;
    CGContextAddPath(ctx, clippath);
    
    CGContextSetFillColorWithColor(ctx, self.color.CGColor);
    
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    [self.color set];
    
    CGPoint startPoint = CGPointMake(0, CR_ARROW_SIZE);
    CGPoint thirdPoint = CGPointMake(CR_ARROW_SIZE/2, 0);
    CGPoint endPoint = CGPointMake(CR_ARROW_SIZE, CR_ARROW_SIZE);
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    [path addLineToPoint:thirdPoint];
    [path addLineToPoint:startPoint];
    
    
    if(self.arrowPosition==CRArrowPositionTop)
    {
        CGAffineTransform trans = CGAffineTransformMakeTranslation([self size].width/2-(CR_ARROW_SIZE)/2, 0);
        [path applyTransform:trans];
    }else if(self.arrowPosition==CRArrowPositionBottom)
    {
        CGAffineTransform rot = CGAffineTransformMakeRotation(M_PI);
        CGAffineTransform trans = CGAffineTransformMakeTranslation([self size].width/2+(CR_ARROW_SIZE)/2, [self size].height+CR_ARROW_SIZE);
        [path applyTransform:rot];
        [path applyTransform:trans];
    }else if(self.arrowPosition==CRArrowPositionLeft)
    {
        CGAffineTransform rot = CGAffineTransformMakeRotation(M_PI*1.5);
        CGAffineTransform trans = CGAffineTransformMakeTranslation(0, ([self size].height+CR_ARROW_SIZE)/2);
        [path applyTransform:rot];
        [path applyTransform:trans];
    }else if(self.arrowPosition==CRArrowPositionRight)
    {
        CGAffineTransform rot = CGAffineTransformMakeRotation(M_PI*0.5);
        CGAffineTransform trans = CGAffineTransformMakeTranslation([self size].width+CR_ARROW_SIZE, ([self size].height-CR_ARROW_SIZE)/2);
        [path applyTransform:rot];
        [path applyTransform:trans];
    }
    
    [path closePath]; // Implicitly does a line between p4 and p1
    [path fill]; // If you want it filled, or...
    [path stroke]; // ...if you want to draw the outline.
    CGContextRestoreGState(ctx);
}

@end