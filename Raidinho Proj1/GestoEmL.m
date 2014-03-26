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
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //Enquanto o toque e analisado verifica se esta diminuindo o Y
    
    UITouch *toque=[touches anyObject];
    CGPoint pontoAtual=[toque locationInView:self.view];
  
    //if(self->ultimoPonto.y < pontoAtual.y && self->ultimoPonto.x > pontoAtual.x){
    if (self->pontoInicial.y < pontoAtual.y) {
        [self setState:UIGestureRecognizerStateFailed];
        
        NSLog(@"aumentando Y");
    }else{
        
    }
    
    if (self->pontoInicial.x != pontoAtual.x && self->pontoInicial.y != pontoAtual.y) {
        [self setState:UIGestureRecognizerStateFailed];
        NSLog(@"Alterou x e Y");
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
