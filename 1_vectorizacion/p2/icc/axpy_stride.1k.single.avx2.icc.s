	.section .text
.LNDBG_TX:
# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 18.0.2.199 Build 20180210";
# mark_description "-march=core-avx2 -vec-threshold0 -std=c11 -g -O3 -DPRECISION=0 -DLEN=1024 -unroll0 -S -fsource-asm -o assemb";
# mark_description "ler/axpy_stride.1k.single.avx2.icc.s";
	.file "axpy_stride.c"
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
                                                          #179.1
..LN0:
	.file   1 "../axpy_stride.c"
	.loc    1  179  is_stmt 1
        pushq     %rbp                                          #179.1
	.cfi_def_cfa_offset 16
..LN1:
        movq      %rsp, %rbp                                    #179.1
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
..LN2:
        andq      $-128, %rsp                                   #179.1
..LN3:
        pushq     %r12                                          #179.1
..LN4:
        subq      $120, %rsp                                    #179.1
..LN5:
        xorl      %esi, %esi                                    #179.1
..LN6:
        movl      $3, %edi                                      #179.1
..LN7:
        call      __intel_new_feature_proc_init                 #179.1
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
..LN8:
                                # LOE rbx r12 r13 r14 r15
..B1.26:                        # Preds ..B1.1
                                # Execution count [1.00e+00]
..LN9:
        vstmxcsr  (%rsp)                                        #179.1
..LN10:
	.loc    1  180  prologue_end  is_stmt 1

###   printf("                     Time       TPI\n");

        movl      $il0_peep_printf_format_0, %edi               #180.3
..LN11:
	.loc    1  179  is_stmt 1
        orl       $32832, (%rsp)                                #179.1
..LN12:
        vldmxcsr  (%rsp)                                        #179.1
..LN13:
	.loc    1  180  is_stmt 1
        call      puts                                          #180.3
..LN14:
                                # LOE rbx r12 r13 r14 r15
..B1.2:                         # Preds ..B1.26
                                # Execution count [1.00e+00]
..LN15:
	.loc    1  181  is_stmt 1

###   printf("             Loop     ns       ps/el     Checksum\n");

        movl      $il0_peep_printf_format_1, %edi               #181.3
..LN16:
        call      puts                                          #181.3
..LN17:
                                # LOE rbx r12 r13 r14 r15
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
..___tag_value_main.9:
..LN18:
	.loc    1  114  is_stmt 1
#       init()
        call      init                                          #114.3
..___tag_value_main.10:
..LN19:
                                # LOE rbx r12 r13 r14 r15
..B1.4:                         # Preds ..B1.3
                                # Execution count [1.00e+00]
..___tag_value_main.11:
..LN20:
	.loc    1  115  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #115.13
..___tag_value_main.12:
..LN21:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.27:                        # Preds ..B1.4
                                # Execution count [1.00e+00]
..LN22:
        vmovsd    %xmm0, (%rsp)                                 #115.13[spill]
..LN23:
                                # LOE rbx r12 r13 r14 r15
..B1.5:                         # Preds ..B1.27
                                # Execution count [9.00e-01]
..LN24:
	.loc    1  116  is_stmt 1
        xorl      %eax, %eax                                    #116.3
..LN25:
        movl      %eax, %r12d                                   #116.3
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
	.loc    1  121  is_stmt 1
        vmovss    .L_2il0floatpacket.0(%rip), %xmm1             #121.5
..LN28:
        xorl      %edx, %edx                                    #121.5
..LN29:
                                # LOE rbx r13 r14 r15 edx r12d xmm1
..B1.7:                         # Preds ..B1.7 ..B1.6
                                # Execution count [5.12e+03]
..L15:
                # optimization report
                # %s was not vectorized: novector directive used
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN30:
	.loc    1  123  is_stmt 1
        lea       (%rdx,%rdx), %ecx                             #123.20
..LN31:
	.loc    1  121  is_stmt 1
        incl      %edx                                          #121.5
..LN32:
	.loc    1  123  is_stmt 1
        vmovss    x(,%rcx,4), %xmm0                             #123.20
..LN33:
        vfmadd213ss y(,%rcx,4), %xmm1, %xmm0                    #123.7
..LN34:
        vmovss    %xmm0, y(,%rcx,4)                             #123.7
..LN35:
	.loc    1  121  is_stmt 1
        cmpl      $1024, %edx                                   #121.5
..LN36:
        jb        ..B1.7        # Prob 99%                      #121.5
..LN37:
                                # LOE rbx r13 r14 r15 edx r12d xmm1
..B1.8:                         # Preds ..B1.7
                                # Execution count [5.00e+00]
..LN38:
	.loc    1  125  is_stmt 1
        vmovss    .L_2il0floatpacket.0(%rip), %xmm0             #125.5
..LN39:
        movl      $x, %edi                                      #125.5
..LN40:
        movl      $y, %esi                                      #125.5
..LN41:
        movl      $z, %edx                                      #125.5
..___tag_value_main.16:
..LN42:
#       dummy(float *, float *, float *, float)
        call      dummy                                         #125.5
..___tag_value_main.17:
..LN43:
                                # LOE rbx r13 r14 r15 r12d
..B1.9:                         # Preds ..B1.8
                                # Execution count [5.00e+00]
..LN44:
	.loc    1  116  is_stmt 1
        incl      %r12d                                         #116.3
..LN45:
        cmpl      $15728640, %r12d                              #116.3
..LN46:
        jb        ..B1.6        # Prob 82%                      #116.3
..LN47:
                                # LOE rbx r13 r14 r15 r12d
..B1.10:                        # Preds ..B1.9
                                # Execution count [1.00e+00]
..___tag_value_main.18:
..LN48:
	.loc    1  127  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #127.11
..___tag_value_main.19:
..LN49:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.11:                        # Preds ..B1.10
                                # Execution count [1.00e+00]
..LN50:
	.loc    1  128  is_stmt 1
        movl      $.L_2__STRING.2, %edi                         #128.3
..LN51:
        vsubsd    (%rsp), %xmm0, %xmm0                          #128.3[spill]
..___tag_value_main.20:
..LN52:
#       results(const double, const char *)
        call      results                                       #128.3
..___tag_value_main.21:
..LN53:
                                # LOE rbx r12 r13 r14 r15
..B1.12:                        # Preds ..B1.11
                                # Execution count [1.00e+00]
..LN54:
	.loc    1  129  is_stmt 1
        movl      $y, %edi                                      #129.3
..___tag_value_main.23:
..LN55:
#       check(float *)
        call      check                                         #129.3
..___tag_value_main.24:
..LN56:
                                # LOE rbx r12 r13 r14 r15
..B1.13:                        # Preds ..B1.12
                                # Execution count [1.00e+00]
..___tag_value_main.25:
..LN57:
	.loc    1  137  is_stmt 1
#       init()
        call      init                                          #137.3
..___tag_value_main.26:
..LN58:
                                # LOE rbx r12 r13 r14 r15
..B1.14:                        # Preds ..B1.13
                                # Execution count [1.00e+00]
..___tag_value_main.27:
..LN59:
	.loc    1  138  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #138.13
..___tag_value_main.28:
..LN60:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.29:                        # Preds ..B1.14
                                # Execution count [1.00e+00]
..LN61:
        vmovsd    %xmm0, (%rsp)                                 #138.13[spill]
..LN62:
                                # LOE rbx r12 r13 r14 r15
..B1.15:                        # Preds ..B1.29
                                # Execution count [9.00e-01]
..LN63:
	.loc    1  139  is_stmt 1
        xorl      %eax, %eax                                    #139.3
..LN64:
	.loc    1  123  is_stmt 1
        movl      %eax, %r12d                                   #123.14
..LN65:
                                # LOE rbx r13 r14 r15 r12d
..B1.16:                        # Preds ..B1.19 ..B1.15
                                # Execution count [5.00e+00]
..L30:
                # optimization report
                # LOOP WITH UNSIGNED INDUCTION VARIABLE
                # %s was not vectorized: inner loop was already vectorized
..LN66:
	.loc    1  139  is_stmt 1
..LN67:
	.loc    1  141  is_stmt 1
        vmovups   .L_2il0floatpacket.1(%rip), %xmm6             #141.5
..LN68:
        xorl      %edx, %edx                                    #141.5
        .align    16,0x90
..LN69:
                                # LOE rbx r13 r14 r15 edx r12d xmm6
..B1.17:                        # Preds ..B1.17 ..B1.16
                                # Execution count [5.12e+03]
..L31:
                # optimization report
                # LOOP WAS VECTORIZED
                # VECTORIZATION SPEEDUP COEFFECIENT 1.000000
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
                # VECTOR LENGTH 2
                # MAIN VECTOR TYPE: 32-bits floating point
                # COST MODEL DECISION WAS IGNORED
..LN70:
	.loc    1  143  is_stmt 1
        lea       (%rdx,%rdx), %ecx                             #143.22
..LN71:
	.loc    1  141  is_stmt 1
        addl      $2, %edx                                      #141.5
..LN72:
	.loc    1  143  is_stmt 1
        vmovss    8+x(,%rcx,4), %xmm1                           #143.22
..LN73:
	.loc    1  141  is_stmt 1
        cmpl      $1024, %edx                                   #141.5
..LN74:
	.loc    1  143  is_stmt 1
        vmovss    x(,%rcx,4), %xmm0                             #143.22
..LN75:
        vmovss    8+y(,%rcx,4), %xmm3                           #143.29
..LN76:
        vmovss    y(,%rcx,4), %xmm2                             #143.29
..LN77:
        vunpcklps %xmm1, %xmm0, %xmm4                           #143.22
..LN78:
        vunpcklps %xmm3, %xmm2, %xmm5                           #143.29
..LN79:
        vfmadd231ps %xmm6, %xmm4, %xmm5                         #143.29
..LN80:
        vmovss    %xmm5, y(,%rcx,4)                             #143.9
..LN81:
        vextractps $1, %xmm5, 8+y(,%rcx,4)                      #143.9
..LN82:
	.loc    1  141  is_stmt 1
        jb        ..B1.17       # Prob 99%                      #141.5
..LN83:
                                # LOE rbx r13 r14 r15 edx r12d xmm6
..B1.18:                        # Preds ..B1.17
                                # Execution count [5.00e+00]
..LN84:
	.loc    1  145  is_stmt 1
        vmovss    .L_2il0floatpacket.0(%rip), %xmm0             #145.5
..LN85:
        movl      $x, %edi                                      #145.5
..LN86:
        movl      $y, %esi                                      #145.5
..LN87:
        movl      $z, %edx                                      #145.5
..___tag_value_main.32:
..LN88:
#       dummy(float *, float *, float *, float)
        call      dummy                                         #145.5
..___tag_value_main.33:
..LN89:
                                # LOE rbx r13 r14 r15 r12d
..B1.19:                        # Preds ..B1.18
                                # Execution count [5.00e+00]
..LN90:
	.loc    1  139  is_stmt 1
        incl      %r12d                                         #139.3
..LN91:
        cmpl      $15728640, %r12d                              #139.3
..LN92:
        jb        ..B1.16       # Prob 82%                      #139.3
..LN93:
                                # LOE rbx r13 r14 r15 r12d
..B1.20:                        # Preds ..B1.19
                                # Execution count [1.00e+00]
..___tag_value_main.34:
..LN94:
	.loc    1  147  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #147.11
..___tag_value_main.35:
..LN95:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.21:                        # Preds ..B1.20
                                # Execution count [1.00e+00]
..LN96:
	.loc    1  148  is_stmt 1
        movl      $.L_2__STRING.3, %edi                         #148.3
..LN97:
        vsubsd    (%rsp), %xmm0, %xmm0                          #148.3[spill]
..___tag_value_main.36:
..LN98:
#       results(const double, const char *)
        call      results                                       #148.3
..___tag_value_main.37:
..LN99:
                                # LOE rbx r12 r13 r14 r15
..B1.22:                        # Preds ..B1.21
                                # Execution count [1.00e+00]
..LN100:
	.loc    1  149  is_stmt 1
        movl      $y, %edi                                      #149.3
..___tag_value_main.39:
..LN101:
#       check(float *)
        call      check                                         #149.3
..___tag_value_main.40:
..LN102:
                                # LOE rbx r12 r13 r14 r15
..B1.23:                        # Preds ..B1.22
                                # Execution count [1.00e+00]
..LN103:
	.loc    1  185  is_stmt 1

###   axpy_stride_esc();
###   axpy_stride_vec();
###   //axpy_stride_v2(x);
###   return 0;

        xorl      %eax, %eax                                    #185.10
..LN104:
	.loc    1  185  epilogue_begin  is_stmt 1
        addq      $120, %rsp                                    #185.10
	.cfi_restore 12
..LN105:
        popq      %r12                                          #185.10
..LN106:
        movq      %rbp, %rsp                                    #185.10
..LN107:
        popq      %rbp                                          #185.10
	.cfi_def_cfa 7, 8
	.cfi_restore 6
..LN108:
        ret                                                     #185.10
        .align    16,0x90
..LN109:
                                # LOE
..LN110:
	.cfi_endproc
# mark_end;
	.type	main,@function
	.size	main,.-main
..LNmain.111:
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
                                                         #57.1
..LN112:
	.loc    1  57  is_stmt 1
        subq      $24, %rsp                                     #57.1
	.cfi_def_cfa_offset 32
..LN113:
	.loc    1  59  prologue_end  is_stmt 1

###     struct timeval time;
###     if (gettimeofday(&time,NULL)) {

        xorl      %esi, %esi                                    #59.9
..LN114:
        lea       (%rsp), %rdi                                  #59.9
..LN115:
#       gettimeofday(struct timeval *__restrict__, __timezone_ptr_t)
        call      gettimeofday                                  #59.9
..LN116:
                                # LOE rbx rbp r12 r13 r14 r15 eax
..B2.2:                         # Preds ..B2.1
                                # Execution count [1.00e+00]
..LN117:
        testl     %eax, %eax                                    #59.9
..LN118:
        jne       ..B2.4        # Prob 0%                       #59.9
..LN119:
                                # LOE rbx rbp r12 r13 r14 r15
..B2.3:                         # Preds ..B2.2
                                # Execution count [9.95e-01]
..LN120:
	.loc    1  62  is_stmt 1

###         exit(-1); // return 0;
###     }
###     return (double)time.tv_sec + (double)time.tv_usec * .000001;

        vxorpd    %xmm0, %xmm0, %xmm0                           #62.42
..LN121:
        vxorpd    %xmm1, %xmm1, %xmm1                           #62.20
..LN122:
        vcvtsi2sdq 8(%rsp), %xmm0, %xmm0                        #62.42
..LN123:
        vcvtsi2sdq (%rsp), %xmm1, %xmm1                         #62.20
..LN124:
        vfmadd132sd .L_2il0floatpacket.2(%rip), %xmm1, %xmm0    #62.57
..LN125:
	.loc    1  62  epilogue_begin  is_stmt 1
        addq      $24, %rsp                                     #62.57
	.cfi_def_cfa_offset 8
..LN126:
        ret                                                     #62.57
	.cfi_def_cfa_offset 32
..LN127:
                                # LOE
..B2.4:                         # Preds ..B2.2
                                # Execution count [5.00e-03]: Infreq
..LN128:
	.loc    1  60  is_stmt 1
        movl      $-1, %edi                                     #60.9
..LN129:
#       exit(int)
        call      exit                                          #60.9
        .align    16,0x90
..LN130:
                                # LOE
..LN131:
	.cfi_endproc
# mark_end;
	.type	get_wall_time,@function
	.size	get_wall_time,.-get_wall_time
..LNget_wall_time.132:
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
                                                         #72.1
..LN133:
	.loc    1  72  is_stmt 1
        pushq     %rsi                                          #72.1
	.cfi_def_cfa_offset 16
..LN134:
	.loc    1  77  prologue_end  is_stmt 1

###   real sum = 0;
### #ifdef __INTEL_COMPILER
###   #pragma novector
### #endif
###   for (unsigned int i = 0; i < LEN; i++)

        xorl      %edx, %edx                                    #77.23
..LN135:
	.loc    1  73  is_stmt 1
        vxorps    %xmm0, %xmm0, %xmm0                           #73.12
..LN136:
	.loc    1  77  is_stmt 1
        xorl      %eax, %eax                                    #77.37
..LN137:
                                # LOE rdx rbx rbp rdi r12 r13 r14 r15 eax xmm0
..B3.2:                         # Preds ..B3.2 ..B3.1
                                # Execution count [1.02e+03]
..L63:
                # optimization report
                # %s was not vectorized: novector directive used
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN138:
..LN139:
        incl      %eax                                          #77.37
..LN140:
	.loc    1  78  is_stmt 1

###     sum += arr[i];

        vaddss    (%rdi,%rdx,4), %xmm0, %xmm0                   #78.5
..LN141:
	.loc    1  77  is_stmt 1
        movl      %eax, %edx                                    #77.37
..LN142:
        cmpl      $1024, %eax                                   #77.32
..LN143:
        jb        ..B3.2        # Prob 99%                      #77.32
..LN144:
                                # LOE rdx rbx rbp rdi r12 r13 r14 r15 eax xmm0
..B3.3:                         # Preds ..B3.2
                                # Execution count [1.00e+00]
..LN145:
	.loc    1  80  is_stmt 1

### 
###   printf("%f \n", sum);

        vcvtss2sd %xmm0, %xmm0, %xmm0                           #80.3
..LN146:
        movl      $.L_2__STRING.0, %edi                         #80.3
..LN147:
        movl      $1, %eax                                      #80.3
..___tag_value_check.64:
..LN148:
#       printf(const char *__restrict__, ...)
        call      printf                                        #80.3
..___tag_value_check.65:
..LN149:
                                # LOE rbx rbp r12 r13 r14 r15
..B3.4:                         # Preds ..B3.3
                                # Execution count [1.00e+00]

### }

..LN150:
	.loc    1  81  epilogue_begin  is_stmt 1
        popq      %rcx                                          #81.1
	.cfi_def_cfa_offset 8
..LN151:
        ret                                                     #81.1
        .align    16,0x90
..LN152:
                                # LOE
..LN153:
	.cfi_endproc
# mark_end;
	.type	check,@function
	.size	check,.-check
..LNcheck.154:
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
                                                         #99.1
..LN155:
	.loc    1  99  is_stmt 1
        movq      %rdi, %rsi                                    #99.1
..LN156:
	.loc    1  100  prologue_end  is_stmt 1

###     printf("%18s  %6.1f    %6.1f     ",

        vdivsd    .L_2il0floatpacket.3(%rip), %xmm0, %xmm2      #100.5
..LN157:
        vdivsd    .L_2il0floatpacket.4(%rip), %xmm0, %xmm1      #100.5
..LN158:
        movl      $.L_2__STRING.1, %edi                         #100.5
..LN159:
        movl      $2, %eax                                      #100.5
..LN160:
        vmovapd   %xmm2, %xmm0                                  #100.5
..LN161:
	.loc    1  100  epilogue_begin  is_stmt 1
#       printf(const char *__restrict__, ...)
        jmp       printf                                        #100.5
        .align    16,0x90
..LN162:
                                # LOE
..LN163:
	.cfi_endproc
# mark_end;
	.type	results,@function
	.size	results,.-results
..LNresults.164:
.LNresults:
	.data
# -- End  results
	.text
.L_2__routine_start_axpy_stride_esc_4:
# -- Begin  axpy_stride_esc
	.text
# mark_begin;
       .align    16,0x90
	.globl axpy_stride_esc
# --- axpy_stride_esc()
axpy_stride_esc:
..B5.1:                         # Preds ..B5.0
                                # Execution count [1.00e+00]

### {

	.cfi_startproc
..___tag_value_axpy_stride_esc.79:
..L80:
                                                         #111.1
..LN165:
	.loc    1  111  is_stmt 1
        subq      $24, %rsp                                     #111.1
	.cfi_def_cfa_offset 32

###   double start_t, end_t;
### 
###   init();

..___tag_value_axpy_stride_esc.83:
..LN166:
	.loc    1  114  prologue_end  is_stmt 1
#       init()
        call      init                                          #114.3
..___tag_value_axpy_stride_esc.84:
..LN167:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.2:                         # Preds ..B5.1
                                # Execution count [1.00e+00]

###   start_t = get_wall_time();

..___tag_value_axpy_stride_esc.85:
..LN168:
	.loc    1  115  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #115.13
..___tag_value_axpy_stride_esc.86:
..LN169:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B5.14:                        # Preds ..B5.2
                                # Execution count [1.00e+00]
..LN170:
        vmovsd    %xmm0, (%rsp)                                 #115.13[spill]
..LN171:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.3:                         # Preds ..B5.14
                                # Execution count [9.00e-01]
..LN172:
	.loc    1  116  is_stmt 1

###   for (unsigned int nl = 0; nl < NTIMES; nl++)

        xorl      %eax, %eax                                    #116.3

###  {
### #ifdef __INTEL_COMPILER
###   #pragma novector
### #endif
###     for (unsigned int i = 0; i < 2*LEN; i+=2)
###     {
###       y[i] = alpha*x[i] + y[i];

..LN173:
	.loc    1  123  is_stmt 1
        movq      %r12, 8(%rsp)                                 #123.14[spill]
	.cfi_offset 12, -24
..LN174:
        movl      %eax, %r12d                                   #123.14
..LN175:
                                # LOE rbx rbp r13 r14 r15 r12d
..B5.4:                         # Preds ..B5.7 ..B5.3
                                # Execution count [5.00e+00]
..L90:
                # optimization report
                # LOOP WITH UNSIGNED INDUCTION VARIABLE
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
                # COST MODEL DECISION WAS IGNORED
..LN176:
	.loc    1  116  is_stmt 1
..LN177:
	.loc    1  121  is_stmt 1
        vmovss    .L_2il0floatpacket.0(%rip), %xmm1             #121.5
..LN178:
        xorl      %edx, %edx                                    #121.5
..LN179:
                                # LOE rbx rbp r13 r14 r15 edx r12d xmm1
..B5.5:                         # Preds ..B5.5 ..B5.4
                                # Execution count [5.12e+03]
..L91:
                # optimization report
                # %s was not vectorized: novector directive used
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN180:
	.loc    1  123  is_stmt 1
        lea       (%rdx,%rdx), %ecx                             #123.20
..LN181:
	.loc    1  121  is_stmt 1
        incl      %edx                                          #121.5
..LN182:
	.loc    1  123  is_stmt 1
        vmovss    x(,%rcx,4), %xmm0                             #123.20
..LN183:
        vfmadd213ss y(,%rcx,4), %xmm1, %xmm0                    #123.7
..LN184:
        vmovss    %xmm0, y(,%rcx,4)                             #123.7
..LN185:
	.loc    1  121  is_stmt 1
        cmpl      $1024, %edx                                   #121.5
..LN186:
        jb        ..B5.5        # Prob 99%                      #121.5
..LN187:
                                # LOE rbx rbp r13 r14 r15 edx r12d xmm1
..B5.6:                         # Preds ..B5.5
                                # Execution count [5.00e+00]
..LN188:
	.loc    1  125  is_stmt 1

###     }
###     dummy(x, y, z, alpha);

        vmovss    .L_2il0floatpacket.0(%rip), %xmm0             #125.5
..LN189:
        movl      $x, %edi                                      #125.5
..LN190:
        movl      $y, %esi                                      #125.5
..LN191:
        movl      $z, %edx                                      #125.5
..___tag_value_axpy_stride_esc.92:
..LN192:
#       dummy(float *, float *, float *, float)
        call      dummy                                         #125.5
..___tag_value_axpy_stride_esc.93:
..LN193:
                                # LOE rbx rbp r13 r14 r15 r12d
..B5.7:                         # Preds ..B5.6
                                # Execution count [5.00e+00]
..LN194:
	.loc    1  116  is_stmt 1
        incl      %r12d                                         #116.3
..LN195:
        cmpl      $15728640, %r12d                              #116.3
..LN196:
        jb        ..B5.4        # Prob 82%                      #116.3
..LN197:
                                # LOE rbx rbp r13 r14 r15 r12d
..B5.8:                         # Preds ..B5.7
                                # Execution count [1.00e+00]
..LN198:
        movq      8(%rsp), %r12                                 #[spill]
	.cfi_restore 12

###   }
###   end_t = get_wall_time();

..___tag_value_axpy_stride_esc.95:
..LN199:
	.loc    1  127  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #127.11
..___tag_value_axpy_stride_esc.96:
	.cfi_offset 12, -24
..LN200:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B5.9:                         # Preds ..B5.8
                                # Execution count [1.00e+00]
..LN201:
	.loc    1  128  is_stmt 1

###   results(end_t - start_t, "axpy_stride_esc");

        movl      $.L_2__STRING.2, %edi                         #128.3
..LN202:
        vsubsd    (%rsp), %xmm0, %xmm0                          #128.3[spill]
..___tag_value_axpy_stride_esc.98:
..LN203:
#       results(const double, const char *)
        call      results                                       #128.3
..___tag_value_axpy_stride_esc.99:
..LN204:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.10:                        # Preds ..B5.9
                                # Execution count [1.00e+00]
..LN205:
	.loc    1  129  is_stmt 1

###   check(y);

        movl      $y, %edi                                      #129.3
..___tag_value_axpy_stride_esc.101:
..LN206:
#       check(float *)
        call      check                                         #129.3
..___tag_value_axpy_stride_esc.102:
..LN207:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.11:                        # Preds ..B5.10
                                # Execution count [1.00e+00]
..LN208:
	.loc    1  130  is_stmt 1

###   return 0;

        xorl      %eax, %eax                                    #130.10
..LN209:
	.loc    1  130  epilogue_begin  is_stmt 1
        addq      $24, %rsp                                     #130.10
	.cfi_def_cfa_offset 8
..LN210:
        ret                                                     #130.10
        .align    16,0x90
..LN211:
                                # LOE
..LN212:
	.cfi_endproc
# mark_end;
	.type	axpy_stride_esc,@function
	.size	axpy_stride_esc,.-axpy_stride_esc
..LNaxpy_stride_esc.213:
.LNaxpy_stride_esc:
	.data
# -- End  axpy_stride_esc
	.text
.L_2__routine_start_axpy_stride_vec_5:
# -- Begin  axpy_stride_vec
	.text
# mark_begin;
       .align    16,0x90
	.globl axpy_stride_vec
# --- axpy_stride_vec()
axpy_stride_vec:
..B6.1:                         # Preds ..B6.0
                                # Execution count [1.00e+00]

### {

	.cfi_startproc
..___tag_value_axpy_stride_vec.108:
..L109:
                                                        #134.1
..LN214:
	.loc    1  134  is_stmt 1
        pushq     %rbp                                          #134.1
	.cfi_def_cfa_offset 16
..LN215:
        movq      %rsp, %rbp                                    #134.1
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
..LN216:
        andq      $-32, %rsp                                    #134.1
..LN217:
        subq      $32, %rsp                                     #134.1

###   double start_t, end_t;
### 
###   init();

..___tag_value_axpy_stride_vec.114:
..LN218:
	.loc    1  137  prologue_end  is_stmt 1
#       init()
        call      init                                          #137.3
..___tag_value_axpy_stride_vec.115:
..LN219:
                                # LOE rbx r12 r13 r14 r15
..B6.2:                         # Preds ..B6.1
                                # Execution count [1.00e+00]

###   start_t = get_wall_time();

..___tag_value_axpy_stride_vec.116:
..LN220:
	.loc    1  138  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #138.13
..___tag_value_axpy_stride_vec.117:
..LN221:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B6.14:                        # Preds ..B6.2
                                # Execution count [1.00e+00]
..LN222:
        vmovsd    %xmm0, (%rsp)                                 #138.13[spill]
..LN223:
                                # LOE rbx r12 r13 r14 r15
..B6.3:                         # Preds ..B6.14
                                # Execution count [9.00e-01]
..LN224:
	.loc    1  139  is_stmt 1

###   for (unsigned int nl = 0; nl < NTIMES; nl++)

        xorl      %eax, %eax                                    #139.3

###   {
###     for (unsigned int i = 0; i < 2*LEN; i+=2)
###     {
###         y[i] = alpha*x[i] + y[i];

..LN225:
	.loc    1  143  is_stmt 1
        movq      %r12, 8(%rsp)                                 #143.16[spill]
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
..LN226:
        movl      %eax, %r12d                                   #143.16
..LN227:
                                # LOE rbx r13 r14 r15 r12d
..B6.4:                         # Preds ..B6.7 ..B6.3
                                # Execution count [5.00e+00]
..L121:
                # optimization report
                # LOOP WITH UNSIGNED INDUCTION VARIABLE
                # %s was not vectorized: inner loop was already vectorized
..LN228:
	.loc    1  139  is_stmt 1
..LN229:
	.loc    1  141  is_stmt 1
        vmovups   .L_2il0floatpacket.1(%rip), %xmm6             #141.5
..LN230:
        xorl      %edx, %edx                                    #141.5
        .align    16,0x90
..LN231:
                                # LOE rbx r13 r14 r15 edx r12d xmm6
..B6.5:                         # Preds ..B6.5 ..B6.4
                                # Execution count [5.12e+03]
..L122:
                # optimization report
                # LOOP WAS VECTORIZED
                # VECTORIZATION SPEEDUP COEFFECIENT 1.000000
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
                # VECTOR LENGTH 2
                # MAIN VECTOR TYPE: 32-bits floating point
                # COST MODEL DECISION WAS IGNORED
..LN232:
	.loc    1  143  is_stmt 1
        lea       (%rdx,%rdx), %ecx                             #143.22
..LN233:
	.loc    1  141  is_stmt 1
        addl      $2, %edx                                      #141.5
..LN234:
	.loc    1  143  is_stmt 1
        vmovss    8+x(,%rcx,4), %xmm1                           #143.22
..LN235:
	.loc    1  141  is_stmt 1
        cmpl      $1024, %edx                                   #141.5
..LN236:
	.loc    1  143  is_stmt 1
        vmovss    x(,%rcx,4), %xmm0                             #143.22
..LN237:
        vmovss    8+y(,%rcx,4), %xmm3                           #143.29
..LN238:
        vmovss    y(,%rcx,4), %xmm2                             #143.29
..LN239:
        vunpcklps %xmm1, %xmm0, %xmm4                           #143.22
..LN240:
        vunpcklps %xmm3, %xmm2, %xmm5                           #143.29
..LN241:
        vfmadd231ps %xmm6, %xmm4, %xmm5                         #143.29
..LN242:
        vmovss    %xmm5, y(,%rcx,4)                             #143.9
..LN243:
        vextractps $1, %xmm5, 8+y(,%rcx,4)                      #143.9
..LN244:
	.loc    1  141  is_stmt 1
        jb        ..B6.5        # Prob 99%                      #141.5
..LN245:
                                # LOE rbx r13 r14 r15 edx r12d xmm6
..B6.6:                         # Preds ..B6.5
                                # Execution count [5.00e+00]
..LN246:
	.loc    1  145  is_stmt 1

###     }
###     dummy(x, y, z, alpha);

        vmovss    .L_2il0floatpacket.0(%rip), %xmm0             #145.5
..LN247:
        movl      $x, %edi                                      #145.5
..LN248:
        movl      $y, %esi                                      #145.5
..LN249:
        movl      $z, %edx                                      #145.5
..___tag_value_axpy_stride_vec.123:
..LN250:
#       dummy(float *, float *, float *, float)
        call      dummy                                         #145.5
..___tag_value_axpy_stride_vec.124:
..LN251:
                                # LOE rbx r13 r14 r15 r12d
..B6.7:                         # Preds ..B6.6
                                # Execution count [5.00e+00]
..LN252:
	.loc    1  139  is_stmt 1
        incl      %r12d                                         #139.3
..LN253:
        cmpl      $15728640, %r12d                              #139.3
..LN254:
        jb        ..B6.4        # Prob 82%                      #139.3
..LN255:
                                # LOE rbx r13 r14 r15 r12d
..B6.8:                         # Preds ..B6.7
                                # Execution count [1.00e+00]
..LN256:
        movq      8(%rsp), %r12                                 #[spill]
	.cfi_restore 12

###   }
###   end_t = get_wall_time();

..___tag_value_axpy_stride_vec.126:
..LN257:
	.loc    1  147  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #147.11
..___tag_value_axpy_stride_vec.127:
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
..LN258:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B6.9:                         # Preds ..B6.8
                                # Execution count [1.00e+00]
..LN259:
	.loc    1  148  is_stmt 1

###   results(end_t - start_t, "axpy_stride_vec");

        movl      $.L_2__STRING.3, %edi                         #148.3
..LN260:
        vsubsd    (%rsp), %xmm0, %xmm0                          #148.3[spill]
..___tag_value_axpy_stride_vec.129:
..LN261:
#       results(const double, const char *)
        call      results                                       #148.3
..___tag_value_axpy_stride_vec.130:
..LN262:
                                # LOE rbx r12 r13 r14 r15
..B6.10:                        # Preds ..B6.9
                                # Execution count [1.00e+00]
..LN263:
	.loc    1  149  is_stmt 1

###   check(y);

        movl      $y, %edi                                      #149.3
..___tag_value_axpy_stride_vec.132:
..LN264:
#       check(float *)
        call      check                                         #149.3
..___tag_value_axpy_stride_vec.133:
..LN265:
                                # LOE rbx r12 r13 r14 r15
..B6.11:                        # Preds ..B6.10
                                # Execution count [1.00e+00]
..LN266:
	.loc    1  150  is_stmt 1

###   return 0;

        xorl      %eax, %eax                                    #150.10
..LN267:
	.loc    1  150  epilogue_begin  is_stmt 1
        movq      %rbp, %rsp                                    #150.10
..LN268:
        popq      %rbp                                          #150.10
	.cfi_def_cfa 7, 8
	.cfi_restore 6
..LN269:
        ret                                                     #150.10
        .align    16,0x90
..LN270:
                                # LOE
..LN271:
	.cfi_endproc
# mark_end;
	.type	axpy_stride_vec,@function
	.size	axpy_stride_vec,.-axpy_stride_vec
..LNaxpy_stride_vec.272:
.LNaxpy_stride_vec:
	.data
# -- End  axpy_stride_vec
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
                                                        #88.1
..LN273:
	.loc    1  88  prologue_end  is_stmt 1
..LN274:
	.loc    1  89  is_stmt 1

###   for (int j = 0; j < LEN; j++)

        xorl      %eax, %eax                                    #89.3
..LN275:
	.loc    1  91  is_stmt 1

###   {
###     x[j] = 2.0;

        vmovups   .L_2il0floatpacket.5(%rip), %ymm1             #91.12
..LN276:
	.loc    1  92  is_stmt 1

###     y[j] = 0.5;

        vmovups   .L_2il0floatpacket.6(%rip), %ymm0             #92.12
..LN277:
                                # LOE rax rbx rbp r12 r13 r14 r15 ymm0 ymm1
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
..LN278:
	.loc    1  89  is_stmt 1
..LN279:
	.loc    1  91  is_stmt 1
        vmovups   %ymm1, x(,%rax,4)                             #91.5
..LN280:
	.loc    1  92  is_stmt 1
        vmovups   %ymm0, y(,%rax,4)                             #92.5
..LN281:
	.loc    1  89  is_stmt 1
        addq      $8, %rax                                      #89.3
..LN282:
        cmpq      $1024, %rax                                   #89.3
..LN283:
        jb        ..B7.2        # Prob 99%                      #89.3
..LN284:
                                # LOE rax rbx rbp r12 r13 r14 r15 ymm0 ymm1
..B7.3:                         # Preds ..B7.2
                                # Execution count [1.00e+00]
..LN285:
	.loc    1  94  is_stmt 1

###   }
###   return 0;

        vzeroupper                                              #94.10
..LN286:
        xorl      %eax, %eax                                    #94.10
..LN287:
	.loc    1  94  epilogue_begin  is_stmt 1
        ret                                                     #94.10
        .align    16,0x90
..LN288:
                                # LOE
..LN289:
	.cfi_endproc
# mark_end;
	.type	init,@function
	.size	init,.-init
..LNinit.290:
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
	.space 512	# pad
	.align 64
y:
	.type	y,@object
	.size	y,8192
	.space 8192	# pad
	.space 512	# pad
	.align 64
z:
	.type	z,@object
	.size	z,8192
	.space 8192	# pad
	.section .rodata, "a"
	.align 32
	.align 32
.L_2il0floatpacket.5:
	.long	0x40000000,0x40000000,0x40000000,0x40000000,0x40000000,0x40000000,0x40000000,0x40000000
	.type	.L_2il0floatpacket.5,@object
	.size	.L_2il0floatpacket.5,32
	.align 32
.L_2il0floatpacket.6:
	.long	0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000
	.type	.L_2il0floatpacket.6,@object
	.size	.L_2il0floatpacket.6,32
	.align 16
.L_2il0floatpacket.1:
	.long	0x3e800000,0x3e800000,0x3e800000,0x3e800000
	.type	.L_2il0floatpacket.1,@object
	.size	.L_2il0floatpacket.1,16
	.align 8
.L_2il0floatpacket.2:
	.long	0xa0b5ed8d,0x3eb0c6f7
	.type	.L_2il0floatpacket.2,@object
	.size	.L_2il0floatpacket.2,8
	.align 8
.L_2il0floatpacket.3:
	.long	0x29a4692c,0x3f901b2b
	.type	.L_2il0floatpacket.3,@object
	.size	.L_2il0floatpacket.3,8
	.align 8
.L_2il0floatpacket.4:
	.long	0xe91b0b70,0x3f907e1f
	.type	.L_2il0floatpacket.4,@object
	.size	.L_2il0floatpacket.4,8
	.align 4
.L_2il0floatpacket.0:
	.long	0x3e800000
	.type	.L_2il0floatpacket.0,@object
	.size	.L_2il0floatpacket.0,4
	.section .rodata.str1.4, "aMS",@progbits,1
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.2:
	.long	2037413985
	.long	1920234335
	.long	1600480361
	.long	6517605
	.type	.L_2__STRING.2,@object
	.size	.L_2__STRING.2,16
	.align 4
.L_2__STRING.3:
	.long	2037413985
	.long	1920234335
	.long	1600480361
	.long	6514038
	.type	.L_2__STRING.3,@object
	.size	.L_2__STRING.3,16
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
	.long	-2088255360
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
	.long	-1065320318
	.long	310412167
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
	.4byte 0x00000375
	.2byte 0x0004
	.4byte .debug_abbrev_seg
	.byte 0x08
//	DW_TAG_compile_unit:
	.byte 0x01
//	DW_AT_comp_dir:
	.4byte .debug_str
//	DW_AT_name:
	.4byte .debug_str+0x6c
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
	.byte 0xb2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000002f
//	DW_AT_name:
	.4byte .debug_str+0x17a
	.4byte .debug_str+0x17a
//	DW_AT_low_pc:
	.8byte ..L3
//	DW_AT_high_pc:
	.8byte ..LNmain.111-..L3
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
	.byte 0xb7
//	DW_AT_call_column:
	.byte 0x03
//	DW_AT_call_file:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x87
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x18f
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x87
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x19e
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
	.byte 0xb6
//	DW_AT_call_column:
	.byte 0x03
//	DW_AT_call_file:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x70
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x18f
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x70
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x19e
//	DW_AT_type:
	.4byte 0x000000c0
	.byte 0x00
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x85
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_declaration:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000002f
//	DW_AT_name:
	.4byte .debug_str+0x17f
	.4byte .debug_str+0x17f
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
	.4byte .debug_str+0x197
//	DW_TAG_subprogram:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x6e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_declaration:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000002f
//	DW_AT_name:
	.4byte .debug_str+0x1a4
	.4byte .debug_str+0x1a4
//	DW_AT_external:
	.byte 0x01
//	DW_AT_inline:
	.byte 0x01
//	DW_TAG_subprogram:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0x38
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
	.8byte ..LNget_wall_time.132-..L50
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x3a
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
	.byte 0x47
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
	.8byte ..LNcheck.154-..L60
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x0e
//	DW_AT_decl_line:
	.byte 0x47
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
	.byte 0x49
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x006d7573
//	DW_AT_type:
	.4byte 0x000001a5
//	DW_TAG_lexical_block:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x4d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN134
//	DW_AT_high_pc:
	.8byte ..LN150
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x4d
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
	.byte 0x62
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
	.8byte ..LNresults.164-..L72
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0x62
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
	.byte 0x62
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
	.byte 0x6e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_abstract_origin:
	.4byte 0x000000c7
//	DW_AT_low_pc:
	.8byte ..L80
//	DW_AT_high_pc:
	.8byte ..LNaxpy_stride_esc.213-..L80
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x70
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x18f
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x70
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x19e
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_lexical_block:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x74
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN173
//	DW_AT_high_pc:
	.8byte ..LN194
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x74
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
	.byte 0x79
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN173
//	DW_AT_high_pc:
	.8byte ..LN194
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x79
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
	.byte 0x85
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_abstract_origin:
	.4byte 0x000000ae
//	DW_AT_low_pc:
	.8byte ..L109
//	DW_AT_high_pc:
	.8byte ..LNaxpy_stride_vec.272-..L109
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x87
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x18f
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x87
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x19e
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_lexical_block:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x8b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN225
//	DW_AT_high_pc:
	.8byte ..LN252
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x8b
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
	.byte 0x8d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN225
//	DW_AT_high_pc:
	.8byte ..LN252
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x8d
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
	.byte 0x57
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
	.8byte ..LNinit.290-..L141
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_lexical_block:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x59
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN275
//	DW_AT_high_pc:
	.8byte ..LN281
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x59
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
	.byte 0x16
//	DW_AT_decl_line:
	.byte 0x2c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0079
//	DW_AT_type:
	.4byte 0x00000342
//	DW_AT_location:
	.2byte 0x0309
	.8byte y
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
	.byte 0x16
//	DW_AT_decl_line:
	.byte 0x2d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x007a
//	DW_AT_type:
	.4byte 0x00000360
//	DW_AT_location:
	.2byte 0x0309
	.8byte z
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
	.byte 0x2e
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
	.8byte 0x76697264672f7375
	.8byte 0x65636f645f342f65
	.8byte 0x6172672f6169636e
	.8byte 0x695f676e695f6f64
	.8byte 0x6974616d726f666e
	.8byte 0x69746c754d2f6163
	.8byte 0x64617365636f7270
	.8byte 0x505f332f7365726f
	.8byte 0x7361636974636172
	.8byte 0x6f746365765f312f
	.8byte 0x6e6f6963617a6972
	.8byte 0x332d35692f32702f
	.4byte 0x00303734
	.8byte 0x5f797078612f2e2e
	.8byte 0x632e656469727473
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
	.8byte 0x4943455250442d20
	.8byte 0x2d20303d4e4f4953
	.8byte 0x3230313d4e454c44
	.8byte 0x6c6f726e752d2034
	.8byte 0x662d20532d20306c
	.8byte 0x612d656372756f73
	.8byte 0x7361206f2d206d73
	.8byte 0x2f72656c626d6573
	.8byte 0x7274735f79707861
	.8byte 0x732e6b312e656469
	.8byte 0x76612e656c676e69
	.8byte 0x732e6363692e3278
	.byte 0x00
	.4byte 0x6e69616d
	.byte 0x00
	.8byte 0x7274735f79707861
	.8byte 0x006365765f656469
	.8byte 0x00745f7472617473
	.4byte 0x62756f64
	.2byte 0x656c
	.byte 0x00
	.4byte 0x5f646e65
	.2byte 0x0074
	.8byte 0x7274735f79707861
	.8byte 0x006373655f656469
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
	.8byte ..LN66
	.8byte ..LN103
	.8byte 0x0000000000000000
	.8byte 0x0000000000000000
	.8byte ..LN18
	.8byte ..LN57
	.8byte ..LN64
	.8byte ..LN66
	.8byte 0x0000000000000000
	.8byte 0x0000000000000000
	.8byte ..L3
	.8byte ..LNinit.290
	.8byte 0x0000000000000000
	.8byte 0x0000000000000000
	.section .text
.LNDBG_TXe:
# End
