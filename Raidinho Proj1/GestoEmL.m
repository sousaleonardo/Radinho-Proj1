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
    //self->ultimoPonto=[toque locationInView:self.view];
    self->analisaY=YES;
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //Enquanto o toque e analisado verifica se esta diminuindo o Y
    UITouch *toque=[touches anyObject];
    CGPoint pontoAtual=[toque locationInView:self.view];
    
    if (self->pontoInicial.x <= pontoAtual.x-5 || self->pontoInicial.x >= pontoAtual.x+5 ) {
        self->analisaY=NO;
        self
    }
    
    if (self->analisaY) {
        if (self->pontoInicial.y < pontoAtual.y) {
            [self setState:UIGestureRecognizerStateFailed];
            NSLog(@"aumentou Y");
        }
    }else{
        if (condition) {
            <#statements#>
        }
    }

    /*
    if ((self->ultimoPonto.x != pontoAtual.x -50|| self->ultimoPonto.x != pontoAtual.x -50) && (self->ultimoPonto.y != pontoAtual.y +50 || self->ultimoPonto.y != pontoAtual.y -50)){
        
        [self setState:UIGestureRecognizerStateFailed];
        NSLog(@"Alterou x e Y");
    }
    */
    if (pontoAtual.y == self->ultimoPonto.y) {
        if (pontoAtual.x>=self->ultimoPonto.x) {
            [self setState:UIGestureRecognizerStatePossible];
            NSLog(@"igual");
        }
    }
    
    
    self->ultimoPonto=[toque locationInView:self.view];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *toque=[touches anyObject];
    CGPoint pontoAtual=[toque locationInView:self.view];
    
    //Impedir que tap seja confundido com o gesto
    if ([toque tapCount] == 0 ) {
        
        if ((self->pontoInicial.y > pontoAtual.y && self->pontoInicial.x < pontoAtual.x) && (pontoAtual.y == self->ultimoPonto.y )) {
            
            [self setState:UIGestureRecognizerStateRecognized];
        }else
            [self setState:UIGestureRecognizerStateFailed];
    }
}
@end
