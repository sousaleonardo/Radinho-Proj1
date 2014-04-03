//
//  GestoCircular.m
//  Raidinho Proj1
//
//  Created by LEONARDO DE SOUSA MENDES on 31/03/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "GestoCircular.h"

@implementation GestoCircular

-(CGFloat)distanciaEntrePontos:(CGPoint)pontoA :(CGPoint)pontoB{
    CGFloat dx = pontoA.x - pontoB.x;
    CGFloat dy = pontoA.y - pontoB.y;
    return sqrt(dx*dx + dy*dy);
    
}

-(id) initWithPontoMedio: (CGPoint) _pontoMedio
               raioMedio: (CGFloat) _raioMedio
                foraRaio: (CGFloat) _foraRaio
                  target: (id <GestocircularDelegate>)_target
        selManipulaArray: (SEL) _selManipulaArray
                 selPlay: (SEL) _selPlay
                tagBotao:(int)_tagBotao{

    
    if ((self=[super initWithTarget:_target action:Nil])) {
        self-> pontoMedio = _pontoMedio;
        self-> raioMedio = _raioMedio;
        self-> foraRaio = _foraRaio;
        self-> target = _target;
        self->selManipularArray=_selManipulaArray;
        self->selPlay=_selPlay;
        self->tagBotao=[NSNumber numberWithInt:_tagBotao];
    }
    
    return self;
}

-(CGFloat) anguloEntreLinhasEmGraus:(CGPoint)inicioLinhaA :(CGPoint)fimLinhaA :(CGPoint)inicioLinhaB :(CGPoint)fimLinhaB{
    
    CGFloat distLinhaAX = fimLinhaA.x - inicioLinhaA.x;
    CGFloat distLinhaAY = fimLinhaA.y - inicioLinhaA.y;
    CGFloat distLinhaBX = fimLinhaB.x - inicioLinhaB.x;
    CGFloat distLinhaBY = fimLinhaB.y - inicioLinhaB.y;
    
    CGFloat atanA = atan2(distLinhaAX, distLinhaAY);
    CGFloat atanB = atan2(distLinhaBX, distLinhaBY);
    
    return (atanA - atanB)*180 /M_PI;
}

-(void)reset{
    [super reset];
    
    self->anguloAcumulado=0;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    if ([touches count] != 1) {
        [self setState:UIGestureRecognizerStateFailed];
        return;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
    if (self.state == UIGestureRecognizerStateFailed ) {
        return;
    }
    
    CGPoint pontoAtual = [[touches anyObject]locationInView:self.view];
    CGPoint pontoAnterior = [[touches anyObject]previousLocationInView:self.view];
    
    //Garantir que os pontos estão na area certa
    CGFloat distancia = [self distanciaEntrePontos:self->pontoMedio :pontoAtual];
    
    if ((raioMedio <= distancia) && (distancia <= self-> foraRaio  )) {
        
        //Calcula o angulo de rotação entre os pontos
        CGFloat angulo = [self anguloEntreLinhasEmGraus:self->pontoMedio :pontoAnterior :self->pontoMedio :pontoAtual];
        
        if (angulo > 180) {
            angulo-=360;
        }else if (angulo < -180){
            angulo += 360;
        }
        
        //soma angulo
        self->anguloAcumulado+=angulo;
        
        //Chama o delegate
        if ([self->target respondsToSelector:@selector(rotacao::)]){
            //[self->target rotacao:angulo];
            [self->target rotacao:angulo :self->tagBotao ];
        }
        
        NSNumber *anguloConvertido=[[NSNumber alloc]initWithFloat:angulo];
        
        if (self->selManipularArray != Nil ) {
            [self->target performSelector:self->selManipularArray withObject:anguloConvertido];
        }
        
    }else{
        [self setState:UIGestureRecognizerStateFailed];
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    if([[touches anyObject]tapCount] == 0){
        if (self.state == UIGestureRecognizerStatePossible) {
            
            [self setState:UIGestureRecognizerStateRecognized];
            
            if (self->selPlay != Nil) {
                if ([self->target respondsToSelector:self->selPlay]) {
                    [target performSelector:self->selPlay];
                }
            }
        }else{
            [self setState:UIGestureRecognizerStateFailed];
        }
        
        self->anguloAcumulado =0 ;
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    
    [self setState:UIGestureRecognizerStateFailed];
    self->anguloAcumulado=0;
}


@end
