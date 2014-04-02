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
    
    /*
    //Cria array de seletores que serão usados pelo gesto
    SEL selectorVolume=@selector(alterarVolume:);
    NSMutableArray *seletores = [NSMutableArray array];
    [seletores addObject:selectorVolume];
    */
    
    //Cria gesto circular para volume
    [self setGestoReconizer:self.botaoVolume :self.gestoVolume :@selector(alterarVolume:) :nil];
    
    //Cria o gesto para sintonia
    [self setGestoReconizer:self.botaoEstacao :self.gestoSintonia :@selector(manipulaArray:) :@selector(playEstacao)];
    
    
    //Adiciono os gesto na view
    [self.view addGestureRecognizer:self.gestoSintonia];
    [self.view addGestureRecognizer:self.gestoVolume];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Configura o gesto Reconizer e adiciona na view
-(void)setGestoReconizer:(UIImageView*)botao :(GestoCircular*)gesto :(SEL)seletor1 :(SEL)seletor2{

    //Garante que o centro do ponto seja o correto mesmo que altere o layout
    [botao layoutIfNeeded];
    
    CGPoint pontoMedio = [botao center];
    CGFloat foraRaio = botao.frame.size.width / 2;
    
    [botao setCenter:pontoMedio];
    
    SEL alterarVolume=@selector(alterarVolume:);
    SEL play=@selector(playEstacao);
    
    //adiciona o /3 no fora Raio para que ele aceite até no max 1/3 do raio do circ p dentro
    gesto=[[GestoCircular alloc]initWithPontoMedio:pontoMedio raioMedio:foraRaio/3 foraRaio:foraRaio target:self selManipulaArray:alterarVolume selPlay:play];
    
    [self.view addGestureRecognizer:gesto];
}

-(void)alterarVolume:(NSInteger*)valor{
    NSNumber *volume=[NSNumber numberWithInteger:*valor/10];
    
    [self.radioSom setVolume:[volume floatValue]];
}

-(void)manipulaArray:(NSInteger*)valor{
    
    //Comeca a tocar som de chiado
    [self.somSintonizando play];
    
    int valorInt=*valor/10;
    
    if (self->posicaoAtual - valorInt == 0) {
        return;
    }
    
    self->posicaoAtual=*valor/10;
    
    if (valor > 0) {
        [self.playerRadio trocarEstacao:@"aumentar"];
    }else{
        [self.playerRadio trocarEstacao:@"abaixar"];
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
    
    [self.playerRadio playEstacao];
    self.radioSom = [self.playerRadio playEstacao];
}
@end
