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
        
        [self inicializaVideo:[[NSBundle mainBundle] pathForResource:@"filename"
                                                             ofType:@"txt"]];
        
        [self inicializaEstacoes:[[NSBundle mainBundle] pathForResource:@"filename"
                                                                ofType:@"txt"]];
        
    }
    
    return self;
    
}

-(void)inicializaEstacoes : (NSString*)caminhoDoArquivo{
    
    
    NSArray *arquivo = [NSArray arrayWithContentsOfFile:caminhoDoArquivo];
    NSString *nomeDaRadio = [[NSString alloc]init];
    NSString *numeroDaradio = [[NSString alloc]init];
    
    for (int i = 0; i < arquivo.count; i++) {
        nomeDaRadio = [arquivo objectAtIndex:i];
        
        NSRange comecoDoEndereco = [nomeDaRadio rangeOfString:@"$"];
        
        NSRange comecoDoNumero = [nomeDaRadio rangeOfString:@"#"];
        
        NSRange final = [nomeDaRadio rangeOfString:@" "];
        
        NSRange endereco = NSMakeRange(comecoDoEndereco.location , final.location);
        
        NSRange numero = NSMakeRange(comecoDoNumero.location, final.location);
        
        numeroDaradio = [nomeDaRadio substringWithRange:numero];
        
        Estacao *estacao = [[Estacao alloc]init:[nomeDaRadio substringWithRange:endereco] :[numeroDaradio floatValue]] ;
        
        [self.estacoes addObject:estacao];
    }
}
-(void)inicializaVideo : (NSString*)caminhoDoArquivo{
    
    NSArray *arquivo = [NSArray arrayWithContentsOfFile:caminhoDoArquivo];
    NSString *nomeDoVideo = [[NSString alloc]init];
    
    
    for (int i = 0; i < arquivo.count; i++) {
        nomeDoVideo = [arquivo objectAtIndex:i];
        
        NSRange comecoDaUrl = [nomeDoVideo rangeOfString:@"$"];
        
        NSRange comecoDoNome = [nomeDoVideo rangeOfString:@"#"];
        
        NSRange final = [nomeDoVideo rangeOfString:@" "];
        
        NSRange nome = NSMakeRange(comecoDoNome.location , final.location);
        
        NSRange url = NSMakeRange(comecoDaUrl.location, final.location);
        
        Video *video = [[Video alloc]initWithName:[nomeDoVideo substringWithRange:nome] AndUrl:[nomeDoVideo substringWithRange:url]] ;
        
        [self.videos addObject:video];
    }
}

-(void)playEstacao{
    
}
-(void)playVideo{
    
}
-(void)trocarEstacao : (NSString*)fluxo{
    
}
-(void)trocarVideo : (NSString*)fluxo{
    
}

@end
