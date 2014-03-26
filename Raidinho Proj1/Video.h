//
//  Video.h
//  Raidinho Proj1
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 26/03/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject

@property NSString *nome;
@property NSString *url;

-(id)initWithName :(NSString*)nome AndUrl :(NSString*) url;

@end
