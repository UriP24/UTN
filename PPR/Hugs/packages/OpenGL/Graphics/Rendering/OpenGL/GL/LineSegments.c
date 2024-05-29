/* Machine generated file, do not modify */
#include <stdlib.h>
#include "HsFFI.h"
#include "HsOpenGL.h"

static HugsAPI5 *hugs = 0;

#ifndef ENABLE_MACRO_INTERFACE
#undef glLineStipple
#endif

static void hugsprim_glLineStipple_1(HugsStackPtr);
static void hugsprim_glLineStipple_1(HugsStackPtr hugs_root)
{
    HsInt32 arg1;
    HsWord16 arg2;
    arg1 = hugs->getInt32();
    arg2 = hugs->getWord16();
    glLineStipple(arg1, arg2);
    
    hugs->returnIO(hugs_root,0);
}

#ifndef ENABLE_MACRO_INTERFACE
#undef glLineWidth
#endif

static void hugsprim_glLineWidth_0(HugsStackPtr);
static void hugsprim_glLineWidth_0(HugsStackPtr hugs_root)
{
    HsFloat arg1;
    arg1 = hugs->getFloat();
    glLineWidth(arg1);
    
    hugs->returnIO(hugs_root,0);
}

static struct hugs_primitive hugs_primTable[] = {
    {"glLineStipple", 3, hugsprim_glLineStipple_1},
    {"glLineWidth", 2, hugsprim_glLineWidth_0},
};

static void hugs_primControl(int);
static void hugs_primControl(what)
int what; {
}

#ifdef STATIC_LINKAGE
#define initModule initGROGLineSegments
#endif

static struct hugs_primInfo hugs_prims = { hugs_primControl, hugs_primTable, 0 };

#ifdef __cplusplus
extern "C" {
#endif
#ifndef __cplusplus
DLLEXPORT(int)  HugsAPIVersion(void);
#endif
DLLEXPORT(int)  HugsAPIVersion() {return (5);}
DLLEXPORT(void) initModule(HugsAPI5 *);
DLLEXPORT(void) initModule(HugsAPI5 *hugsAPI) {
    hugs = hugsAPI;
    hugs->registerPrims(&hugs_prims);
}
#ifdef __cplusplus
}
#endif

