//
//  RGLCISSyscalls.h
//  RegulaCommon
//
//  Created by Антон Потапчик on 15.09.25.
//  Copyright © 2025 Regula. All rights reserved.
//

#ifndef RGLCISSyscalls_h
#define RGLCISSyscalls_h

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#if __GNUC__ >= 4
#define IS_API __attribute__((visibility("default")))
#else
#define IS_API
#endif

enum {
  IS_CAT_PATHS   = 0, // OPT0
  IS_CAT_WRITE   = 1, // OPT1
  IS_CAT_MODULES = 2, // OPT2
  IS_CAT_CLASSES = 3, // OPT3
  IS_CAT_ENV     = 4, // OPT4
  IS_CAT_PROCENV = 5, // OPT5
  IS_CAT_POSIX   = 6, // OPT6
  IS_CAT_COUNT   = 7
};

typedef struct {
  uint64_t options;
  uint64_t masks[IS_CAT_COUNT];
} ISResult;

IS_API ISResult is_analyze(void);

IS_API char *is_meta_from(ISResult r);
IS_API void  is_free_str(char *s);

#ifdef __cplusplus
}
#endif

#endif /* RGLCISSyscalls_h */
