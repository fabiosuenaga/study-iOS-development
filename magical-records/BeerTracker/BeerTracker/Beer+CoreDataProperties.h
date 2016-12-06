//
//  Beer+CoreDataProperties.h
//  BeerTracker
//
//  Created by Fabio Suenaga on 05/12/16.
//  Copyright © 2016 Andy Pereira. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Beer.h"

NS_ASSUME_NONNULL_BEGIN

@interface Beer (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) BeerDetails *beerDetails;

@end

NS_ASSUME_NONNULL_END
