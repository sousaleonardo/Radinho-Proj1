//
//  GestoCircular.h
//
//  Created by LEONARDO DE SOUSA MENDES on 31/03/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@protocol GestocircularDelegate <NSObject>
@optional
-(void)rotacao: (CGFloat)angulo :(NSNumber*)tagBotao;
-(void)anguloFinal :(CGFloat)angulo;

//Controles de volume e estacao
-(void)alterarVolume:(NSInteger*)valor;
-(void)manipulaArray:(NSInteger*)valor;
-(void)playVideo;
-(void)playEstacao;

@end

@interface GestoCircular : UIGestureRecognizer

{
    CGPoint pontoMedio;
    CGFloat foraRaio;
    CGFloat raioMedio;
    CGFloat anguloAcumulado;

    id<GestocircularDelegate> target;
    
    SEL selPlay;
    SEL selManipularArray;
    
    NSNumber *tagBotao;
    
}

-(id) initWithPontoMedio: (CGPoint) _pontoMedio
               raioMedio: (CGFloat) _raioMedio
                foraRaio: (CGFloat) _foraRaio
                  target: (id <GestocircularDelegate>)_target
        selManipulaArray: (SEL) _selManipulaArray
                 selPlay: (SEL) _selPlay
                tagBotao:(int)_tagBotao;

@end

