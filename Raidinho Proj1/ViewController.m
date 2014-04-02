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
	// Do any additional setup after loading the view, typically from a nib.
    
    //[self.view setBackgroundColor:[UIColor purpleColor]];
    
    Estacao *estacao=[[Estacao alloc]init:@"www.faceboook.com.br" :89.1];
    
    NSLog(@"%f",[estacao nEstacao]);
    NSLog(@"%@",[estacao streaming]);
    
    //GestoEmL *gestoL=[[GestoEmL alloc]initWithTarget:self action:@selector(testeGesto)];
  
    
    
    
    self.play = [[Player alloc]init];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *toque=[touches anyObject];
    CGPoint lugarDoToque = [toque locationInView:self.view];
    CGPoint lugarDoBotao = self.botaoDeAjuda.frame.origin;
    if (CGPointEqualToPoint(lugarDoToque, lugarDoBotao) ) {
        return;
    }
    if ([toque tapCount] > 1) {
        [self.play pararVideo];
        
        
    }
    else if ([self.play.playerView.moviePlayer  playbackState]  != MPMoviePlaybackStateStopped) {
            [self.play pausarVideo];
        }
        else
            [self.play playVideo:self.view];
    
}

                                                  
                                                  
                                                  

-(void)testeGesto{
    NSLog(@"Reconheceu gesto");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
