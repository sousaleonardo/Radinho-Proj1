//
//  ViewController.m
//  Raidinho Proj1
//
//  Created by LEONARDO DE SOUSA MENDES on 26/03/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    while (self.view.gestureRecognizers.count) {
        [self.view removeGestureRecognizer:[self.view.gestureRecognizers objectAtIndex:0]];
    }

    
    [self.mudarVideo setTag:1];
    self->posicaoAtual = 0;
    
    UITapGestureRecognizer *tapPlay = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playVideo:)];
    
    [self.viewDoVideo addGestureRecognizer:tapPlay];
    
    
    
    [super setGestoReconizer:self.mudarVideo :self.gestoSintonia :@selector(manipulaArray:):nil];
    
    
    [self.tituloDoVideo setEditable:NO];
    [self.tituloDoVideo setText:self.player.nomeDoVideo];
    [self.tituloDoVideo setTextAlignment:NSTextAlignmentCenter];
    
    self.botaoEstacao = self.mudarVideo;
    [self.mudarVideo setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //Adiciona o nome da segue que deve usar ParaRadioViewController
    self->segueID=[NSString stringWithFormat:@"ParaRadioViewController"];
    
    //Basicamente desliga as constraints
    //[self.mudarVideo setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    //Adiciona Gesto em L
    GestoEmL *gestoL =[[GestoEmL alloc]initWithTarget:self action:@selector(trocaDeViewController)];
    
    [self.view addGestureRecognizer:gestoL];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *toque=[touches anyObject];
    
    if ([toque tapCount] > 1) {
        [self.player pararVideo];
    }
    if ([self.player.playerView.moviePlayer  playbackState]  != MPMoviePlaybackStateStopped) {
        [self.player pausarVideo];
    }
}
-(IBAction)playVideo:(UITapGestureRecognizer*)tap{

    [self.player playVideo:super.view];
}



-(void)manipulaArray:(NSNumber*)valor{
    
    self->posicaoAtual+=[valor intValue];
    
    if (self->posicaoAtual / 25 >= 1 ||self->posicaoAtual / 25 <= -1) {
        self->posicaoAtual = 0;
        if (valor > 0) {
            [self.player trocarVideo:@"aumentar"];
        }else {
            [self.player trocarVideo:@"abaixar"];
        }
        [self.tituloDoVideo setText:self.player.nomeDoVideo];
    }
    
    //NSLog(@"%i",self->posicaoAtual);
}

-(void)playEstacao{
    //Não tocar a radio ao selecionar o video
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end