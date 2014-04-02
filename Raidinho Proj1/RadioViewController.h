//
//  RadioViewController.h
//  Raidinho Proj1
//
//  Created by LEONARDO DE SOUSA MENDES on 02/04/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GestoCircular.h"
#import "Player.h"
#import <AVFoundation/AVFoundation.h>


@interface RadioViewController : UIViewController <GestocircularDelegate>
{
    int posicaoAtual;
    CGFloat anguloBotaoVolume;
    CGFloat anguloBotaoSintonia;
}

@property (weak, nonatomic) IBOutlet UIImageView *botaoEstacao;
@property (weak, nonatomic) IBOutlet UIImageView *botaoVolume;

@property Player *player;
@property AVPlayer *radioSom;
@property AVPlayer *somSintonizando;

@property GestoCircular *gestoSintonia;
@property GestoCircular *gestoVolume;

-(void)setGestoReconizer:(UIImageView*)botao :(GestoCircular*)gesto :(SEL)seletor1 :(SEL)seletor2;

@end
