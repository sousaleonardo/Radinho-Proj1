//
//  ViewAdicionarRadio.h
//  Raidinho Proj1
//
//  Created by LEONARDO DE SOUSA MENDES on 09/04/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewAdicionarRadio : UIView

{
    id target;
    SEL selAddUrl;
}

@property UITextField *urlEstacaoAdd;
@property float numeroEstacao;

@end
