//
//  MVMaterialView.h
//  DYRCT
//
//  Created by indianic on 20/03/15.
//  Copyright (c) 2015 DYRCT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MVMaterialView : UIControl{
    CAShapeLayer *aMaterialLayer;
}

@property(nonatomic,strong)UIColor *overlayColor;

@end
