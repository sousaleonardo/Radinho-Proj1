//
//  GestoCircular.m
//  Raidinho Proj1
//
//  Created by LEONARDO DE SOUSA MENDES on 31/03/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "GestoCircular.h"

@interface GestoCircular(DPPrivate)
-(BOOL) pontoValido:(CGPoint)novoPonto;

@end

@implementation GestoCircular

@synthesize inicioCirc=_inicioCirc,ultPonto=_ultPonto,novoPonto=_novoPonto,raioMax=_raioMax,raioMin=_raioMin,velocidade=_velocidade,ultUpdate=_ultUpdate,centroCirc=_centroCirc,holePortion=_holePortion;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *toque =[touches anyObject];
    
    if (touches.count > 1) {
        [self setState:UIGestureRecognizerStateFailed];
    }
    
    [super touchesBegan:touches withEvent:event];
    
    _ultUpdate=toque.timestamp;
    _inicioCirc=[toque locationInView:self.view];
    _novoPonto=_inicioCirc;
    
    //definindo raio min e max
    // Um circulo a partir da borda mais proxima até 1/3 para o centro
    
    _raioMax=MIN(self.view.bounds.size.width, self.view.bounds.size.height)/2;
    _raioMin= self.raioMax * _holePortion;
    
    //Valida o ponto criado
    if(![self pontoValido:self.inicioCirc]){
        [self setState:UIGestureRecognizerStateFailed];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
    if (self.state == UIGestureRecognizerStatePossible) {
        [self setState:UIGestureRecognizerStateBegan];
    }else{
        [self setState:UIGestureRecognizerStateChanged];
    }
    
    UITouch *toque=[touches anyObject];
    
    _ultPonto = [toque previousLocationInView:self.view];
    _novoPonto = [toque locationInView:self.view];
    
    //Pega os pontos usando o centro como ref
    
    CGPoint translacaoAnt = CGPointMake((self.ultPonto.x - _centroCirc.x), (self.ultPonto.y - _centroCirc.y));
    CGPoint translacaoNova = CGPointMake((self.novoPonto.x - _centroCirc.x),(self.novoPonto.y - _centroCirc.y));
    
    CGFloat pontoMaisNovo = atan2(translacaoNova.y, translacaoNova.x);
    CGFloat pontoAnterior = atan2(translacaoAnt.y, translacaoAnt.x);
    
    
    //Agora calculamos a velocidade dos dedos do user
    //Nos sabemos os 2 angulos porem caso ele ocorra em algum dos lados da origem do radiano, irá fazer o calculo errado
    //Para resolver isso, iremos verificar se um angulo é muito grande e o outro muito pequeno e se for,
    //compensaremos para calcular corretamente
    
    CGFloat helfCirculo= M_PI;
    
    CGFloat menorValorCap = (helfCirculo /2) * -1.0;
    CGFloat maiorValorCap = (helfCirculo /2);
    
    if ((pontoMaisNovo < menorValorCap && pontoAnterior > maiorValorCap) || (pontoMaisNovo > maiorValorCap && pontoAnterior < menorValorCap )) {
        
        // Exemplo de valores possiveis (new ===> previous)
        //  3.064366 ===> -3.135779
        // -3.135495 ===> 3.135495
        
        float angulo1 = helfCirculo - fabs(pontoMaisNovo);
        float angulo2 = helfCirculo - fabs(pontoAnterior);
        
        float diferenca = angulo1 + angulo2;
        
        //Se o ponto novo é menos então estamos no sentido horario, então o angulo precisa ser positivo
        // senão estamos no sentido anti-horario e o angulo sera negativo
        
        _rotacao = pontoMaisNovo < menorValorCap ? fabs(diferenca) : fabs(diferenca) * -1.0;
        
    }else{
        //se estamos em um circulo verificamos se continuamos na mesma direção
        
        if (self.state == UIGestureRecognizerStatePossible) {
            [self setState:UIGestureRecognizerStateChanged];
        }
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    if (self.state == UIGestureRecognizerStateChanged) {
        [self setState:UIGestureRecognizerStateEnded];
    }else{
        [self setState:UIGestureRecognizerStateFailed];
    }
    
    [self reset];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    [self reset];
}

-(void)reset{
    [super reset];
    
    _inicioCirc=CGPointZero;
    _centroCirc=CGPointZero;
    _raioMin=0.0f;
    _raioMax=0.0f;
    _ultUpdate=0.0f;
    _holePortion=0.3f;
    
    if (self.state == UIGestureRecognizerStatePossible) {
        [self setState:UIGestureRecognizerStateFailed];
    }
}

-(void)setHolePortion:(CGFloat)holePortion{
    if (self.holePortion >=0.0 && self.holePortion < 1.0f) {
        _holePortion=holePortion;
    }else{
        NSLog(@"HolePortion maior q 1.0 ou menor q 0.0f");
    }
}

-(BOOL)pontoValido:(CGPoint)novoPonto{
    //Calcula distancia do centro usando pitagoras
    
    CGFloat a=abs(novoPonto.x -(self.view.bounds.size.width/2));
    CGFloat b=abs(novoPonto.y-(self.view.bounds.size.height/2));
    CGFloat distanciaCentro= sqrt(powf(a,2)+pow(b, 2));
    
    if ((distanciaCentro > self.raioMin) && (distanciaCentro > self.raioMax)) {
        return YES;
    }else{
        
        return NO;
    }
}
@end
