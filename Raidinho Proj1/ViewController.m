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
    //GestoEmL *gestoL=[[GestoEmL alloc]initWithTarget:self action:@selector(testeGesto)];
    UITapGestureRecognizer *tapPlay = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playVideo:)];
     self.play = [[Player alloc]init];
    [self.viewDoVideo addGestureRecognizer:tapPlay];
    
    [self.tituloDoVideo setText:self.play.nomeDoVideo];
    [self.tituloDoVideo setTextAlignment:NSTextAlignmentCenter];
    //[self.tituloDoVideo intrinsicContentSize];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *toque=[touches anyObject];
    
    if ([toque tapCount] > 1) {
        [self.play pararVideo];
    }
    if ([self.play.playerView.moviePlayer  playbackState]  != MPMoviePlaybackStateStopped) {
        [self.play pausarVideo];
    }
}
-(IBAction)playVideo:(UITapGestureRecognizer*)tap{
    [self.play playVideo:self.view];
    [self.play trocarVideo:@"aumentar"];
    [self.tituloDoVideo setText:self.play.nomeDoVideo];
    //[self.tituloDoVideo intrinsicContentSize];
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
