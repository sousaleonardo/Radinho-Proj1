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

@interface ViewController : UIViewController


@property AVPlayer *player;
@property (strong, nonatomic) IBOutlet UIView *viewDoVideo;

@end
