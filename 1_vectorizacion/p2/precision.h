#ifndef PRECISION_GUARD
    #define PRECISION_GUARD

    #ifndef PRECISION
        #define PRECISION 0
    #endif

    #if PRECISION==0
        #define real float
        #define SSE_LEN 4
        #define AVX_LEN 8
        #define AVX512_LEN  16
    #else
        #define real double
        #define SSE_LEN 2
        #define AVX_LEN 4
        #define AVX512_LEN  8
    #endif

#endif // PRECISION_GUARD
