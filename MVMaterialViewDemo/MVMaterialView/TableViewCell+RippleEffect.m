//
//  TableViewCell+RippleEffect.m
//  expoforum
//
//  Created by Aleksey Cherepanov on 12.04.16.
//  Copyright © 2016 IndevGroup LTD. All rights reserved.
//

#import "TableViewCell+RippleEffect.h"

@implementation UITableViewCell (RippleEffect)

#define initialSize 20

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CALayer *layer = [anim valueForKey:@"animationLayer"];
    if (layer) {
        [layer removeAnimationForKey:@"scale"];
        [layer removeFromSuperlayer];
        layer = nil;
        anim = nil;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *aTouch = [touches anyObject];
    
    CGPoint aPntTapLocation = [aTouch locationInView:self];
    
    CALayer *aLayer = [CALayer layer];
    aLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1].CGColor;
    aLayer.frame = CGRectMake(0, 0, initialSize, initialSize);
    aLayer.cornerRadius = initialSize / 2;
    aLayer.masksToBounds = YES;
    aLayer.position = aPntTapLocation;
    if ([self.subviews count] > 0 && [self.subviews firstObject] != nil) {
        [self.layer insertSublayer:aLayer below:[self.subviews firstObject]];
    } else {
        [self.layer addSublayer:aLayer];
    }
    
    // Create a basic animation changing the transform.scale value
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // Set the initial and the final values
    [animation
     setToValue:[NSNumber numberWithFloat:(2.5 * MAX(self.frame.size.height,
                                                     self.frame.size.width)) /
                 initialSize]];
    // Set duration
    [animation setDuration:0.6f];
    
    // Set animation to be consistent on completion
    [animation setRemovedOnCompletion:NO];
    [animation setFillMode:kCAFillModeForwards];
    
    // Add animation to the view's layer
    
    CAKeyframeAnimation *fade =
    [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    fade.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:1.0],
                   [NSNumber numberWithFloat:1.0],
                   [NSNumber numberWithFloat:1.0],
                   [NSNumber numberWithFloat:0.5],
                   [NSNumber numberWithFloat:0.0], nil];
    fade.duration = 0.5;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.duration = 0.5f;
    animGroup.delegate = self;
    animGroup.animations = [NSArray arrayWithObjects:animation, fade, nil];
    [animGroup setValue:aLayer forKey:@"animationLayer"];
    [aLayer addAnimation:animGroup forKey:@"scale"];
    
}

@end
