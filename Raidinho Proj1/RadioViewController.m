//
//  RadioViewController.m
//  Raidinho Proj1
//
//  Created by LEONARDO DE SOUSA MENDES on 02/04/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "RadioViewController.h"

@interface RadioViewController ()

@end

@implementation RadioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    while (self.view.gestureRecognizers.count) {
        [self.view removeGestureRecognizer:[self.view.gestureRecognizers objectAtIndex:0]];
    }
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"procurando" withExtension:@"mp3"];
    
    self.somSintonizando = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:Nil];
    
    [self.somSintonizando setVolume:1.0f];
    [self.somSintonizando prepareToPlay];
    
    self.radioSom =[[AVPlayer alloc]init];
    self->posicaoAtual=0;
    self.player =[[Player alloc]init];
    
    //Seta o tag dos botoes para diferenciar na hora de animar
    [self.botaoVolume setTag:0];
    [self.botaoEstacao setTag:1];
    
    //Cria gesto circular para volume
    [self setGestoReconizer:self.botaoVolume :self.gestoVolume :@selector(alterarVolume:) :nil];
    
    //Cria o gesto para sintonia
    [self setGestoReconizer:self.botaoEstacao :self.gestoSintonia :@selector(manipulaArray:) :@selector(playEstacao)];
    
    //Basicamente liga as constraints
    [self.botaoEstacao setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //Basicamente liga as constraints
    [self.botaoVolume setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //Adiciona o nome da segue que deve usar ParaRadioViewController
    self->segueID=[NSString stringWithFormat:@"ParaViewControllerVideo"];
    
    //Adiciona Gesto em L
    GestoEmL *gestoL =[[GestoEmL alloc]initWithTarget:self action:@selector(trocaDeViewController)];
    [gestoL setDelegate:self];
    
    [self.view addGestureRecognizer:gestoL];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Configura o gesto Reconizer e adiciona na view
-(void)setGestoReconizer:(UIImageView*)botao :(GestoCircular*)gesto :(SEL)seletor1 :(SEL)seletor2 {
    
    //Garante que o centro do ponto seja o correto mesmo que altere o layout
    [botao layoutIfNeeded];
    
    CGPoint pontoMedio = [botao center];
    CGFloat foraRaio = botao.frame.size.width / 2;
    
    [botao setCenter:pontoMedio];
    
    //adiciona o /3 no fora Raio para que ele aceite até no max 1/3 do raio do circ p dentro
    gesto=[[GestoCircular alloc]initWithPontoMedio:pontoMedio raioMedio:foraRaio/3 foraRaio:foraRaio target:self selManipulaArray:seletor1 selPlay:seletor2 tagBotao:botao.tag];
    
    [self.view addGestureRecognizer:gesto];
}

-(void)alterarVolume:(NSNumber*)valor{
    
    if([self.radioSom volume] < 0){
        [self.radioSom setVolume:0];
        
    }else{
        [self.radioSom setVolume:[self.radioSom volume] + [valor floatValue]/10];
    }
}

//Remove o gesto reconizer antes de girar a tela para não configurar a area do circulo de forma errada
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    //Basicamente liga as constraints
    [self.botaoEstacao setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view removeGestureRecognizer:self.gestoSintonia];
    
    //self->anguloBotaoSintonia=0;
    self.botaoEstacao.transform=CGAffineTransformIdentity;
    
    [self.botaoVolume setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view removeGestureRecognizer:self.gestoVolume];
    
    //self->anguloBotaoVolume=0;
    
    self.botaoVolume.transform=CGAffineTransformIdentity;
    
}

//Depois do giro da tela configura e adiciona o gesto reconizer
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    
    //Cria gesto circular para volume
    [self setGestoReconizer:self.botaoVolume :self.gestoVolume :@selector(alterarVolume:) :nil];
    
    //Cria o gesto para sintonia
    [self setGestoReconizer:self.botaoEstacao :self.gestoSintonia :@selector(manipulaArray:) :@selector(playEstacao)];
    
    //Basicamente desliga as constraints
    //[self.botaoEstacao setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    //Basicamente desliga as constraints
    //[self.botaoVolume setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    //Manter botao no angulo que estava
    [self rotacao:0.0f :[NSNumber numberWithInt:0]];
    [self rotacao:0.0f :[NSNumber numberWithInt:1]];
    
}

-(void)rotacao:(CGFloat)angulo :(NSNumber*)tagBotao{
    
    if ([tagBotao intValue] == self.botaoEstacao.tag ){
        self->anguloBotaoSintonia +=angulo;
        
        if (self->anguloBotaoSintonia > 360) {
            self->anguloBotaoSintonia -=360;
        }else if(self->anguloBotaoSintonia < -360){
            self->anguloBotaoSintonia +=360;
        }
        
        //Basicamente desliga as constraints
        [self.botaoEstacao setTranslatesAutoresizingMaskIntoConstraints:YES];
        
        [self.botaoEstacao layoutIfNeeded];
        
        self.botaoEstacao.transform =CGAffineTransformMakeRotation(self->anguloBotaoSintonia * M_PI/180);
        
    }else if ([tagBotao intValue]  == self.botaoVolume.tag){
        self->anguloBotaoVolume +=angulo;
        
        if (self->anguloBotaoVolume > 360) {
            self->anguloBotaoVolume -=360;
        }else if(self->anguloBotaoVolume < -360){
            self->anguloBotaoVolume +=360;
        }
        
        //Basicamente desliga as constraints
        [self.botaoVolume setTranslatesAutoresizingMaskIntoConstraints:YES];
        
        [self.botaoVolume layoutIfNeeded];
        
        self.botaoVolume.transform =CGAffineTransformMakeRotation(self->anguloBotaoVolume * M_PI/180);
    }
}

-(void)anguloFinal:(CGFloat)angulo{
    
}

-(void)manipulaArray:(NSNumber*)valor{
    //Para o som da raio
    [self.radioSom pause];
    
    //Comeca a tocar som de chiado
    [self.somSintonizando play];
    
    if (self->posicaoAtual - [valor intValue] == 0) {
        return;
    }

    if ([valor intValue] > 0) {
        [self.player trocarEstacao:@"aumentar"];
        self->posicaoAtual++;
    }else if([valor intValue] < 0){
        [self.player trocarEstacao:@"abaixar"];
        self->posicaoAtual--;
    }
    
    if (self->posicaoAtual > 36) {
        self->posicaoAtual=0;
    }
    
    
    [self.textoRadio setEditable:NO];
    [self.textoRadio setTextAlignment:NSTextAlignmentCenter];
    [self.textoRadio setTextColor:[UIColor colorWithRed:234.0f/255.0f green:198.0f/255.0f blue:148.0f/255.0f alpha:1.0f]];
    [self.textoRadio setText:self.player.nomeDaRadioAtual];
}

-(void)playEstacao{
    //Para o som de procurando e toca a est *__*
    [self.somSintonizando pause];
    [self.somSintonizando stop];
    [self.somSintonizando prepareToPlay];
    
    [self.player playEstacao];
    self.radioSom = [self.player playEstacao];
    
}


-(void)trocaDeViewController{
    //Alterado para parar a radio antes de trocar de view :D
    [self.radioSom pause];
    [self performSegueWithIdentifier:self->segueID sender:Nil];
}

@end
