/** @file optional_features.h
 * @brief Preprocessor directives to manage RT-Bench optional features.
 * @details __NOTE__: This file has to be included in all header files.
 **/
#ifndef RT_BENCH_OPTIONAL_FEATURES_H
#define RT_BENCH_OPTIONAL_FEATURES_H
///Value for optional features enabled state.
#define OPT_FEAT_ENABLED 1
///Value for optional features disabled state.
#define OPT_FEAT_DISABLED 0

//sanity checks for optional features
#if (defined FEAT_JSON_SUPPORT && FEAT_JSON_SUPPORT != OPT_FEAT_ENABLED &&     \
     FEAT_JSON_SUPPORT != OPT_FEAT_DISABLED)
#error "FEAT_JSON_SUPPORT must be OPT_FEAT_ENABLED or OPT_FEAT_DISABLED"
#endif
#if (defined FEAT_SCHED_DEADLINE_SUPPORT &&                                    \
     FEAT_SCHED_DEADLINE_SUPPORT != OPT_FEAT_ENABLED &&                        \
     FEAT_SCHED_DEADLINE_SUPPORT != OPT_FEAT_DISABLED)
#error "FEAT_SCHED_DEADLINE_SUPPORT must be OPT_FEAT_ENABLED or OPT_FEAT_DISABLED"
#endif
#if (defined FEAT_PERF_SUPPORT && FEAT_PERF_SUPPORT != OPT_FEAT_ENABLED &&     \
     FEAT_PERF_SUPPORT != OPT_FEAT_DISABLED)
#error "FEAT_PERF_SUPPORT must be OPT_FEAT_ENABLED or OPT_FEAT_DISABLED"
#endif

//check if json-c is available
#if (FEAT_JSON_SUPPORT== OPT_FEAT_ENABLED && defined __has_include &&                    \
     __has_include(<json-c/json.h>) )
#include <json-c/json.h>
#if JSON_C_VERSION_NUM >= 0x000f00
/// Indicates whether the json parser is supported.
#define JSON_SUPPORT
#endif
#endif

// If  SCHED_DEADLINE is not defined we cannot use the deadline scheduler.
#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#include <sched.h>
#if (!defined FEAT_SCHED_DEADLINE_SUPPORT && defined SCHED_DEADLINE) ||        \
	FEAT_SCHED_DEADLINE_SUPPORT == OPT_FEAT_ENABLED
/// Indicates whether the deadline scheduler is supported.
#define SCHED_DEADLINE_SUPPORT
#endif

#if defined FEAT_PERF_SUPPORT && FEAT_PERF_SUPPORT == OPT_FEAT_ENABLED &&      \
	!defined CORTEX_A53 && !defined CORE_I7
#error "Unsupported platform for perf counters."
#endif
#if !defined FEAT_PRINT_SKIPPED_DEADLINE_SUPPORT ||                            \
	FEAT_PRINT_SKIPPED_DEADLINE_SUPPORT == OPT_FEAT_ENABLED
/// Indicates whether to print skipped deadelines with 0s.
#define PRINT_SKIPPED_DEADLINE
#endif
#endif
