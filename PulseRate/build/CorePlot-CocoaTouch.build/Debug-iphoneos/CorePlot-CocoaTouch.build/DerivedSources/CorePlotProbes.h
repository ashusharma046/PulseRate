/*
 * Generated by dtrace(1M).
 */

#ifndef	_COREPLOTPROBES_H
#define	_COREPLOTPROBES_H

#include <unistd.h>

#ifdef	__cplusplus
extern "C" {
#endif

#define COREPLOT_STABILITY "___dtrace_stability$CorePlot$v1$1_1_0_1_1_0_1_1_0_1_1_0_1_1_0"

#define COREPLOT_TYPEDEFS "___dtrace_typedefs$CorePlot$v2"

#define	COREPLOT_LAYER_POSITION_CHANGE(arg0, arg1, arg2, arg3, arg4) \
do { \
	__asm__ volatile(".reference " COREPLOT_TYPEDEFS); \
	__dtrace_probe$CorePlot$layer_position_change$v1$63686172202a$696e74$696e74$696e74$696e74(arg0, arg1, arg2, arg3, arg4); \
	__asm__ volatile(".reference " COREPLOT_STABILITY); \
} while (0)
#define	COREPLOT_LAYER_POSITION_CHANGE_ENABLED() \
	__dtrace_isenabled$CorePlot$layer_position_change$v1()


extern void __dtrace_probe$CorePlot$layer_position_change$v1$63686172202a$696e74$696e74$696e74$696e74(char *, int, int, int, int);
extern int __dtrace_isenabled$CorePlot$layer_position_change$v1(void);

#ifdef	__cplusplus
}
#endif

#endif	/* _COREPLOTPROBES_H */