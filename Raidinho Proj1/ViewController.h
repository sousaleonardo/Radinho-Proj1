//
//  ViewController.h
//  Raidinho Proj1
//
//  Created by LEONARDO DE SOUSA MENDES on 26/03/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Estacao.h"
#import "GestoEmL.h"
#import "Player.h"
#import <AVFoundation/AVFoundation.h>
#import "RadioViewController.h"


@interface ViewController : RadioViewController


@property (strong, nonatomic) IBOutlet UIView *viewDoVideo;
@property (strong, nonatomic) IBOutlet UITextView *tituloDoVideo;
@property MPMoviePlayerController* playerDeVideo;

@property (strong, nonatomic) IBOutlet UIImageView *volume;
@property (strong, nonatomic) IBOutlet UIImageView *mudarVideo;

@end
