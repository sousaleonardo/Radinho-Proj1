//
//  ViewAdicionarRadio.m
//  Raidinho Proj1
//
//  Created by LEONARDO DE SOUSA MENDES on 09/04/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "ViewAdicionarRadio.h"

@implementation ViewAdicionarRadio

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithTarget: (CGRect)frame :(id)_target :(SEL)_selAddUrl{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        self->target=_target;
        self->selAddUrl=_selAddUrl;
        
        self.numeroEstacao=[[UITextField alloc]initWithFrame:CGRectMake(5,25,self.frame.size.width-250,self.frame.size.height -60)];
        
        [self.numeroEstacao setDelegate:self];
        [self.numeroEstacao resignFirstResponder];
        [self.numeroEstacao setBorderStyle:UITextBorderStyleRoundedRect];
        [self.numeroEstacao setBackgroundColor:[UIColor whiteColor]];
        [self.numeroEstacao setPlaceholder:@"Insira o numero da rádio"];
        [self.numeroEstacao setKeyboardType:UIKeyboardTypeDecimalPad];
        
        self.urlEstacaoAdd=[[UITextField alloc]initWithFrame:CGRectMake(5,50,self.frame.size.width-170,self.frame.size.height -60)];
        
        [self.urlEstacaoAdd setDelegate:self];
        [self.urlEstacaoAdd resignFirstResponder];
        [self.urlEstacaoAdd setBorderStyle:UITextBorderStyleRoundedRect];
        [self.urlEstacaoAdd setBackgroundColor:[UIColor whiteColor]];
        [self.urlEstacaoAdd setPlaceholder:@"Insira a url a ser adicionada"];
        [self setBackgroundColor:[UIColor colorWithRed:233.0f/255.0f green:207.0f/255.0f blue:160.0f/255.0f alpha:0.3f]];
        
        
        [self setBackgroundColor:[UIColor colorWithRed:233.0f/255.0f green:207.0f/255.0f blue:160.0f/255.0f alpha:0.3f]];
        
        [self addSubview:self.urlEstacaoAdd];
        [self addSubview:self.numeroEstacao];
    }
    
    return self;
}

-(BOOL)urlValida{
    /*
     NSURL *url=[NSURL URLWithString:self.urlEstacaoAdd.text];
     AVPlayerItem *_testeUrl=[[AVPlayerItem alloc]initWithURL:url];
     
     //Criar um player que contera o objecto com a url
     AVPlayer *testeUrl=[[AVPlayer alloc]initWithPlayerItem:_testeUrl];
     
     [testeUrl play];
     
     if ([testeUrl status]==AVPlayerItemStatusReadyToPlay) {
     return YES;
     }else{
     return NO;
     }
     */
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSNumber *numEstacao=(NSNumber*)self.numeroEstacao.text;
    
    if ([self urlValida]) {
        //Valida se tem numero da radio
        if ([numEstacao isEqual:@""]) {
            numEstacao=[NSNumber numberWithInt:arc4random()%100];
        }else{
            numEstacao=self.numeroEstacao.text;
        }
        
        //Chama o metodo do target que ira adicionar a Url
        [self->target performSelector:self->selAddUrl withObject:self.urlEstacaoAdd.text withObject:numEstacao];
        
    }else{
        UIAlertView *erroUrl=[[UIAlertView alloc]initWithTitle:Nil message:@"Erro ao acessar a Url informada" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [erroUrl show];
    }
    
    
    //Limpa as textFields
    self.urlEstacaoAdd.text=Nil;
    self.numeroEstacao.text=Nil;
    
    return YES;
}


@end
