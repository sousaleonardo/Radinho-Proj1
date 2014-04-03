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
    
    self.somSintonizando = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:@"procurando"]];
    self.radioSom =[[AVPlayer alloc]init];
    self->posicaoAtual=0;
    self.player =[[Player alloc]init];
    
    //Seta o tag dos botoes para diferenciar na hora de animar
  //  self.botaoVolume.tag=0;
//    self.botaoEstacao.tag=1;
    
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
    
    //adiciona o /5 no fora Raio para que ele aceite até no max 1/5 do raio do circ p dentro
    gesto=[[GestoCircular alloc]initWithPontoMedio:pontoMedio raioMedio:foraRaio/5 foraRaio:foraRaio target:self selManipulaArray:seletor1 selPlay:seletor2 tagBotao:botao.tag];
    
    [self.view addGestureRecognizer:gesto];
}

-(void)alterarVolume:(NSNumber*)valor{
    //NSNumber *volume=[NSNumber numberWithInteger:valor/10];
    
    NSLog(@"%f",[valor floatValue]/100);
    
    [self.radioSom setVolume:[valor floatValue]/10];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    //"Liga" as constraints da view de Texto
    [self.textoRadio setAutoresizesSubviews:NO];
    
    //Liga as constraints
    [self.botaoEstacao setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.botaoVolume setTranslatesAutoresizingMaskIntoConstraints:NO];

}

-(void)rotacao:(CGFloat)angulo :(NSNumber*)tagBotao{
    
    
    //"Desliga" as constraints da view de Texto
    [self.textoRadio setTranslatesAutoresizingMaskIntoConstraints:YES];
    
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
    
//    int valorInt=*valor/10;
    int valorInt=[valor intValue]/10;
    
    if (self->posicaoAtual - valorInt == 0) {
        return;
    }
    
    self->posicaoAtual=valorInt;
    
    if (valor > 0) {
        [self.player trocarEstacao:@"aumentar"];
    }else{
        [self.player trocarEstacao:@"abaixar"];
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
}
@end
