//
//  GestoEmL.h
//  Raidinho Proj1
//
//  Created by LEONARDO DE SOUSA MENDES on 26/03/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface GestoEmL : UIGestureRecognizer
{
    CGPoint pontoInicial;
    CGPoint segundoPonto;
    BOOL analisaY;
}
@end
