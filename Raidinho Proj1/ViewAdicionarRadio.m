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
        
        self->_numeroEstacao=arc4random()%10;
        
        self.urlEstacaoAdd=[[UITextField alloc]initWithFrame:CGRectMake(self.frame.origin.x+10, self.frame.origin.y+10, self.frame.size.width - 10, self.frame.size.height - 10)];
        
        
        [self addSubview:self.urlEstacaoAdd];
    }
    
    return self;
}

-(BOOL)urlValida{
    
    NSURL *url=[NSURL URLWithString:self.urlEstacaoAdd.text];
    AVPlayerItem *testeUrl=[[AVPlayerItem alloc]initWithURL:url];
    
    if ([testeUrl status]==AVPlayerItemStatusReadyToPlay) {
        return YES;
    }else{
        return NO;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([self urlValida]) {
        //Chama o metodo do target que ira adicionar a Url
        [self->target performSelector:self->selAddUrl withObject:self.urlEstacaoAdd.text];
        
    }else{
        UIAlertView *erroUrl=[[UIAlertView alloc]initWithTitle:Nil message:@"Erro ao acessar a Url informada" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [erroUrl show];
    }
    
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
