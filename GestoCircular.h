//
//  GestoCircular.h
//  Raidinho Proj1
//
//  Created by LEONARDO DE SOUSA MENDES on 31/03/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface GestoCircular : UIGestureRecognizer

@property (nonatomic,readonly) CGPoint inicioCirc;
@property (nonatomic,readonly) CGPoint centroCirc;
@property (nonatomic,readonly) CGPoint ultPonto;
@property (nonatomic,readonly) CGPoint novoPonto;
@property (nonatomic,readonly) CGFloat raioMax;
@property (nonatomic,readonly) CGFloat raioMin;
@property (nonatomic,readonly) CGFloat velocidade;
@property (nonatomic,readonly) NSTimeInterval ultUpdate;
@property (nonatomic,readonly) CGFloat rotacao;
@property (nonatomic,readonly) CGFloat holePortion;

@end
