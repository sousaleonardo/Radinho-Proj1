//
//  Player.m
//  Raidinho Proj1
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 26/03/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "Player.h"

@implementation Player

-(id)init{
    if (self = [super init]) {
        
        //[self inicializaVideo:[[NSBundle mainBundle] pathForResource:@"filename"
                                                            // ofType:@"txt"]];
        
        self.estacoes =[[NSMutableArray alloc]init];
        self.videos =[[NSMutableArray alloc]init];
        
        NSString* path = [[NSBundle mainBundle] pathForResource:@"estacoes"
                                                         ofType:@"txt"];
        
        [self inicializaEstacoes:path];
        self->videoAtual = 0;
        self->estacaoAtual = 0;
        self.player =[[AVPlayer alloc]init];
    }
    
    return self;
    
}

-(void)inicializaEstacoes : (NSString*)caminhoDoArquivo{
    
    NSString* conteudo = [NSString stringWithContentsOfFile:caminhoDoArquivo
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    NSArray *arquivo = [conteudo componentsSeparatedByString:@"\n"];
    
    NSString *estacaoDaRadio = [[NSString alloc]init];
    NSString *numeroDaradio = [[NSString alloc]init];
    NSString *enderecoDaRadio = [[NSString alloc]init];
    
    for (int i = 0; i < arquivo.count; i++) {
        estacaoDaRadio = [arquivo objectAtIndex:i];
        
        NSRange comecoDoEndereco = [estacaoDaRadio rangeOfString:@" "];
        
        NSRange finalEndereco = [estacaoDaRadio rangeOfString:@"*"];
        
        NSRange endereco = NSMakeRange(comecoDoEndereco.location+1 ,(finalEndereco.location-comecoDoEndereco.location)-1);
        
        NSRange numero = NSMakeRange(0, comecoDoEndereco.location);
        
        numeroDaradio = [estacaoDaRadio substringWithRange:numero];
        enderecoDaRadio = [estacaoDaRadio substringWithRange:endereco];
        
        Estacao *estacao = [[Estacao alloc]init:enderecoDaRadio :[numeroDaradio floatValue]] ;
        
        [self.estacoes addObject:estacao];
    }
}
-(void)inicializaVideo : (NSString*)caminhoDoArquivo{
    
    NSArray *arquivo = [NSArray arrayWithContentsOfFile:caminhoDoArquivo];
    NSString *nomeDoVideo = [[NSString alloc]init];
    
    
    for (int i = 0; i < arquivo.count; i++) {
        nomeDoVideo = [arquivo objectAtIndex:i];
        
        NSString* url = [[NSBundle mainBundle] pathForResource:nomeDoVideo
                                                         ofType:@"mp4"];
        
        Video *video = [[Video alloc]initWithName:nomeDoVideo  AndUrl:url] ;
        
        [self.videos addObject:video];
    }
}

-(void)playEstacao{
    Estacao *estacaoParaTocar = [self.estacoes objectAtIndex:self->estacaoAtual];
   
    NSURL *url = [NSURL URLWithString:estacaoParaTocar.streaming];
    
    self.radio = [[AVPlayerItem alloc]initWithURL:url];
    
    self.player = [[AVPlayer alloc]initWithPlayerItem:self.radio];
    
    [self.player setVolume:5.0];
    [self.player play];
    
}
-(void)playVideo : (UIView*)view{
    
    Video *videoParaTocar =[self.videos objectAtIndex:self->videoAtual];
    
    AVPlayerItem *video = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:videoParaTocar.url]];
    
    self.player = [[AVPlayer alloc]initWithPlayerItem:video];
    
    self.layerDoVideo = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    [self.layerDoVideo setFrame:view.frame];
    [self.player seekToTime:kCMTimeZero];
    
    [view.layer addSublayer:self.layerDoVideo];

}
-(void)pausarVideo{
    [self.player pause];
}
-(void)pararVideo{
    
    [self.layerDoVideo removeFromSuperlayer];
    [self.player pause];
    [self.player seekToTime:kCMTimeZero];
}
-(void)trocarEstacao : (NSString*)fluxo{
    
    
    if ([fluxo isEqual:@"aumentar"] ) {
        self->estacaoAtual++;
    }
    else if (self->estacaoAtual < self.estacoes.count){
        self->estacaoAtual = 0;
    }
    else
        self->estacaoAtual--;
    
}
-(void)trocarVideo : (NSString*)fluxo{
    
    if ([fluxo isEqual:@"aumentar"] ) {
        self->videoAtual++;
    }
    else if (self->videoAtual >= self.videos.count){
        self->videoAtual = 0;
    }
    else
        self->videoAtual--;
    
}

@end
