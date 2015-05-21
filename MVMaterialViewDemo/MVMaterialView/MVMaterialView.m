//
//  MVMaterialView.m
//  DYRCT
//
//  Created by indianic on 20/03/15.
//  Copyright (c) 2015 DYRCT. All rights reserved.
//

#import "MVMaterialView.h"

@implementation MVMaterialView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/


-(void)awakeFromNib{
    [self setClipsToBounds:YES];
}


#define initialSize 20

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    CALayer *layer = [anim valueForKey:@"animationLayer"];
    if(layer){
        [layer removeAnimationForKey:@"scale"];
        [layer removeFromSuperlayer];
        layer = nil;
        anim = nil;
    }
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    UITouch *aTouch = touch;
    
    CGPoint aPntTapLocation = [aTouch locationInView:self];
    
    CALayer *aLayer = [CALayer layer];
    aLayer.backgroundColor = self.tintColor?self.tintColor.CGColor:[UIColor colorWithWhite:1.0 alpha:0.3].CGColor;
    aLayer.frame = CGRectMake(0, 0, initialSize, initialSize);
    aLayer.cornerRadius = initialSize/2;
    aLayer.masksToBounds =  YES;
    aLayer.position = aPntTapLocation;
    [self.layer addSublayer:aLayer];
    
    // Create a basic animation changing the transform.scale value
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // Set the initial and the final values
    [animation setToValue:[NSNumber numberWithFloat:(2.5*MAX(self.frame.size.height, self.frame.size.width))/initialSize]];
    // Set duration
    [animation setDuration:0.6f];
    
    // Set animation to be consistent on completion
    [animation setRemovedOnCompletion:NO];
    [animation setFillMode:kCAFillModeForwards];
    
    // Add animation to the view's layer
    
    
    
    CAKeyframeAnimation *fade = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    fade.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:1.0],[NSNumber numberWithFloat:1.0],[NSNumber numberWithFloat:1.0],[NSNumber numberWithFloat:0.5],[NSNumber numberWithFloat:0.0], nil];
    fade.duration = 0.5;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.duration  = 0.5f;
    animGroup.delegate=self;
    animGroup.animations = [NSArray arrayWithObjects:animation,fade, nil];
    [animGroup setValue:aLayer forKey:@"animationLayer"];
    [aLayer addAnimation:animGroup forKey:@"scale"];
    
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}


@end
