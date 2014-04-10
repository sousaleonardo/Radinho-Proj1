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
#import "GestoEmL.h"
#import "ViewAdicionarRadio.h"

@interface RadioViewController : UIViewController <GestocircularDelegate>
{
    int posicaoAtual;
    CGFloat anguloBotaoVolume;
    CGFloat anguloBotaoSintonia;
    NSString *segueID;
    ViewAdicionarRadio *viewAddUrl;
    BOOL menuSuperiorAparece;
    
    CGRect screenRect; //bounds da
    CGFloat screenWidth; //largura total da tela
    CGFloat screenHeigth; // altura total da tela
    CGFloat alturaMenuSuperior; //altura do menu
    
    //Contador radio
    int contRadio;
}

@property (weak, nonatomic) IBOutlet UIImageView *botaoEstacao;
@property (weak, nonatomic) IBOutlet UIImageView *botaoVolume;
@property (weak, nonatomic) IBOutlet UITextView *textoRadio;

@property Player *player;
@property AVPlayer *radioSom;
@property AVAudioPlayer *somSintonizando;

@property GestoCircular *gestoSintonia;
@property GestoCircular *gestoVolume;

-(void)setGestoReconizer:(UIImageView*)botao :(GestoCircular*)gesto :(SEL)seletor1 :(SEL)seletor2;

@end
