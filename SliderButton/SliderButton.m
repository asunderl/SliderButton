//
//  SliderButton.m
//  SliderButton
//
//  Created by Annalia Sunderland on 11/23/15.
//  Copyright © 2015 Annalia Sunderland. All rights reserved.
//
//  TODO: Swipe up down left right

#import "SliderButton.h"

@implementation SliderButton {
    UIImageView *_sliderTag;
    UIView *_tail;
    
    float _sHeight, _sWidth, _fHeight, _fWidth;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *sliderTagImage = [UIImage imageNamed:@"New_Half.png"];
        _sliderTag = [[UIImageView alloc] initWithImage:sliderTagImage];
        
        _sHeight = sliderTagImage.size.height/4;
        _sWidth = sliderTagImage.size.width/4;
        _fHeight = frame.size.height;
        _fWidth = frame.size.width;
        
        _sliderTag.frame = CGRectMake(_fWidth/2 - _sWidth/2,
                                      _fHeight - _sHeight,
                                      _sWidth,
                                      _sHeight);
        
        _tail = [[UIView alloc] initWithFrame: CGRectMake(0, _fHeight, _fWidth, 0)];
        _tail.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:70.0/255.0 blue:106.0/255.0 alpha:1.0];
        // TODO: make color actually match
        [self addSubview:_sliderTag];
        [self addSubview:_tail];
        
    }
    return self;
}

# pragma mark - Update Views

-(void) _moveSliderTo:(CGPoint) newOrigin {
    // For now, only move up
    float newY = newOrigin.y - self.frame.origin.y;
    newY = MIN(_fHeight - _sHeight, newY);
    newY = MAX(0, newY);
    
    _sliderTag.frame = CGRectMake(_sliderTag.frame.origin.x, newY, _sWidth, _sHeight);
    
    _tail.frame = CGRectMake(0, newY + _sHeight, _fWidth, _fHeight - (newY + _sHeight));
}


# pragma mark - UIControl Methods
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint recentTouchPoint = [touch locationInView:self];
    if (CGRectContainsPoint(_sliderTag.frame, recentTouchPoint)) {
        return YES;
    }
    return NO;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint recentTouchPoint = [touch locationInView:self];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self _moveSliderTo:recentTouchPoint];
    [CATransaction commit];
    
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    // TODO
}

@end
