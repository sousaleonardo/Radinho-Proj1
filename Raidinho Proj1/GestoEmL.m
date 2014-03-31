//
//  GestoEmL.m
//  Raidinho Proj1
//
//  Created by LEONARDO DE SOUSA MENDES on 26/03/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "GestoEmL.h"

@implementation GestoEmL

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *toque=[touches anyObject];
    
    self->pontoInicial=[toque locationInView:self.view];
    self->ultimoPonto=[toque locationInView:self.view];
    self->analisaY=YES;
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //Enquanto o toque e analisado verifica se esta diminuindo o Y
    UITouch *toque=[touches anyObject];
    CGPoint pontoAtual=[toque locationInView:self.view];
    
    if (self->analisaY) {
        if (self->ultimoPonto.x < pontoAtual.x -5 ) {
            self->analisaY=NO;
            self->segundoPonto=pontoAtual;
        }
        
        if (self->pontoInicial.y < pontoAtual.y) {
            [self setState:UIGestureRecognizerStateFailed];
        }
    }else{
        if (self->ultimoPonto.y < pontoAtual.y -2 || self->ultimoPonto.y > pontoAtual.y +2 ) {
            [self setState:UIGestureRecognizerStateFailed];
        }
    }
    
    self->ultimoPonto=[toque locationInView:self.view];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *toque=[touches anyObject];
    CGPoint pontoAtual=[toque locationInView:self.view];
    
    //Impedir que tap seja confundido com o gesto
    if ([toque tapCount] == 0 ) {
        
        if (self->pontoInicial.y > pontoAtual.y +2 && self->pontoInicial.x < pontoAtual.x -2 ) {
            if (self->segundoPonto.y < pontoAtual.y -2 || self->segundoPonto.y > pontoAtual.y +2 ) {
                [self setState:UIGestureRecognizerStateFailed];
            }else{
                [self setState:UIGestureRecognizerStateRecognized];
            }
        }else
            [self setState:UIGestureRecognizerStateFailed];
    }
}
@end
