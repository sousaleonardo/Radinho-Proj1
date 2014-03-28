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
    
    GestoEmL *gestoL=[[GestoEmL alloc]initWithTarget:self action:@selector(testeGesto)];
    
    Player *play = [[Player alloc]init];
    
    [play playEstacao];
    
    self.player = [play player];
    
   
    [self.view addGestureRecognizer:gestoL];
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
