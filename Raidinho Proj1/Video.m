//
//  Video.m
//  Raidinho Proj1
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 26/03/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "Video.h"

@implementation Video

-(id)initWithName :(NSString*)nome AndUrl :(NSString*) url{
    
    if (self = [super init]) {
        
        self.nome = nome;
        self.url =url;
        
    }
    return self;
}

@end
