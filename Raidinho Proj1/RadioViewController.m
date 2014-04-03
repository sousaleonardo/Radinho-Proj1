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
    
    NSURL *url=[[NSBundle mainBundle]pathForResource:@"procurando" ofType:@".mp3"];
    
    self.somSintonizando = [[AVPlayer alloc]initWithURL:url];
    
    [self.somSintonizando setVolume:1.0f];
    [self.somSintonizando play];
    
    
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
    //NSNumber *volume=[NSNumber numberWithInteger:valor/10];
    
    if([self.radioSom volume] < 0){
        [self.radioSom setVolume:0];
        
    }else{
        [self.radioSom setVolume:[self.radioSom volume] + [valor floatValue]/10];
    }
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    //"Liga" as constraints da view de Texto
    //[self.textoRadio setAutoresizesSubviews:NO];
    
    //Liga as constraints
    [self.botaoEstacao setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.botaoVolume setTranslatesAutoresizingMaskIntoConstraints:NO];

}

-(void)rotacao:(CGFloat)angulo :(NSNumber*)tagBotao{
    
    
    //"Desliga" as constraints da view de Texto
    //[self.textoRadio setAutoresizesSubviews:YES];
    
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
        self->anguloBotaoSintonia +=angulo;
        
        if (self->anguloBotaoVolume > 360) {
            self->anguloBotaoVolume -=360;
        }else if(self->anguloBotaoVolume < -360){
            self->anguloBotaoVolume +=360;
        }
        
        //Basicamente desliga as constraints
        [self.botaoVolume setTranslatesAutoresizingMaskIntoConstraints:YES];
        
        [self.botaoVolume layoutIfNeeded];
        
        self.botaoVolume.transform =CGAffineTransformMakeRotation(self->anguloBotaoSintonia * M_PI/180);
    }    
}

-(void)anguloFinal:(CGFloat)angulo{
  
}

-(void)manipulaArray:(NSNumber*)valor{
    
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
    
    NSLog(@"%i",self->posicaoAtual);
    
    
}

-(void)playEstacao{
    //Para o som de procurando e toca a est *__*
    [self.somSintonizando pause];
    [self.somSintonizando seekToTime:kCMTimeZero];
    
    [self.player playEstacao];
    self.radioSom = [self.player playEstacao];
    
    [self.textoRadio setText:self.player.nomeDaRadioAtual];
    
}
@end
