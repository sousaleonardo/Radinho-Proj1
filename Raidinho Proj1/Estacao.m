//
//  Estacao.m
//  Raidinho Proj1
//
//  Created by LEONARDO DE SOUSA MENDES on 26/03/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "Estacao.h"

@implementation Estacao
@synthesize nEstacao,streaming;

-(id)init: (NSString*)stringStreaming :(float)nEst{
    
    self = [super init];
    if (self) {
        self.nEstacao=nEst;
        self.streaming=stringStreaming;
    }
    return  self;
}

@end
