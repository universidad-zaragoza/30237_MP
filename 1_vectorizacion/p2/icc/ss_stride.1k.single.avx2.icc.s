	.section .text
.LNDBG_TX:
# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 18.0.2.199 Build 20180210";
# mark_description "-march=core-avx2 -vec-threshold0 -std=c11 -g -O3 -Wall -DPRECISION=0 -DLEN=1024 -unroll0 -S -fsource-asm -o ";
# mark_description "assembler/ss_stride.1k.single.avx2.icc.s";
	.file "ss_stride.c"
	.text
..TXTST0:
.L_2__routine_start_main_0:
# -- Begin  main
	.text
# mark_begin;
       .align    16,0x90
	.globl main
# --- main()
main:
..B1.1:                         # Preds ..B1.0
                                # Execution count [1.00e+00]

### {

	.cfi_startproc
..___tag_value_main.2:
..L3:
                                                          #176.1
..LN0:
	.file   1 "../ss_stride.c"
	.loc    1  176  is_stmt 1
        pushq     %rbp                                          #176.1
	.cfi_def_cfa_offset 16
..LN1:
        movq      %rsp, %rbp                                    #176.1
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
..LN2:
        andq      $-128, %rsp                                   #176.1
..LN3:
        pushq     %r12                                          #176.1
..LN4:
        subq      $120, %rsp                                    #176.1
..LN5:
        xorl      %esi, %esi                                    #176.1
..LN6:
        movl      $3, %edi                                      #176.1
..LN7:
        call      __intel_new_feature_proc_init                 #176.1
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
..LN8:
                                # LOE rbx r12 r13 r14 r15
..B1.26:                        # Preds ..B1.1
                                # Execution count [1.00e+00]
..LN9:
        vstmxcsr  (%rsp)                                        #176.1
..LN10:
	.loc    1  177  prologue_end  is_stmt 1

###   printf("                     Time       TPI\n");

        movl      $il0_peep_printf_format_0, %edi               #177.3
..LN11:
	.loc    1  176  is_stmt 1
        orl       $32832, (%rsp)                                #176.1
..LN12:
        vldmxcsr  (%rsp)                                        #176.1
..LN13:
	.loc    1  177  is_stmt 1
        call      puts                                          #177.3
..LN14:
                                # LOE rbx r12 r13 r14 r15
..B1.2:                         # Preds ..B1.26
                                # Execution count [1.00e+00]
..LN15:
	.loc    1  178  is_stmt 1

###   printf("             Loop     ns       ps/el     Checksum\n");

        movl      $il0_peep_printf_format_1, %edi               #178.3
..LN16:
        call      puts                                          #178.3
..LN17:
                                # LOE rbx r12 r13 r14 r15
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
..___tag_value_main.9:
..LN18:
	.loc    1  112  is_stmt 1
#       init()
        call      init                                          #112.3
..___tag_value_main.10:
..LN19:
                                # LOE rbx r12 r13 r14 r15
..B1.4:                         # Preds ..B1.3
                                # Execution count [1.00e+00]
..___tag_value_main.11:
..LN20:
	.loc    1  113  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #113.13
..___tag_value_main.12:
..LN21:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.27:                        # Preds ..B1.4
                                # Execution count [1.00e+00]
..LN22:
        vmovsd    %xmm0, (%rsp)                                 #113.13[spill]
..LN23:
                                # LOE rbx r12 r13 r14 r15
..B1.5:                         # Preds ..B1.27
                                # Execution count [9.00e-01]
..LN24:
	.loc    1  114  is_stmt 1
        xorl      %eax, %eax                                    #114.3
..LN25:
        movl      %eax, %r12d                                   #114.3
..LN26:
                                # LOE rbx r13 r14 r15 r12d
..B1.6:                         # Preds ..B1.9 ..B1.5
                                # Execution count [5.00e+00]
..L14:
                # optimization report
                # LOOP WITH UNSIGNED INDUCTION VARIABLE
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
                # COST MODEL DECISION WAS IGNORED
..LN27:
	.loc    1  119  is_stmt 1
        vmovss    .L_2il0floatpacket.1(%rip), %xmm1             #119.5
..LN28:
        xorl      %edx, %edx                                    #119.5
..LN29:
        vmovss    .L_2il0floatpacket.0(%rip), %xmm2             #119.5
..LN30:
                                # LOE rbx r13 r14 r15 edx r12d xmm1 xmm2
..B1.7:                         # Preds ..B1.7 ..B1.6
                                # Execution count [5.12e+03]
..L15:
                # optimization report
                # %s was not vectorized: novector directive used
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN31:
	.loc    1  121  is_stmt 1
        lea       (%rdx,%rdx), %ecx                             #121.20
..LN32:
	.loc    1  119  is_stmt 1
        incl      %edx                                          #119.5
..LN33:
	.loc    1  121  is_stmt 1
        vmovss    x(,%rcx,4), %xmm0                             #121.20
..LN34:
        vfmadd213ss %xmm2, %xmm1, %xmm0                         #121.7
..LN35:
        vmovss    %xmm0, x(,%rcx,4)                             #121.7
..LN36:
	.loc    1  119  is_stmt 1
        cmpl      $1024, %edx                                   #119.5
..LN37:
        jb        ..B1.7        # Prob 99%                      #119.5
..LN38:
                                # LOE rbx r13 r14 r15 edx r12d xmm1 xmm2
..B1.8:                         # Preds ..B1.7
                                # Execution count [5.00e+00]
..LN39:
	.loc    1  123  is_stmt 1
        movl      $x, %edi                                      #123.5
..LN40:
        vmovss    .L_2il0floatpacket.1(%rip), %xmm0             #123.5
..LN41:
        vmovss    .L_2il0floatpacket.0(%rip), %xmm1             #123.5
..___tag_value_main.16:
..LN42:
#       dummy(float *, float, float)
        call      dummy                                         #123.5
..___tag_value_main.17:
..LN43:
                                # LOE rbx r13 r14 r15 r12d
..B1.9:                         # Preds ..B1.8
                                # Execution count [5.00e+00]
..LN44:
	.loc    1  114  is_stmt 1
        incl      %r12d                                         #114.3
..LN45:
        cmpl      $15728640, %r12d                              #114.3
..LN46:
        jb        ..B1.6        # Prob 82%                      #114.3
..LN47:
                                # LOE rbx r13 r14 r15 r12d
..B1.10:                        # Preds ..B1.9
                                # Execution count [1.00e+00]
..___tag_value_main.18:
..LN48:
	.loc    1  125  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #125.11
..___tag_value_main.19:
..LN49:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.11:                        # Preds ..B1.10
                                # Execution count [1.00e+00]
..LN50:
	.loc    1  126  is_stmt 1
        movl      $.L_2__STRING.2, %edi                         #126.3
..LN51:
        vsubsd    (%rsp), %xmm0, %xmm0                          #126.3[spill]
..___tag_value_main.20:
..LN52:
#       results(const double, const char *)
        call      results                                       #126.3
..___tag_value_main.21:
..LN53:
                                # LOE rbx r12 r13 r14 r15
..B1.12:                        # Preds ..B1.11
                                # Execution count [1.00e+00]
..LN54:
	.loc    1  127  is_stmt 1
        movl      $x, %edi                                      #127.3
..___tag_value_main.23:
..LN55:
#       check(float *)
        call      check                                         #127.3
..___tag_value_main.24:
..LN56:
                                # LOE rbx r12 r13 r14 r15
..B1.13:                        # Preds ..B1.12
                                # Execution count [1.00e+00]
..___tag_value_main.25:
..LN57:
	.loc    1  135  is_stmt 1
#       init()
        call      init                                          #135.3
..___tag_value_main.26:
..LN58:
                                # LOE rbx r12 r13 r14 r15
..B1.14:                        # Preds ..B1.13
                                # Execution count [1.00e+00]
..___tag_value_main.27:
..LN59:
	.loc    1  136  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #136.13
..___tag_value_main.28:
..LN60:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.29:                        # Preds ..B1.14
                                # Execution count [1.00e+00]
..LN61:
        vmovsd    %xmm0, (%rsp)                                 #136.13[spill]
..LN62:
                                # LOE rbx r12 r13 r14 r15
..B1.15:                        # Preds ..B1.29
                                # Execution count [9.00e-01]
..LN63:
	.loc    1  137  is_stmt 1
        xorl      %eax, %eax                                    #137.3
..LN64:
	.loc    1  121  is_stmt 1
        vmovups   .L_2il0floatpacket.2(%rip), %ymm3             #121.27
..LN65:
	.loc    1  141  is_stmt 1
        movl      %eax, %r12d                                   #141.22
..LN66:
                                # LOE rbx r13 r14 r15 r12d
..B1.16:                        # Preds ..B1.19 ..B1.15
                                # Execution count [5.00e+00]
..L30:
                # optimization report
                # LOOP WITH UNSIGNED INDUCTION VARIABLE
                # %s was not vectorized: inner loop was already vectorized
..LN67:
	.loc    1  137  is_stmt 1
..LN68:
	.loc    1  139  is_stmt 1
        vmovups   .L_2il0floatpacket.4(%rip), %ymm4             #139.5
..LN69:
        xorl      %edx, %edx                                    #139.5
..LN70:
        vmovups   .L_2il0floatpacket.3(%rip), %ymm5             #139.5
..LN71:
        vmovups   .L_2il0floatpacket.2(%rip), %ymm6             #139.5
..LN72:
        vpcmpeqd  %ymm3, %ymm3, %ymm3                           #139.5
..LN73:
                                # LOE rbx r13 r14 r15 edx r12d ymm3 ymm4 ymm5 ymm6
..B1.17:                        # Preds ..B1.17 ..B1.16
                                # Execution count [5.12e+03]
..L31:
                # optimization report
                # LOOP WAS VECTORIZED
                # VECTORIZATION SPEEDUP COEFFECIENT 1.524414
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
                # VECTOR LENGTH 8
                # MAIN VECTOR TYPE: 32-bits floating point
                # COST MODEL DECISION WAS IGNORED
..LN74:
	.loc    1  141  is_stmt 1
        vmovdqa   %ymm3, %ymm0                                  #141.22
..LN75:
        lea       (%rdx,%rdx), %ecx                             #141.22
..LN76:
        vxorps    %ymm1, %ymm1, %ymm1                           #141.22
..LN77:
        lea       (,%rcx,4), %rsi                               #141.22
..LN78:
        vgatherdps %ymm0, x(%rsi,%ymm4,8), %ymm1                #141.22
..LN79:
	.loc    1  139  is_stmt 1
        addl      $8, %edx                                      #139.5
..LN80:
	.loc    1  141  is_stmt 1
        vfmadd213ps %ymm6, %ymm5, %ymm1                         #141.29
..LN81:
	.loc    1  139  is_stmt 1
        cmpl      $1024, %edx                                   #139.5
..LN82:
	.loc    1  141  is_stmt 1
        vextractf128 $1, %ymm1, %xmm2                           #141.9
..LN83:
        vmovss    %xmm1, x(,%rcx,4)                             #141.9
..LN84:
        vmovss    %xmm2, 32+x(,%rcx,4)                          #141.9
..LN85:
        vextractps $1, %xmm1, 8+x(,%rcx,4)                      #141.9
..LN86:
        vextractps $2, %xmm1, 16+x(,%rcx,4)                     #141.9
..LN87:
        vextractps $3, %xmm1, 24+x(,%rcx,4)                     #141.9
..LN88:
        vextractps $1, %xmm2, 40+x(,%rcx,4)                     #141.9
..LN89:
        vextractps $2, %xmm2, 48+x(,%rcx,4)                     #141.9
..LN90:
        vextractps $3, %xmm2, 56+x(,%rcx,4)                     #141.9
..LN91:
	.loc    1  139  is_stmt 1
        jb        ..B1.17       # Prob 99%                      #139.5
..LN92:
                                # LOE rbx r13 r14 r15 edx r12d ymm3 ymm4 ymm5 ymm6
..B1.18:                        # Preds ..B1.17
                                # Execution count [5.00e+00]
..LN93:
	.loc    1  143  is_stmt 1
        vzeroupper                                              #143.5
..LN94:
        movl      $x, %edi                                      #143.5
..LN95:
        vmovss    .L_2il0floatpacket.1(%rip), %xmm0             #143.5
..LN96:
        vmovss    .L_2il0floatpacket.0(%rip), %xmm1             #143.5
..___tag_value_main.32:
..LN97:
#       dummy(float *, float, float)
        call      dummy                                         #143.5
..___tag_value_main.33:
..LN98:
                                # LOE rbx r13 r14 r15 r12d
..B1.19:                        # Preds ..B1.18
                                # Execution count [5.00e+00]
..LN99:
	.loc    1  137  is_stmt 1
        incl      %r12d                                         #137.3
..LN100:
        cmpl      $15728640, %r12d                              #137.3
..LN101:
        jb        ..B1.16       # Prob 82%                      #137.3
..LN102:
                                # LOE rbx r13 r14 r15 r12d
..B1.20:                        # Preds ..B1.19
                                # Execution count [1.00e+00]
..___tag_value_main.34:
..LN103:
	.loc    1  145  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #145.11
..___tag_value_main.35:
..LN104:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.21:                        # Preds ..B1.20
                                # Execution count [1.00e+00]
..LN105:
	.loc    1  146  is_stmt 1
        movl      $.L_2__STRING.3, %edi                         #146.3
..LN106:
        vsubsd    (%rsp), %xmm0, %xmm0                          #146.3[spill]
..___tag_value_main.36:
..LN107:
#       results(const double, const char *)
        call      results                                       #146.3
..___tag_value_main.37:
..LN108:
                                # LOE rbx r12 r13 r14 r15
..B1.22:                        # Preds ..B1.21
                                # Execution count [1.00e+00]
..LN109:
	.loc    1  147  is_stmt 1
        movl      $x, %edi                                      #147.3
..___tag_value_main.39:
..LN110:
#       check(float *)
        call      check                                         #147.3
..___tag_value_main.40:
..LN111:
                                # LOE rbx r12 r13 r14 r15
..B1.23:                        # Preds ..B1.22
                                # Execution count [1.00e+00]
..LN112:
	.loc    1  182  is_stmt 1

###   ss_stride_esc();
###   ss_stride_vec();
###   //ss_stride_v2(x);
###   return 0;

        xorl      %eax, %eax                                    #182.10
..LN113:
	.loc    1  182  epilogue_begin  is_stmt 1
        addq      $120, %rsp                                    #182.10
	.cfi_restore 12
..LN114:
        popq      %r12                                          #182.10
..LN115:
        movq      %rbp, %rsp                                    #182.10
..LN116:
        popq      %rbp                                          #182.10
	.cfi_def_cfa 7, 8
	.cfi_restore 6
..LN117:
        ret                                                     #182.10
        .align    16,0x90
..LN118:
                                # LOE
..LN119:
	.cfi_endproc
# mark_end;
	.type	main,@function
	.size	main,.-main
..LNmain.120:
.LNmain:
	.section .rodata.str1.4, "aMS",@progbits,1
	.align 4
	.align 4
il0_peep_printf_format_0:
	.long	538976288
	.long	538976288
	.long	538976288
	.long	538976288
	.long	538976288
	.long	1835619360
	.long	538976357
	.long	538976288
	.long	4804692
	.align 4
il0_peep_printf_format_1:
	.long	538976288
	.long	538976288
	.long	538976288
	.long	1869564960
	.long	538976368
	.long	1936597024
	.long	538976288
	.long	1881153568
	.long	1818570611
	.long	538976288
	.long	1701331744
	.long	1970498403
	.word	109
	.data
# -- End  main
	.text
.L_2__routine_start_get_wall_time_1:
# -- Begin  get_wall_time
	.text
# mark_begin;
       .align    16,0x90
	.globl get_wall_time
# --- get_wall_time()
get_wall_time:
..B2.1:                         # Preds ..B2.0
                                # Execution count [1.00e+00]

### {

	.cfi_startproc
..___tag_value_get_wall_time.49:
..L50:
                                                         #56.1
..LN121:
	.loc    1  56  is_stmt 1
        subq      $24, %rsp                                     #56.1
	.cfi_def_cfa_offset 32
..LN122:
	.loc    1  58  prologue_end  is_stmt 1

###     struct timeval time;
###     if (gettimeofday(&time,NULL)) {

        xorl      %esi, %esi                                    #58.9
..LN123:
        lea       (%rsp), %rdi                                  #58.9
..LN124:
#       gettimeofday(struct timeval *__restrict__, __timezone_ptr_t)
        call      gettimeofday                                  #58.9
..LN125:
                                # LOE rbx rbp r12 r13 r14 r15 eax
..B2.2:                         # Preds ..B2.1
                                # Execution count [1.00e+00]
..LN126:
        testl     %eax, %eax                                    #58.9
..LN127:
        jne       ..B2.4        # Prob 0%                       #58.9
..LN128:
                                # LOE rbx rbp r12 r13 r14 r15
..B2.3:                         # Preds ..B2.2
                                # Execution count [9.95e-01]
..LN129:
	.loc    1  61  is_stmt 1

###         exit(-1); // return 0;
###     }
###     return (double)time.tv_sec + (double)time.tv_usec * .000001;

        vxorpd    %xmm0, %xmm0, %xmm0                           #61.42
..LN130:
        vxorpd    %xmm1, %xmm1, %xmm1                           #61.20
..LN131:
        vcvtsi2sdq 8(%rsp), %xmm0, %xmm0                        #61.42
..LN132:
        vcvtsi2sdq (%rsp), %xmm1, %xmm1                         #61.20
..LN133:
        vfmadd132sd .L_2il0floatpacket.5(%rip), %xmm1, %xmm0    #61.57
..LN134:
	.loc    1  61  epilogue_begin  is_stmt 1
        addq      $24, %rsp                                     #61.57
	.cfi_def_cfa_offset 8
..LN135:
        ret                                                     #61.57
	.cfi_def_cfa_offset 32
..LN136:
                                # LOE
..B2.4:                         # Preds ..B2.2
                                # Execution count [5.00e-03]: Infreq
..LN137:
	.loc    1  59  is_stmt 1
        movl      $-1, %edi                                     #59.9
..LN138:
#       exit(int)
        call      exit                                          #59.9
        .align    16,0x90
..LN139:
                                # LOE
..LN140:
	.cfi_endproc
# mark_end;
	.type	get_wall_time,@function
	.size	get_wall_time,.-get_wall_time
..LNget_wall_time.141:
.LNget_wall_time:
	.data
	.file   2 "/usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h"
	.file   3 "/usr/include/x86_64-linux-gnu/bits/types.h"
# -- End  get_wall_time
	.text
.L_2__routine_start_check_2:
# -- Begin  check
	.text
# mark_begin;
       .align    16,0x90
	.globl check
# --- check(float *)
check:
# parameter 1(arr): %rdi
..B3.1:                         # Preds ..B3.0
                                # Execution count [1.00e+00]

### {

	.cfi_startproc
..___tag_value_check.59:
..L60:
                                                         #71.1
..LN142:
	.loc    1  71  is_stmt 1
        pushq     %rsi                                          #71.1
	.cfi_def_cfa_offset 16
..LN143:
	.loc    1  76  prologue_end  is_stmt 1

###   real sum = 0;
### #ifdef __INTEL_COMPILER
###   #pragma novector
### #endif
###   for (unsigned int i = 0; i < LEN; i++)

        xorl      %edx, %edx                                    #76.23
..LN144:
	.loc    1  72  is_stmt 1
        vxorps    %xmm0, %xmm0, %xmm0                           #72.12
..LN145:
	.loc    1  76  is_stmt 1
        xorl      %eax, %eax                                    #76.37
..LN146:
                                # LOE rdx rbx rbp rdi r12 r13 r14 r15 eax xmm0
..B3.2:                         # Preds ..B3.2 ..B3.1
                                # Execution count [1.02e+03]
..L63:
                # optimization report
                # %s was not vectorized: novector directive used
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN147:
..LN148:
        incl      %eax                                          #76.37
..LN149:
	.loc    1  77  is_stmt 1

###     sum += arr[i];

        vaddss    (%rdi,%rdx,4), %xmm0, %xmm0                   #77.5
..LN150:
	.loc    1  76  is_stmt 1
        movl      %eax, %edx                                    #76.37
..LN151:
        cmpl      $1024, %eax                                   #76.32
..LN152:
        jb        ..B3.2        # Prob 99%                      #76.32
..LN153:
                                # LOE rdx rbx rbp rdi r12 r13 r14 r15 eax xmm0
..B3.3:                         # Preds ..B3.2
                                # Execution count [1.00e+00]
..LN154:
	.loc    1  79  is_stmt 1

### 
###   printf("%f \n", sum);

        vcvtss2sd %xmm0, %xmm0, %xmm0                           #79.3
..LN155:
        movl      $.L_2__STRING.0, %edi                         #79.3
..LN156:
        movl      $1, %eax                                      #79.3
..___tag_value_check.64:
..LN157:
#       printf(const char *__restrict__, ...)
        call      printf                                        #79.3
..___tag_value_check.65:
..LN158:
                                # LOE rbx rbp r12 r13 r14 r15
..B3.4:                         # Preds ..B3.3
                                # Execution count [1.00e+00]

### }

..LN159:
	.loc    1  80  epilogue_begin  is_stmt 1
        popq      %rcx                                          #80.1
	.cfi_def_cfa_offset 8
..LN160:
        ret                                                     #80.1
        .align    16,0x90
..LN161:
                                # LOE
..LN162:
	.cfi_endproc
# mark_end;
	.type	check,@function
	.size	check,.-check
..LNcheck.163:
.LNcheck:
	.data
# -- End  check
	.text
.L_2__routine_start_results_3:
# -- Begin  results
	.text
# mark_begin;
       .align    16,0x90
	.globl results
# --- results(const double, const char *)
results:
# parameter 1(wall_time): %xmm0
# parameter 2(loop): %rdi
..B4.1:                         # Preds ..B4.0
                                # Execution count [1.00e+00]

### {

	.cfi_startproc
..___tag_value_results.71:
..L72:
                                                         #97.1
..LN164:
	.loc    1  97  is_stmt 1
        movq      %rdi, %rsi                                    #97.1
..LN165:
	.loc    1  98  prologue_end  is_stmt 1

###     printf("%18s  %6.1f    %6.1f     ",

        vdivsd    .L_2il0floatpacket.6(%rip), %xmm0, %xmm2      #98.5
..LN166:
        vdivsd    .L_2il0floatpacket.7(%rip), %xmm0, %xmm1      #98.5
..LN167:
        movl      $.L_2__STRING.1, %edi                         #98.5
..LN168:
        movl      $2, %eax                                      #98.5
..LN169:
        vmovapd   %xmm2, %xmm0                                  #98.5
..LN170:
	.loc    1  98  epilogue_begin  is_stmt 1
#       printf(const char *__restrict__, ...)
        jmp       printf                                        #98.5
        .align    16,0x90
..LN171:
                                # LOE
..LN172:
	.cfi_endproc
# mark_end;
	.type	results,@function
	.size	results,.-results
..LNresults.173:
.LNresults:
	.data
# -- End  results
	.text
.L_2__routine_start_ss_stride_esc_4:
# -- Begin  ss_stride_esc
	.text
# mark_begin;
       .align    16,0x90
	.globl ss_stride_esc
# --- ss_stride_esc()
ss_stride_esc:
..B5.1:                         # Preds ..B5.0
                                # Execution count [1.00e+00]

### {

	.cfi_startproc
..___tag_value_ss_stride_esc.79:
..L80:
                                                         #109.1
..LN174:
	.loc    1  109  is_stmt 1
        subq      $24, %rsp                                     #109.1
	.cfi_def_cfa_offset 32

###   double start_t, end_t;
### 
###   init();

..___tag_value_ss_stride_esc.83:
..LN175:
	.loc    1  112  prologue_end  is_stmt 1
#       init()
        call      init                                          #112.3
..___tag_value_ss_stride_esc.84:
..LN176:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.2:                         # Preds ..B5.1
                                # Execution count [1.00e+00]

###   start_t = get_wall_time();

..___tag_value_ss_stride_esc.85:
..LN177:
	.loc    1  113  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #113.13
..___tag_value_ss_stride_esc.86:
..LN178:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B5.14:                        # Preds ..B5.2
                                # Execution count [1.00e+00]
..LN179:
        vmovsd    %xmm0, (%rsp)                                 #113.13[spill]
..LN180:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.3:                         # Preds ..B5.14
                                # Execution count [9.00e-01]
..LN181:
	.loc    1  114  is_stmt 1

###   for (unsigned int nl = 0; nl < NTIMES; nl++)

        xorl      %eax, %eax                                    #114.3

###  {
### #ifdef __INTEL_COMPILER
###   #pragma novector
### #endif
###     for (unsigned int i = 0; i < 2*LEN; i+=2)
###     {
###       x[i] = alpha*x[i] + beta;

..LN182:
	.loc    1  121  is_stmt 1
        movq      %r12, 8(%rsp)                                 #121.14[spill]
	.cfi_offset 12, -24
..LN183:
        movl      %eax, %r12d                                   #121.14
..LN184:
                                # LOE rbx rbp r13 r14 r15 r12d
..B5.4:                         # Preds ..B5.7 ..B5.3
                                # Execution count [5.00e+00]
..L90:
                # optimization report
                # LOOP WITH UNSIGNED INDUCTION VARIABLE
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
                # COST MODEL DECISION WAS IGNORED
..LN185:
	.loc    1  114  is_stmt 1
..LN186:
	.loc    1  119  is_stmt 1
        vmovss    .L_2il0floatpacket.1(%rip), %xmm1             #119.5
..LN187:
        xorl      %edx, %edx                                    #119.5
..LN188:
        vmovss    .L_2il0floatpacket.0(%rip), %xmm2             #119.5
..LN189:
                                # LOE rbx rbp r13 r14 r15 edx r12d xmm1 xmm2
..B5.5:                         # Preds ..B5.5 ..B5.4
                                # Execution count [5.12e+03]
..L91:
                # optimization report
                # %s was not vectorized: novector directive used
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN190:
	.loc    1  121  is_stmt 1
        lea       (%rdx,%rdx), %ecx                             #121.20
..LN191:
	.loc    1  119  is_stmt 1
        incl      %edx                                          #119.5
..LN192:
	.loc    1  121  is_stmt 1
        vmovss    x(,%rcx,4), %xmm0                             #121.20
..LN193:
        vfmadd213ss %xmm2, %xmm1, %xmm0                         #121.7
..LN194:
        vmovss    %xmm0, x(,%rcx,4)                             #121.7
..LN195:
	.loc    1  119  is_stmt 1
        cmpl      $1024, %edx                                   #119.5
..LN196:
        jb        ..B5.5        # Prob 99%                      #119.5
..LN197:
                                # LOE rbx rbp r13 r14 r15 edx r12d xmm1 xmm2
..B5.6:                         # Preds ..B5.5
                                # Execution count [5.00e+00]
..LN198:
	.loc    1  123  is_stmt 1

###     }
###     dummy(x, alpha, beta);

        vmovss    .L_2il0floatpacket.1(%rip), %xmm0             #123.5
..LN199:
        movl      $x, %edi                                      #123.5
..LN200:
        vmovss    .L_2il0floatpacket.0(%rip), %xmm1             #123.5
..___tag_value_ss_stride_esc.92:
..LN201:
#       dummy(float *, float, float)
        call      dummy                                         #123.5
..___tag_value_ss_stride_esc.93:
..LN202:
                                # LOE rbx rbp r13 r14 r15 r12d
..B5.7:                         # Preds ..B5.6
                                # Execution count [5.00e+00]
..LN203:
	.loc    1  114  is_stmt 1
        incl      %r12d                                         #114.3
..LN204:
        cmpl      $15728640, %r12d                              #114.3
..LN205:
        jb        ..B5.4        # Prob 82%                      #114.3
..LN206:
                                # LOE rbx rbp r13 r14 r15 r12d
..B5.8:                         # Preds ..B5.7
                                # Execution count [1.00e+00]
..LN207:
        movq      8(%rsp), %r12                                 #[spill]
	.cfi_restore 12

###   }
###   end_t = get_wall_time();

..___tag_value_ss_stride_esc.95:
..LN208:
	.loc    1  125  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #125.11
..___tag_value_ss_stride_esc.96:
	.cfi_offset 12, -24
..LN209:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B5.9:                         # Preds ..B5.8
                                # Execution count [1.00e+00]
..LN210:
	.loc    1  126  is_stmt 1

###   results(end_t - start_t, "ss_stride_esc");

        movl      $.L_2__STRING.2, %edi                         #126.3
..LN211:
        vsubsd    (%rsp), %xmm0, %xmm0                          #126.3[spill]
..___tag_value_ss_stride_esc.98:
..LN212:
#       results(const double, const char *)
        call      results                                       #126.3
..___tag_value_ss_stride_esc.99:
..LN213:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.10:                        # Preds ..B5.9
                                # Execution count [1.00e+00]
..LN214:
	.loc    1  127  is_stmt 1

###   check(x);

        movl      $x, %edi                                      #127.3
..___tag_value_ss_stride_esc.101:
..LN215:
#       check(float *)
        call      check                                         #127.3
..___tag_value_ss_stride_esc.102:
..LN216:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.11:                        # Preds ..B5.10
                                # Execution count [1.00e+00]
..LN217:
	.loc    1  128  is_stmt 1

###   return 0;

        xorl      %eax, %eax                                    #128.10
..LN218:
	.loc    1  128  epilogue_begin  is_stmt 1
        addq      $24, %rsp                                     #128.10
	.cfi_def_cfa_offset 8
..LN219:
        ret                                                     #128.10
        .align    16,0x90
..LN220:
                                # LOE
..LN221:
	.cfi_endproc
# mark_end;
	.type	ss_stride_esc,@function
	.size	ss_stride_esc,.-ss_stride_esc
..LNss_stride_esc.222:
.LNss_stride_esc:
	.data
# -- End  ss_stride_esc
	.text
.L_2__routine_start_ss_stride_vec_5:
# -- Begin  ss_stride_vec
	.text
# mark_begin;
       .align    16,0x90
	.globl ss_stride_vec
# --- ss_stride_vec()
ss_stride_vec:
..B6.1:                         # Preds ..B6.0
                                # Execution count [1.00e+00]

### {

	.cfi_startproc
..___tag_value_ss_stride_vec.108:
..L109:
                                                        #132.1
..LN223:
	.loc    1  132  is_stmt 1
        pushq     %rbp                                          #132.1
	.cfi_def_cfa_offset 16
..LN224:
        movq      %rsp, %rbp                                    #132.1
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
..LN225:
        andq      $-32, %rsp                                    #132.1
..LN226:
        subq      $32, %rsp                                     #132.1

###   double start_t, end_t;
### 
###   init();

..___tag_value_ss_stride_vec.114:
..LN227:
	.loc    1  135  prologue_end  is_stmt 1
#       init()
        call      init                                          #135.3
..___tag_value_ss_stride_vec.115:
..LN228:
                                # LOE rbx r12 r13 r14 r15
..B6.2:                         # Preds ..B6.1
                                # Execution count [1.00e+00]

###   start_t = get_wall_time();

..___tag_value_ss_stride_vec.116:
..LN229:
	.loc    1  136  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #136.13
..___tag_value_ss_stride_vec.117:
..LN230:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B6.14:                        # Preds ..B6.2
                                # Execution count [1.00e+00]
..LN231:
        vmovsd    %xmm0, (%rsp)                                 #136.13[spill]
..LN232:
                                # LOE rbx r12 r13 r14 r15
..B6.3:                         # Preds ..B6.14
                                # Execution count [9.00e-01]
..LN233:
	.loc    1  137  is_stmt 1

###   for (unsigned int nl = 0; nl < NTIMES; nl++)

        xorl      %eax, %eax                                    #137.3
..LN234:
	.loc    1  141  is_stmt 1

###   {
###     for (unsigned int i = 0; i < 2*LEN; i+=2)
###     {
###         x[i] = alpha*x[i] + beta;

        vmovups   .L_2il0floatpacket.2(%rip), %ymm3             #141.29
..LN235:
        movq      %r12, 8(%rsp)                                 #141.22[spill]
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
..LN236:
        movl      %eax, %r12d                                   #141.22
..LN237:
                                # LOE rbx r13 r14 r15 r12d
..B6.4:                         # Preds ..B6.7 ..B6.3
                                # Execution count [5.00e+00]
..L121:
                # optimization report
                # LOOP WITH UNSIGNED INDUCTION VARIABLE
                # %s was not vectorized: inner loop was already vectorized
..LN238:
	.loc    1  137  is_stmt 1
..LN239:
	.loc    1  139  is_stmt 1
        vmovups   .L_2il0floatpacket.4(%rip), %ymm4             #139.5
..LN240:
        xorl      %edx, %edx                                    #139.5
..LN241:
        vmovups   .L_2il0floatpacket.3(%rip), %ymm5             #139.5
..LN242:
        vmovups   .L_2il0floatpacket.2(%rip), %ymm6             #139.5
..LN243:
        vpcmpeqd  %ymm3, %ymm3, %ymm3                           #139.5
..LN244:
                                # LOE rbx r13 r14 r15 edx r12d ymm3 ymm4 ymm5 ymm6
..B6.5:                         # Preds ..B6.5 ..B6.4
                                # Execution count [5.12e+03]
..L122:
                # optimization report
                # LOOP WAS VECTORIZED
                # VECTORIZATION SPEEDUP COEFFECIENT 1.524414
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
                # VECTOR LENGTH 8
                # MAIN VECTOR TYPE: 32-bits floating point
                # COST MODEL DECISION WAS IGNORED
..LN245:
	.loc    1  141  is_stmt 1
        vmovdqa   %ymm3, %ymm0                                  #141.22
..LN246:
        lea       (%rdx,%rdx), %ecx                             #141.22
..LN247:
        vxorps    %ymm1, %ymm1, %ymm1                           #141.22
..LN248:
        lea       (,%rcx,4), %rsi                               #141.22
..LN249:
        vgatherdps %ymm0, x(%rsi,%ymm4,8), %ymm1                #141.22
..LN250:
	.loc    1  139  is_stmt 1
        addl      $8, %edx                                      #139.5
..LN251:
	.loc    1  141  is_stmt 1
        vfmadd213ps %ymm6, %ymm5, %ymm1                         #141.29
..LN252:
	.loc    1  139  is_stmt 1
        cmpl      $1024, %edx                                   #139.5
..LN253:
	.loc    1  141  is_stmt 1
        vextractf128 $1, %ymm1, %xmm2                           #141.9
..LN254:
        vmovss    %xmm1, x(,%rcx,4)                             #141.9
..LN255:
        vmovss    %xmm2, 32+x(,%rcx,4)                          #141.9
..LN256:
        vextractps $1, %xmm1, 8+x(,%rcx,4)                      #141.9
..LN257:
        vextractps $2, %xmm1, 16+x(,%rcx,4)                     #141.9
..LN258:
        vextractps $3, %xmm1, 24+x(,%rcx,4)                     #141.9
..LN259:
        vextractps $1, %xmm2, 40+x(,%rcx,4)                     #141.9
..LN260:
        vextractps $2, %xmm2, 48+x(,%rcx,4)                     #141.9
..LN261:
        vextractps $3, %xmm2, 56+x(,%rcx,4)                     #141.9
..LN262:
	.loc    1  139  is_stmt 1
        jb        ..B6.5        # Prob 99%                      #139.5
..LN263:
                                # LOE rbx r13 r14 r15 edx r12d ymm3 ymm4 ymm5 ymm6
..B6.6:                         # Preds ..B6.5
                                # Execution count [5.00e+00]
..LN264:
	.loc    1  143  is_stmt 1

###     }
###     dummy(x, alpha, beta);

        vzeroupper                                              #143.5
..LN265:
        movl      $x, %edi                                      #143.5
..LN266:
        vmovss    .L_2il0floatpacket.1(%rip), %xmm0             #143.5
..LN267:
        vmovss    .L_2il0floatpacket.0(%rip), %xmm1             #143.5
..___tag_value_ss_stride_vec.123:
..LN268:
#       dummy(float *, float, float)
        call      dummy                                         #143.5
..___tag_value_ss_stride_vec.124:
..LN269:
                                # LOE rbx r13 r14 r15 r12d
..B6.7:                         # Preds ..B6.6
                                # Execution count [5.00e+00]
..LN270:
	.loc    1  137  is_stmt 1
        incl      %r12d                                         #137.3
..LN271:
        cmpl      $15728640, %r12d                              #137.3
..LN272:
        jb        ..B6.4        # Prob 82%                      #137.3
..LN273:
                                # LOE rbx r13 r14 r15 r12d
..B6.8:                         # Preds ..B6.7
                                # Execution count [1.00e+00]
..LN274:
        movq      8(%rsp), %r12                                 #[spill]
	.cfi_restore 12

###   }
###   end_t = get_wall_time();

..___tag_value_ss_stride_vec.126:
..LN275:
	.loc    1  145  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #145.11
..___tag_value_ss_stride_vec.127:
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
..LN276:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B6.9:                         # Preds ..B6.8
                                # Execution count [1.00e+00]
..LN277:
	.loc    1  146  is_stmt 1

###   results(end_t - start_t, "ss_stride_vec");

        movl      $.L_2__STRING.3, %edi                         #146.3
..LN278:
        vsubsd    (%rsp), %xmm0, %xmm0                          #146.3[spill]
..___tag_value_ss_stride_vec.129:
..LN279:
#       results(const double, const char *)
        call      results                                       #146.3
..___tag_value_ss_stride_vec.130:
..LN280:
                                # LOE rbx r12 r13 r14 r15
..B6.10:                        # Preds ..B6.9
                                # Execution count [1.00e+00]
..LN281:
	.loc    1  147  is_stmt 1

###   check(x);

        movl      $x, %edi                                      #147.3
..___tag_value_ss_stride_vec.132:
..LN282:
#       check(float *)
        call      check                                         #147.3
..___tag_value_ss_stride_vec.133:
..LN283:
                                # LOE rbx r12 r13 r14 r15
..B6.11:                        # Preds ..B6.10
                                # Execution count [1.00e+00]
..LN284:
	.loc    1  148  is_stmt 1

###   return 0;

        xorl      %eax, %eax                                    #148.10
..LN285:
	.loc    1  148  epilogue_begin  is_stmt 1
        movq      %rbp, %rsp                                    #148.10
..LN286:
        popq      %rbp                                          #148.10
	.cfi_def_cfa 7, 8
	.cfi_restore 6
..LN287:
        ret                                                     #148.10
        .align    16,0x90
..LN288:
                                # LOE
..LN289:
	.cfi_endproc
# mark_end;
	.type	ss_stride_vec,@function
	.size	ss_stride_vec,.-ss_stride_vec
..LNss_stride_vec.290:
.LNss_stride_vec:
	.data
# -- End  ss_stride_vec
	.text
.L_2__routine_start_init_6:
# -- Begin  init
	.text
# mark_begin;
       .align    16,0x90
	.globl init
# --- init()
init:
..B7.1:                         # Preds ..B7.0
                                # Execution count [1.00e+00]

### {

	.cfi_startproc
..___tag_value_init.140:
..L141:
                                                        #87.1
..LN291:
	.loc    1  87  prologue_end  is_stmt 1
..LN292:
	.loc    1  88  is_stmt 1

###   for (int j = 0; j < LEN; j++)

        xorl      %eax, %eax                                    #88.3
..LN293:
	.loc    1  90  is_stmt 1

###   {
###     x[j] = 1.0;

        vmovups   .L_2il0floatpacket.8(%rip), %ymm0             #90.12
..LN294:
                                # LOE rax rbx rbp r12 r13 r14 r15 ymm0
..B7.2:                         # Preds ..B7.2 ..B7.1
                                # Execution count [1.02e+03]
..L143:
                # optimization report
                # LOOP WAS VECTORIZED
                # VECTORIZATION SPEEDUP COEFFECIENT 8.000000
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
                # VECTOR LENGTH 8
                # MAIN VECTOR TYPE: 32-bits floating point
                # COST MODEL DECISION WAS IGNORED
..LN295:
	.loc    1  88  is_stmt 1
..LN296:
	.loc    1  90  is_stmt 1
        vmovups   %ymm0, x(,%rax,4)                             #90.5
..LN297:
	.loc    1  88  is_stmt 1
        addq      $8, %rax                                      #88.3
..LN298:
        cmpq      $1024, %rax                                   #88.3
..LN299:
        jb        ..B7.2        # Prob 99%                      #88.3
..LN300:
                                # LOE rax rbx rbp r12 r13 r14 r15 ymm0
..B7.3:                         # Preds ..B7.2
                                # Execution count [1.00e+00]
..LN301:
	.loc    1  92  is_stmt 1

###   }
###   return 0;

        vzeroupper                                              #92.10
..LN302:
        xorl      %eax, %eax                                    #92.10
..LN303:
	.loc    1  92  epilogue_begin  is_stmt 1
        ret                                                     #92.10
        .align    16,0x90
..LN304:
                                # LOE
..LN305:
	.cfi_endproc
# mark_end;
	.type	init,@function
	.size	init,.-init
..LNinit.306:
.LNinit:
	.data
# -- End  init
	.bss
	.align 64
	.align 64
x:
	.type	x,@object
	.size	x,8192
	.space 8192	# pad
	.section .rodata, "a"
	.align 32
	.align 32
.L_2il0floatpacket.2:
	.long	0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000
	.type	.L_2il0floatpacket.2,@object
	.size	.L_2il0floatpacket.2,32
	.align 32
.L_2il0floatpacket.3:
	.long	0x3f666666,0x3f666666,0x3f666666,0x3f666666,0x3f666666,0x3f666666,0x3f666666,0x3f666666
	.type	.L_2il0floatpacket.3,@object
	.size	.L_2il0floatpacket.3,32
	.align 32
.L_2il0floatpacket.4:
	.long	0x00000000,0x00000001,0x00000002,0x00000003,0x00000004,0x00000005,0x00000006,0x00000007
	.type	.L_2il0floatpacket.4,@object
	.size	.L_2il0floatpacket.4,32
	.align 32
.L_2il0floatpacket.8:
	.long	0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000
	.type	.L_2il0floatpacket.8,@object
	.size	.L_2il0floatpacket.8,32
	.align 8
.L_2il0floatpacket.5:
	.long	0xa0b5ed8d,0x3eb0c6f7
	.type	.L_2il0floatpacket.5,@object
	.size	.L_2il0floatpacket.5,8
	.align 8
.L_2il0floatpacket.6:
	.long	0x29a4692c,0x3f901b2b
	.type	.L_2il0floatpacket.6,@object
	.size	.L_2il0floatpacket.6,8
	.align 8
.L_2il0floatpacket.7:
	.long	0xe91b0b70,0x3f907e1f
	.type	.L_2il0floatpacket.7,@object
	.size	.L_2il0floatpacket.7,8
	.align 4
.L_2il0floatpacket.0:
	.long	0x3f000000
	.type	.L_2il0floatpacket.0,@object
	.size	.L_2il0floatpacket.0,4
	.align 4
.L_2il0floatpacket.1:
	.long	0x3f666666
	.type	.L_2il0floatpacket.1,@object
	.size	.L_2il0floatpacket.1,4
	.section .rodata.str1.4, "aMS",@progbits,1
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.2:
	.long	1935635315
	.long	1684632180
	.long	1936023397
	.word	99
	.type	.L_2__STRING.2,@object
	.size	.L_2__STRING.2,14
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.3:
	.long	1935635315
	.long	1684632180
	.long	1702256485
	.word	99
	.type	.L_2__STRING.3,@object
	.size	.L_2__STRING.3,14
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.0:
	.long	169895461
	.byte	0
	.type	.L_2__STRING.0,@object
	.size	.L_2__STRING.0,5
	.space 3, 0x00 	# pad
	.align 4
.L_2__STRING.1:
	.long	1933062437
	.long	908402720
	.long	543568174
	.long	622862368
	.long	1714499126
	.long	538976288
	.word	32
	.type	.L_2__STRING.1,@object
	.size	.L_2__STRING.1,26
	.data
	.section .debug_opt_report, ""
..L147:
	.ascii ".itt_notify_tab\0"
	.word	258
	.word	48
	.long	11
	.long	..L148 - ..L147
	.long	48
	.long	..L149 - ..L147
	.long	179
	.long	0x00000008,0x00000000
	.long	0
	.long	0
	.long	0
	.long	1
	.quad	..L14
	.long	28
	.long	5
	.quad	..L15
	.long	28
	.long	24
	.quad	..L30
	.long	28
	.long	41
	.quad	..L31
	.long	28
	.long	55
	.quad	..L63
	.long	28
	.long	74
	.quad	..L90
	.long	28
	.long	91
	.quad	..L91
	.long	28
	.long	110
	.quad	..L121
	.long	28
	.long	127
	.quad	..L122
	.long	28
	.long	141
	.quad	..L143
	.long	28
	.long	160
..L148:
	.long	1769238639
	.long	1635412333
	.long	1852795252
	.long	1885696607
	.long	1601466991
	.long	1936876918
	.long	7237481
	.long	1769238639
	.long	1635412333
	.long	1852795252
	.long	1885696607
	.long	7631471
..L149:
	.long	-2079325440
	.long	-2146430462
	.long	-2139062144
	.long	-1870626688
	.long	-2138984320
	.long	276857216
	.long	-2139090928
	.long	-2139062144
	.long	-2139062144
	.long	-2139062068
	.long	-2146431743
	.long	-2139062144
	.long	-1870626688
	.long	302499968
	.long	-2139062256
	.long	-2139062144
	.long	-2138931072
	.long	-2021137976
	.long	269488768
	.long	-2139062144
	.long	-2139062144
	.long	-2134081408
	.long	302088320
	.long	-2139062256
	.long	-2139062144
	.long	-1333751680
	.long	-2122284927
	.long	269488256
	.long	-2139062144
	.long	-2139062144
	.long	-2134081408
	.long	218202240
	.long	-2139062256
	.long	-2139062144
	.long	-931098496
	.long	-2146430457
	.long	-2139062144
	.long	-2139062144
	.long	-506953598
	.long	310413191
	.long	-2139090926
	.long	-2139062144
	.long	-2105507712
	.long	-1988067200
	.word	32903
	.byte	18
	.section .note.GNU-stack, ""
// -- Begin DWARF2 SEGMENT .debug_info
	.section .debug_info
.debug_info_seg:
	.align 1
	.4byte 0x00000346
	.2byte 0x0004
	.4byte .debug_abbrev_seg
	.byte 0x08
//	DW_TAG_compile_unit:
	.byte 0x01
//	DW_AT_comp_dir:
	.4byte .debug_str
//	DW_AT_name:
	.4byte .debug_str+0x6e
//	DW_AT_producer:
	.4byte .debug_str+0x7d
	.4byte .debug_str+0xe9
//	DW_AT_language:
	.byte 0x01
//	DW_AT_use_UTF8:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte 0x0000000000000000
//	DW_AT_ranges:
	.4byte .debug_ranges_seg+0x60
	.byte 0x01
//	DW_AT_stmt_list:
	.4byte .debug_line_seg
//	DW_TAG_base_type:
	.byte 0x02
//	DW_AT_byte_size:
	.byte 0x04
//	DW_AT_encoding:
	.byte 0x05
//	DW_AT_name:
	.4byte 0x00746e69
//	DW_TAG_subprogram:
	.byte 0x03
//	DW_AT_decl_line:
	.byte 0xaf
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000002f
//	DW_AT_name:
	.4byte .debug_str+0x17e
	.4byte .debug_str+0x17e
//	DW_AT_low_pc:
	.8byte ..L3
//	DW_AT_high_pc:
	.8byte ..LNmain.120-..L3
	.byte 0x01
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_inlined_subroutine:
	.byte 0x04
//	DW_AT_ranges:
	.4byte .debug_ranges_seg
//	DW_AT_entry_pc:
	.8byte ..LN57
//	DW_AT_abstract_origin:
	.4byte 0x000000ae
//	DW_AT_call_line:
	.byte 0xb4
//	DW_AT_call_column:
	.byte 0x03
//	DW_AT_call_file:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x85
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x191
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x85
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x1a0
//	DW_AT_type:
	.4byte 0x000000c0
	.byte 0x00
//	DW_TAG_inlined_subroutine:
	.byte 0x04
//	DW_AT_ranges:
	.4byte .debug_ranges_seg+0x30
//	DW_AT_entry_pc:
	.8byte ..LN18
//	DW_AT_abstract_origin:
	.4byte 0x000000c7
//	DW_AT_call_line:
	.byte 0xb3
//	DW_AT_call_column:
	.byte 0x03
//	DW_AT_call_file:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x6e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x191
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x6e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x1a0
//	DW_AT_type:
	.4byte 0x000000c0
	.byte 0x00
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x83
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_declaration:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000002f
//	DW_AT_name:
	.4byte .debug_str+0x183
	.4byte .debug_str+0x183
//	DW_AT_external:
	.byte 0x01
//	DW_AT_inline:
	.byte 0x01
//	DW_TAG_base_type:
	.byte 0x07
//	DW_AT_byte_size:
	.byte 0x08
//	DW_AT_encoding:
	.byte 0x04
//	DW_AT_name:
	.4byte .debug_str+0x199
//	DW_TAG_subprogram:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x6c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_declaration:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000002f
//	DW_AT_name:
	.4byte .debug_str+0x1a6
	.4byte .debug_str+0x1a6
//	DW_AT_external:
	.byte 0x01
//	DW_AT_inline:
	.byte 0x01
//	DW_TAG_subprogram:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0x37
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_AT_name:
	.4byte .debug_str+0x1b4
	.4byte .debug_str+0x1b4
//	DW_AT_frame_base:
	.2byte 0x7702
	.byte 0x00
//	DW_AT_low_pc:
	.8byte ..L50
//	DW_AT_high_pc:
	.8byte ..LNget_wall_time.141-..L50
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x39
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x1bd
//	DW_AT_type:
	.4byte 0x0000010b
//	DW_AT_location:
	.2byte 0x9102
	.byte 0x00
	.byte 0x00
//	DW_TAG_structure_type:
	.byte 0x0a
//	DW_AT_decl_line:
	.byte 0x08
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_byte_size:
	.byte 0x10
//	DW_AT_name:
	.4byte .debug_str+0x1c2
//	DW_TAG_member:
	.byte 0x0b
//	DW_AT_decl_line:
	.byte 0x0a
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x1ca
//	DW_AT_type:
	.4byte 0x00000130
//	DW_TAG_member:
	.byte 0x0b
//	DW_AT_decl_line:
	.byte 0x0b
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x08
//	DW_AT_name:
	.4byte .debug_str+0x1df
//	DW_AT_type:
	.4byte 0x00000142
	.byte 0x00
//	DW_TAG_typedef:
	.byte 0x0c
//	DW_AT_decl_line:
	.byte 0x94
//	DW_AT_decl_file:
	.byte 0x03
//	DW_AT_name:
	.4byte .debug_str+0x1d1
//	DW_AT_type:
	.4byte 0x0000013b
//	DW_TAG_base_type:
	.byte 0x07
//	DW_AT_byte_size:
	.byte 0x08
//	DW_AT_encoding:
	.byte 0x05
//	DW_AT_name:
	.4byte .debug_str+0x1da
//	DW_TAG_typedef:
	.byte 0x0c
//	DW_AT_decl_line:
	.byte 0x96
//	DW_AT_decl_file:
	.byte 0x03
//	DW_AT_name:
	.4byte .debug_str+0x1e7
//	DW_AT_type:
	.4byte 0x0000013b
//	DW_TAG_subprogram:
	.byte 0x0d
//	DW_AT_decl_line:
	.byte 0x46
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x1f5
	.4byte .debug_str+0x1f5
//	DW_AT_low_pc:
	.8byte ..L60
//	DW_AT_high_pc:
	.8byte ..LNcheck.163-..L60
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x0e
//	DW_AT_decl_line:
	.byte 0x46
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x000001a0
//	DW_AT_name:
	.4byte 0x00727261
//	DW_AT_location:
	.2byte 0x5501
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x48
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x006d7573
//	DW_AT_type:
	.4byte 0x000001a5
//	DW_TAG_lexical_block:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x4c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN143
//	DW_AT_high_pc:
	.8byte ..LN159
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x4c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0069
//	DW_AT_type:
	.4byte 0x000001ac
	.byte 0x00
	.byte 0x00
//	DW_TAG_pointer_type:
	.byte 0x11
//	DW_AT_type:
	.4byte 0x000001a5
//	DW_TAG_base_type:
	.byte 0x07
//	DW_AT_byte_size:
	.byte 0x04
//	DW_AT_encoding:
	.byte 0x04
//	DW_AT_name:
	.4byte .debug_str+0x1fb
//	DW_TAG_base_type:
	.byte 0x07
//	DW_AT_byte_size:
	.byte 0x04
//	DW_AT_encoding:
	.byte 0x07
//	DW_AT_name:
	.4byte .debug_str+0x201
//	DW_TAG_subprogram:
	.byte 0x0d
//	DW_AT_decl_line:
	.byte 0x60
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x20e
	.4byte .debug_str+0x20e
//	DW_AT_low_pc:
	.8byte ..L72
//	DW_AT_high_pc:
	.8byte ..LNresults.173-..L72
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0x60
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x000001eb
//	DW_AT_name:
	.4byte .debug_str+0x1b8
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_formal_parameter:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0x60
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x000001f0
//	DW_AT_name:
	.4byte .debug_str+0x21b
//	DW_AT_location:
	.2byte 0x5501
	.byte 0x00
//	DW_TAG_const_type:
	.byte 0x13
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_pointer_type:
	.byte 0x11
//	DW_AT_type:
	.4byte 0x000001f5
//	DW_TAG_const_type:
	.byte 0x13
//	DW_AT_type:
	.4byte 0x000001fa
//	DW_TAG_base_type:
	.byte 0x07
//	DW_AT_byte_size:
	.byte 0x01
//	DW_AT_encoding:
	.byte 0x06
//	DW_AT_name:
	.4byte .debug_str+0x216
//	DW_TAG_subprogram:
	.byte 0x14
//	DW_AT_decl_line:
	.byte 0x6c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_abstract_origin:
	.4byte 0x000000c7
//	DW_AT_low_pc:
	.8byte ..L80
//	DW_AT_high_pc:
	.8byte ..LNss_stride_esc.222-..L80
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x6e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x191
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x6e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x1a0
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_lexical_block:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x72
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN182
//	DW_AT_high_pc:
	.8byte ..LN203
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x72
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x6c6e
	.byte 0x00
//	DW_AT_type:
	.4byte 0x000001ac
//	DW_TAG_lexical_block:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x77
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN182
//	DW_AT_high_pc:
	.8byte ..LN203
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x77
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0069
//	DW_AT_type:
	.4byte 0x000001ac
	.byte 0x00
	.byte 0x00
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x14
//	DW_AT_decl_line:
	.byte 0x83
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_abstract_origin:
	.4byte 0x000000ae
//	DW_AT_low_pc:
	.8byte ..L109
//	DW_AT_high_pc:
	.8byte ..LNss_stride_vec.290-..L109
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x85
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x191
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x85
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x1a0
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_lexical_block:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x89
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN234
//	DW_AT_high_pc:
	.8byte ..LN270
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x89
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x6c6e
	.byte 0x00
//	DW_AT_type:
	.4byte 0x000001ac
//	DW_TAG_lexical_block:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x8b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN234
//	DW_AT_high_pc:
	.8byte ..LN270
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x8b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0069
//	DW_AT_type:
	.4byte 0x000001ac
	.byte 0x00
	.byte 0x00
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x15
//	DW_AT_decl_line:
	.byte 0x56
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000002f
//	DW_AT_name:
	.4byte .debug_str+0x220
	.4byte .debug_str+0x220
//	DW_AT_low_pc:
	.8byte ..L141
//	DW_AT_high_pc:
	.8byte ..LNinit.306-..L141
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_lexical_block:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x58
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN293
//	DW_AT_high_pc:
	.8byte ..LN297
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x58
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x006a
//	DW_AT_type:
	.4byte 0x0000002f
	.byte 0x00
	.byte 0x00
//	DW_TAG_variable:
	.byte 0x16
//	DW_AT_decl_line:
	.byte 0x2b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0078
//	DW_AT_type:
	.4byte 0x00000324
//	DW_AT_location:
	.2byte 0x0309
	.8byte x
//	DW_TAG_array_type:
	.byte 0x17
//	DW_AT_type:
	.4byte 0x000001a5
//	DW_AT_byte_size:
	.2byte 0x2000
//	DW_TAG_subrange_type:
	.byte 0x18
//	DW_AT_upper_bound:
	.2byte 0x07ff
	.byte 0x00
//	DW_TAG_variable:
	.byte 0x19
//	DW_AT_decl_line:
	.byte 0x2c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x225
//	DW_AT_type:
	.4byte 0x000001a5
//	DW_AT_declaration:
	.byte 0x01
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x19
//	DW_AT_decl_line:
	.byte 0x2d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x22b
//	DW_AT_type:
	.4byte 0x000001a5
//	DW_AT_declaration:
	.byte 0x01
//	DW_AT_external:
	.byte 0x01
	.byte 0x00
// -- Begin DWARF2 SEGMENT .debug_line
	.section .debug_line
.debug_line_seg:
	.align 1
// -- Begin DWARF2 SEGMENT .debug_abbrev
	.section .debug_abbrev
.debug_abbrev_seg:
	.align 1
	.byte 0x01
	.byte 0x11
	.byte 0x01
	.byte 0x1b
	.byte 0x0e
	.byte 0x03
	.byte 0x0e
	.byte 0x25
	.byte 0x0e
	.2byte 0x7681
	.byte 0x0e
	.byte 0x13
	.byte 0x0b
	.byte 0x53
	.byte 0x0c
	.byte 0x11
	.byte 0x01
	.byte 0x55
	.byte 0x17
	.byte 0x6a
	.byte 0x0c
	.byte 0x10
	.byte 0x17
	.2byte 0x0000
	.byte 0x02
	.byte 0x24
	.byte 0x00
	.byte 0x0b
	.byte 0x0b
	.byte 0x3e
	.byte 0x0b
	.byte 0x03
	.byte 0x08
	.2byte 0x0000
	.byte 0x03
	.byte 0x2e
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x49
	.byte 0x13
	.byte 0x03
	.byte 0x0e
	.2byte 0x4087
	.byte 0x0e
	.byte 0x11
	.byte 0x01
	.byte 0x12
	.byte 0x07
	.byte 0x6a
	.byte 0x0c
	.byte 0x3f
	.byte 0x0c
	.2byte 0x0000
	.byte 0x04
	.byte 0x1d
	.byte 0x01
	.byte 0x55
	.byte 0x17
	.byte 0x52
	.byte 0x01
	.byte 0x31
	.byte 0x13
	.byte 0x59
	.byte 0x0b
	.byte 0x57
	.byte 0x0b
	.byte 0x58
	.byte 0x0b
	.2byte 0x0000
	.byte 0x05
	.byte 0x34
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x06
	.byte 0x2e
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x3c
	.byte 0x0c
	.byte 0x49
	.byte 0x13
	.byte 0x03
	.byte 0x0e
	.2byte 0x4087
	.byte 0x0e
	.byte 0x3f
	.byte 0x0c
	.byte 0x20
	.byte 0x0b
	.2byte 0x0000
	.byte 0x07
	.byte 0x24
	.byte 0x00
	.byte 0x0b
	.byte 0x0b
	.byte 0x3e
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.2byte 0x0000
	.byte 0x08
	.byte 0x2e
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x49
	.byte 0x13
	.byte 0x03
	.byte 0x0e
	.2byte 0x4087
	.byte 0x0e
	.byte 0x40
	.byte 0x18
	.byte 0x11
	.byte 0x01
	.byte 0x12
	.byte 0x07
	.byte 0x3f
	.byte 0x0c
	.2byte 0x0000
	.byte 0x09
	.byte 0x34
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.byte 0x49
	.byte 0x13
	.byte 0x02
	.byte 0x18
	.2byte 0x0000
	.byte 0x0a
	.byte 0x13
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x0b
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.2byte 0x0000
	.byte 0x0b
	.byte 0x0d
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x38
	.byte 0x18
	.byte 0x03
	.byte 0x0e
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x0c
	.byte 0x16
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x0d
	.byte 0x2e
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x27
	.byte 0x0c
	.byte 0x03
	.byte 0x0e
	.2byte 0x4087
	.byte 0x0e
	.byte 0x11
	.byte 0x01
	.byte 0x12
	.byte 0x07
	.byte 0x3f
	.byte 0x0c
	.2byte 0x0000
	.byte 0x0e
	.byte 0x05
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x49
	.byte 0x13
	.byte 0x03
	.byte 0x08
	.byte 0x02
	.byte 0x18
	.2byte 0x0000
	.byte 0x0f
	.byte 0x34
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x03
	.byte 0x08
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x10
	.byte 0x0b
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x11
	.byte 0x01
	.byte 0x12
	.byte 0x01
	.2byte 0x0000
	.byte 0x11
	.byte 0x0f
	.byte 0x00
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x12
	.byte 0x05
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x49
	.byte 0x13
	.byte 0x03
	.byte 0x0e
	.byte 0x02
	.byte 0x18
	.2byte 0x0000
	.byte 0x13
	.byte 0x26
	.byte 0x00
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x14
	.byte 0x2e
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x31
	.byte 0x13
	.byte 0x11
	.byte 0x01
	.byte 0x12
	.byte 0x07
	.2byte 0x0000
	.byte 0x15
	.byte 0x2e
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x49
	.byte 0x13
	.byte 0x03
	.byte 0x0e
	.2byte 0x4087
	.byte 0x0e
	.byte 0x11
	.byte 0x01
	.byte 0x12
	.byte 0x07
	.byte 0x3f
	.byte 0x0c
	.2byte 0x0000
	.byte 0x16
	.byte 0x34
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x03
	.byte 0x08
	.byte 0x49
	.byte 0x13
	.byte 0x02
	.byte 0x18
	.2byte 0x0000
	.byte 0x17
	.byte 0x01
	.byte 0x01
	.byte 0x49
	.byte 0x13
	.byte 0x0b
	.byte 0x05
	.2byte 0x0000
	.byte 0x18
	.byte 0x21
	.byte 0x00
	.byte 0x2f
	.byte 0x05
	.2byte 0x0000
	.byte 0x19
	.byte 0x34
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.byte 0x49
	.byte 0x13
	.byte 0x3c
	.byte 0x0c
	.byte 0x3f
	.byte 0x0c
	.2byte 0x0000
	.byte 0x00
// -- Begin DWARF2 SEGMENT .debug_frame
	.section .debug_frame
.debug_frame_seg:
	.align 1
// -- Begin DWARF2 SEGMENT .debug_str
	.section .debug_str,"MS",@progbits,1
.debug_str_seg:
	.align 1
	.8byte 0x68632f656d6f682f
	.8byte 0x62706f72442f7375
	.8byte 0x6172745f322f786f
	.8byte 0x645f342f6f6a6162
	.8byte 0x2f6169636e65636f
	.8byte 0x6e695f6f64617267
	.8byte 0x6c754d2f6d726f66
	.8byte 0x7365636f72706974
	.8byte 0x332f7365726f6461
	.8byte 0x636974636172505f
	.8byte 0x6365765f312f7361
	.8byte 0x6963617a69726f74
	.8byte 0x35692f32702f6e6f
	.4byte 0x3734332d
	.2byte 0x0030
	.8byte 0x74735f73732f2e2e
	.4byte 0x65646972
	.2byte 0x632e
	.byte 0x00
	.8byte 0x2952286c65746e49
	.8byte 0x6c65746e49204320
	.8byte 0x4320343620295228
	.8byte 0x2072656c69706d6f
	.8byte 0x6c70706120726f66
	.8byte 0x736e6f6974616369
	.8byte 0x676e696e6e757220
	.8byte 0x65746e49206e6f20
	.8byte 0x2c3436202952286c
	.8byte 0x6e6f697372655620
	.8byte 0x2e322e302e383120
	.8byte 0x6c69754220393931
	.8byte 0x3230383130322064
	.4byte 0x000a3031
	.8byte 0x633d686372616d2d
	.8byte 0x327876612d65726f
	.8byte 0x68742d6365762d20
	.8byte 0x30646c6f68736572
	.8byte 0x31633d6474732d20
	.8byte 0x334f2d20672d2031
	.8byte 0x2d206c6c61572d20
	.8byte 0x4953494345525044
	.8byte 0x4c442d20303d4e4f
	.8byte 0x20343230313d4e45
	.8byte 0x306c6c6f726e752d
	.8byte 0x6f73662d20532d20
	.8byte 0x6d73612d65637275
	.8byte 0x65737361206f2d20
	.8byte 0x73732f72656c626d
	.8byte 0x2e6564697274735f
	.8byte 0x6c676e69732e6b31
	.8byte 0x692e327876612e65
	.4byte 0x732e6363
	.byte 0x00
	.4byte 0x6e69616d
	.byte 0x00
	.8byte 0x64697274735f7373
	.4byte 0x65765f65
	.2byte 0x0063
	.8byte 0x00745f7472617473
	.4byte 0x62756f64
	.2byte 0x656c
	.byte 0x00
	.4byte 0x5f646e65
	.2byte 0x0074
	.8byte 0x64697274735f7373
	.4byte 0x73655f65
	.2byte 0x0063
	.8byte 0x6c6c61775f746567
	.4byte 0x6d69745f
	.2byte 0x0065
	.8byte 0x006c6176656d6974
	.4byte 0x735f7674
	.2byte 0x6365
	.byte 0x00
	.8byte 0x745f656d69745f5f
	.byte 0x00
	.4byte 0x676e6f6c
	.byte 0x00
	.8byte 0x00636573755f7674
	.8byte 0x6f63657375735f5f
	.4byte 0x5f73646e
	.2byte 0x0074
	.4byte 0x63656863
	.2byte 0x006b
	.4byte 0x616f6c66
	.2byte 0x0074
	.8byte 0x64656e6769736e75
	.4byte 0x746e6920
	.byte 0x00
	.8byte 0x0073746c75736572
	.4byte 0x72616863
	.byte 0x00
	.4byte 0x706f6f6c
	.byte 0x00
	.4byte 0x74696e69
	.byte 0x00
	.4byte 0x68706c61
	.2byte 0x0061
	.4byte 0x61746562
	.byte 0x00
// -- Begin DWARF2 SEGMENT .eh_frame
	.section .eh_frame,"a",@progbits
.eh_frame_seg:
	.align 8
// -- Begin DWARF2 SEGMENT .debug_ranges
	.section .debug_ranges
.debug_ranges_seg:
	.align 1
	.8byte ..LN57
	.8byte ..LN64
	.8byte ..LN65
	.8byte ..LN112
	.8byte 0x0000000000000000
	.8byte 0x0000000000000000
	.8byte ..LN18
	.8byte ..LN57
	.8byte ..LN64
	.8byte ..LN65
	.8byte 0x0000000000000000
	.8byte 0x0000000000000000
	.8byte ..L3
	.8byte ..LNinit.306
	.8byte 0x0000000000000000
	.8byte 0x0000000000000000
	.section .text
.LNDBG_TXe:
# End
