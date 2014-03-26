//
//  Estacao.h
//  Raidinho Proj1
//
//  Created by LEONARDO DE SOUSA MENDES on 26/03/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Estacao : NSObject

@property float nEstacao;
@property NSString* streaming;

-(id)init: (NSString*)streaming :(float)nEstacao;

@end
