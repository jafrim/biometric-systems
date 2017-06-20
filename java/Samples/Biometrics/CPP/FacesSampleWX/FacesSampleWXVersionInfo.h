#ifndef FACES_SAMPLE_WX_VERSION_INFO_H_INCLUDED
#define FACES_SAMPLE_WX_VERSION_INFO_H_INCLUDED

namespace Neurotec { namespace Samples
{

#ifndef wxT
#define wxT(x) x
#endif

#define FACES_SAMPLE_WX_PRODUCT_NAME wxT("Faces Identification Technology Sample")
#define FACES_SAMPLE_WX_INTERNAL_NAME wxT("FacesSampleWX")
#define FACES_SAMPLE_WX_TITLE FACES_SAMPLE_WX_PRODUCT_NAME

#define FACES_SAMPLE_WX_COMPANY_NAME wxT("Neurotechnology")
#ifdef N_PRODUCT_LIB
#define FACES_SAMPLE_WX_FILE_NAME FACES_SAMPLE_WX_INTERNAL_NAME wxT("Lib.exe")
#else
#define FACES_SAMPLE_WX_FILE_NAME FACES_SAMPLE_WX_INTERNAL_NAME wxT(".exe")
#endif
#define FACES_SAMPLE_WX_COPYRIGHT wxT("Copyright (C) 2009-2017 Neurotechnology")
#define FACES_SAMPLE_WX_VERSION_MAJOR 9
#define FACES_SAMPLE_WX_VERSION_MINOR 0
#define FACES_SAMPLE_WX_VERSION_BUILD 0
#define FACES_SAMPLE_WX_VERSION_REVISION 0
#define FACES_SAMPLE_WX_VERSION_STRING wxT("9.0.0.0")

}}

#endif // !FACES_SAMPLE_WX_VERSION_INFO_H_INCLUDED