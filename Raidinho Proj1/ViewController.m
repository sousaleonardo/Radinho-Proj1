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
    
    [self.viewDoVideo addGestureRecognizer:tapPlay];
    
    [self.tituloDoVideo setText:self.player.nomeDoVideo];
    [self.tituloDoVideo setTextAlignment:NSTextAlignmentCenter];
    
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *toque=[touches anyObject];
    
    if ([toque tapCount] > 1) {
        [self.player pararVideo];
    }
    if ([self.player.playerView.moviePlayer  playbackState]  != MPMoviePlaybackStateStopped) {
        [self.player pausarVideo];
    }
}
-(IBAction)playVideo:(UITapGestureRecognizer*)tap{
    [self.player playVideo:self.view];
    [self.player trocarVideo:@"aumentar"];
    [self.tituloDoVideo setText:self.player.nomeDoVideo];
    //[self.tituloDoVideo intrinsicContentSize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
