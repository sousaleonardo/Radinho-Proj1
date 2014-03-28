//
//  Player.h
//  Raidinho Proj1
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 26/03/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Estacao.h"
#import "Video.h"

@interface Player : NSObject
{
    int videoAtual;
    int estacaoAtual;
}

@property NSMutableArray *estacoes;
@property NSMutableArray *videos;
@property AVPlayer *player;
@property AVPlayerLayer *layerDoVideo;

-(id)init;
-(void)playEstacao;
-(void)playVideo : (UIView*)view;
-(void)trocarEstacao : (NSString*)fluxo;
-(void)trocarVideo : (NSString*)fluxo;
-(void)pausarVideo;
-(void)pararVideo;

-(void)inicializaEstacoes : (NSString*) caminhoDoArquivo;
-(void)inicializaVideo : (NSString*) caminhoDoArquivo;

@end
