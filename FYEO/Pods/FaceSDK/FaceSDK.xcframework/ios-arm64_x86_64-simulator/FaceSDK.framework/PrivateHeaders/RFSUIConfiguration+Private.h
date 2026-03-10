//
//  RFSUIConfiguration+Private.h
//  FaceSDK
//
//  Created by Антон Потапчик on 21.01.26.
//  Copyright © 2026 Regula. All rights reserved.
//

#import <FaceSDK/RFSUIConfiguration.h>

NS_ASSUME_NONNULL_BEGIN

@interface RFSUIConfiguration (Private)

+ (instancetype)configurationWithJSON:(NSDictionary<NSString *, id> *)json;

@end

NS_ASSUME_NONNULL_END
