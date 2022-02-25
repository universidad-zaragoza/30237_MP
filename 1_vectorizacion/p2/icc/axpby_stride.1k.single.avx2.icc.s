	.section .text
.LNDBG_TX:
# mark_description "Intel(R) C Intel(R) 64 Compiler Classic for applications running on Intel(R) 64, Version 2021.5.0 Build 2021";
# mark_description "1109_000000";
# mark_description "-march=core-avx2 -vec-threshold0 -std=c11 -g -O3 -DPRECISION=0 -DLEN=1024 -unroll0 -S -fsource-asm -o assemb";
# mark_description "ler/axpby_stride.1k.single.avx2.icc.s";
	.file "axpby_stride.c"
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
                                                          #183.1
..LN0:
	.file   1 "../axpby_stride.c"
	.loc    1  183  is_stmt 1
        pushq     %rbp                                          #183.1
	.cfi_def_cfa_offset 16
..LN1:
        movq      %rsp, %rbp                                    #183.1
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
..LN2:
        andq      $-128, %rsp                                   #183.1
..LN3:
        pushq     %r12                                          #183.1
..LN4:
        subq      $120, %rsp                                    #183.1
..LN5:
        movl      $3, %edi                                      #183.1
..LN6:
        xorl      %esi, %esi                                    #183.1
..LN7:
        call      __intel_new_feature_proc_init                 #183.1
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
..LN8:
                                # LOE rbx r12 r13 r14 r15
..B1.26:                        # Preds ..B1.1
                                # Execution count [1.00e+00]
..LN9:
        vstmxcsr  (%rsp)                                        #183.1
..LN10:
	.loc    1  184  prologue_end  is_stmt 1

###   printf("                     Time       TPI\n");

        movl      $il0_peep_printf_format_0, %edi               #184.3
..LN11:
	.loc    1  183  is_stmt 1
        orl       $32832, (%rsp)                                #183.1
..LN12:
        vldmxcsr  (%rsp)                                        #183.1
..LN13:
	.loc    1  184  is_stmt 1
        call      puts                                          #184.3
..LN14:
                                # LOE rbx r12 r13 r14 r15
..B1.2:                         # Preds ..B1.26
                                # Execution count [1.00e+00]
..LN15:
	.loc    1  185  is_stmt 1

###   printf("             Loop     ns       ps/el     Checksum\n");

        movl      $il0_peep_printf_format_1, %edi               #185.3
..LN16:
        call      puts                                          #185.3
..LN17:
                                # LOE rbx r12 r13 r14 r15
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
..___tag_value_main.9:
..LN18:
	.loc    1  118  is_stmt 1
#       init()
        call      init                                          #118.3
..___tag_value_main.10:
..LN19:
                                # LOE rbx r12 r13 r14 r15
..B1.4:                         # Preds ..B1.3
                                # Execution count [1.00e+00]
..___tag_value_main.11:
..LN20:
	.loc    1  119  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #119.13
..___tag_value_main.12:
..LN21:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.27:                        # Preds ..B1.4
                                # Execution count [1.00e+00]
..LN22:
        vmovsd    %xmm0, (%rsp)                                 #119.13[spill]
..LN23:
                                # LOE rbx r12 r13 r14 r15
..B1.5:                         # Preds ..B1.27
                                # Execution count [9.00e-01]
..LN24:
	.loc    1  120  is_stmt 1
        xorl      %eax, %eax                                    #120.3
..LN25:
        movq      %rax, %r12                                    #120.3
..LN26:
                                # LOE rbx r12 r13 r14 r15
..B1.6:                         # Preds ..B1.9 ..B1.5
                                # Execution count [5.00e+00]
..L14:
                # optimization report
                # LOOP WITH UNSIGNED INDUCTION VARIABLE
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
                # COST MODEL DECISION WAS IGNORED
..LN27:
	.loc    1  125  is_stmt 1
        vmovss    .L_2il0floatpacket.1(%rip), %xmm1             #125.5
..LN28:
        xorl      %edx, %edx                                    #125.5
..LN29:
        vmovss    .L_2il0floatpacket.0(%rip), %xmm2             #125.5
..LN30:
                                # LOE rbx r12 r13 r14 r15 edx xmm1 xmm2
..B1.7:                         # Preds ..B1.7 ..B1.6
                                # Execution count [5.12e+03]
..L15:
                # optimization report
                # %s was not vectorized: novector directive used
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN31:
	.loc    1  127  is_stmt 1
        lea       (%rdx,%rdx), %ecx                             #127.20
..LN32:
	.loc    1  125  is_stmt 1
        incl      %edx                                          #125.5
..LN33:
	.loc    1  127  is_stmt 1
        vmulss    y(,%rcx,4), %xmm1, %xmm0                      #127.32
..LN34:
        vfmadd231ss x(,%rcx,4), %xmm2, %xmm0                    #127.7
..LN35:
        vmovss    %xmm0, y(,%rcx,4)                             #127.7
..LN36:
	.loc    1  125  is_stmt 1
        cmpl      $1024, %edx                                   #125.5
..LN37:
        jb        ..B1.7        # Prob 99%                      #125.5
..LN38:
                                # LOE rbx r12 r13 r14 r15 edx xmm1 xmm2
..B1.8:                         # Preds ..B1.7
                                # Execution count [5.00e+00]
..LN39:
	.loc    1  129  is_stmt 1
        vmovss    .L_2il0floatpacket.0(%rip), %xmm0             #129.5
..LN40:
        movl      $x, %edi                                      #129.5
..LN41:
        vmovss    .L_2il0floatpacket.1(%rip), %xmm1             #129.5
..LN42:
        movl      $y, %esi                                      #129.5
..LN43:
        movl      $z, %edx                                      #129.5
..___tag_value_main.16:
..LN44:
#       dummy(float *, float *, float *, float, float)
        call      dummy                                         #129.5
..___tag_value_main.17:
..LN45:
                                # LOE rbx r12 r13 r14 r15
..B1.9:                         # Preds ..B1.8
                                # Execution count [5.00e+00]
..LN46:
	.loc    1  120  is_stmt 1
        incl      %r12d                                         #120.3
..LN47:
        cmpq      $15728640, %r12                               #120.3
..LN48:
        jb        ..B1.6        # Prob 82%                      #120.3
..LN49:
                                # LOE rbx r12 r13 r14 r15
..B1.10:                        # Preds ..B1.9
                                # Execution count [1.00e+00]
..___tag_value_main.18:
..LN50:
	.loc    1  131  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #131.11
..___tag_value_main.19:
..LN51:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.11:                        # Preds ..B1.10
                                # Execution count [1.00e+00]
..LN52:
	.loc    1  132  is_stmt 1
        movl      $.L_2__STRING.2, %edi                         #132.3
..LN53:
        vsubsd    (%rsp), %xmm0, %xmm0                          #132.3[spill]
..___tag_value_main.20:
..LN54:
#       results(const double, const char *)
        call      results                                       #132.3
..___tag_value_main.21:
..LN55:
                                # LOE rbx r12 r13 r14 r15
..B1.12:                        # Preds ..B1.11
                                # Execution count [1.00e+00]
..LN56:
	.loc    1  133  is_stmt 1
        movl      $y, %edi                                      #133.3
..___tag_value_main.23:
..LN57:
#       check(float *)
        call      check                                         #133.3
..___tag_value_main.24:
..LN58:
                                # LOE rbx r12 r13 r14 r15
..B1.13:                        # Preds ..B1.12
                                # Execution count [1.00e+00]
..___tag_value_main.25:
..LN59:
	.loc    1  141  is_stmt 1
#       init()
        call      init                                          #141.3
..___tag_value_main.26:
..LN60:
                                # LOE rbx r12 r13 r14 r15
..B1.14:                        # Preds ..B1.13
                                # Execution count [1.00e+00]
..___tag_value_main.27:
..LN61:
	.loc    1  142  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #142.13
..___tag_value_main.28:
..LN62:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.29:                        # Preds ..B1.14
                                # Execution count [1.00e+00]
..LN63:
        vmovsd    %xmm0, (%rsp)                                 #142.13[spill]
..LN64:
                                # LOE rbx r12 r13 r14 r15
..B1.15:                        # Preds ..B1.29
                                # Execution count [9.00e-01]
..LN65:
	.loc    1  143  is_stmt 1
        xorl      %eax, %eax                                    #143.3
..LN66:
	.loc    1  127  is_stmt 1
        movq      %rax, %r12                                    #127.27
..LN67:
                                # LOE rbx r12 r13 r14 r15
..B1.16:                        # Preds ..B1.19 ..B1.15
                                # Execution count [5.00e+00]
..L30:
                # optimization report
                # LOOP WITH UNSIGNED INDUCTION VARIABLE
                # %s was not vectorized: inner loop was already vectorized
..LN68:
	.loc    1  143  is_stmt 1
..LN69:
	.loc    1  145  is_stmt 1
        vmovups   .L_2il0floatpacket.3(%rip), %xmm7             #145.5
..LN70:
        xorl      %edx, %edx                                    #145.5
..LN71:
        vmovups   .L_2il0floatpacket.2(%rip), %xmm8             #145.5
        .align    16,0x90
..LN72:
                                # LOE rbx r12 r13 r14 r15 edx xmm7 xmm8
..B1.17:                        # Preds ..B1.17 ..B1.16
                                # Execution count [5.12e+03]
..L31:
                # optimization report
                # LOOP WAS VECTORIZED
                # VECTORIZATION SPEEDUP COEFFECIENT 1.111328
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
                # VECTOR LENGTH 2
                # MAIN VECTOR TYPE: 32-bits floating point
                # COST MODEL DECISION WAS IGNORED
..LN73:
	.loc    1  147  is_stmt 1
        lea       (%rdx,%rdx), %ecx                             #147.22
..LN74:
	.loc    1  145  is_stmt 1
        addl      $2, %edx                                      #145.5
..LN75:
	.loc    1  147  is_stmt 1
        vmovss    8+y(,%rcx,4), %xmm3                           #147.34
..LN76:
	.loc    1  145  is_stmt 1
        cmpl      $1024, %edx                                   #145.5
..LN77:
	.loc    1  147  is_stmt 1
        vmovss    y(,%rcx,4), %xmm2                             #147.34
..LN78:
        vunpcklps %xmm3, %xmm2, %xmm4                           #147.34
..LN79:
        vmulps    %xmm4, %xmm7, %xmm6                           #147.34
..LN80:
        vmovss    8+x(,%rcx,4), %xmm1                           #147.22
..LN81:
        vmovss    x(,%rcx,4), %xmm0                             #147.22
..LN82:
        vunpcklps %xmm1, %xmm0, %xmm5                           #147.22
..LN83:
        vfmadd231ps %xmm8, %xmm5, %xmm6                         #147.34
..LN84:
        vmovss    %xmm6, y(,%rcx,4)                             #147.9
..LN85:
        vextractps $1, %xmm6, 8+y(,%rcx,4)                      #147.9
..LN86:
	.loc    1  145  is_stmt 1
        jb        ..B1.17       # Prob 99%                      #145.5
..LN87:
                                # LOE rbx r12 r13 r14 r15 edx xmm7 xmm8
..B1.18:                        # Preds ..B1.17
                                # Execution count [5.00e+00]
..LN88:
	.loc    1  149  is_stmt 1
        vmovss    .L_2il0floatpacket.0(%rip), %xmm0             #149.5
..LN89:
        movl      $x, %edi                                      #149.5
..LN90:
        vmovss    .L_2il0floatpacket.1(%rip), %xmm1             #149.5
..LN91:
        movl      $y, %esi                                      #149.5
..LN92:
        movl      $z, %edx                                      #149.5
..___tag_value_main.32:
..LN93:
#       dummy(float *, float *, float *, float, float)
        call      dummy                                         #149.5
..___tag_value_main.33:
..LN94:
                                # LOE rbx r12 r13 r14 r15
..B1.19:                        # Preds ..B1.18
                                # Execution count [5.00e+00]
..LN95:
	.loc    1  143  is_stmt 1
        incl      %r12d                                         #143.3
..LN96:
        cmpq      $15728640, %r12                               #143.3
..LN97:
        jb        ..B1.16       # Prob 82%                      #143.3
..LN98:
                                # LOE rbx r12 r13 r14 r15
..B1.20:                        # Preds ..B1.19
                                # Execution count [1.00e+00]
..___tag_value_main.34:
..LN99:
	.loc    1  151  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #151.11
..___tag_value_main.35:
..LN100:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.21:                        # Preds ..B1.20
                                # Execution count [1.00e+00]
..LN101:
	.loc    1  152  is_stmt 1
        movl      $.L_2__STRING.3, %edi                         #152.3
..LN102:
        vsubsd    (%rsp), %xmm0, %xmm0                          #152.3[spill]
..___tag_value_main.36:
..LN103:
#       results(const double, const char *)
        call      results                                       #152.3
..___tag_value_main.37:
..LN104:
                                # LOE rbx r12 r13 r14 r15
..B1.22:                        # Preds ..B1.21
                                # Execution count [1.00e+00]
..LN105:
	.loc    1  153  is_stmt 1
        movl      $y, %edi                                      #153.3
..___tag_value_main.39:
..LN106:
#       check(float *)
        call      check                                         #153.3
..___tag_value_main.40:
..LN107:
                                # LOE rbx r12 r13 r14 r15
..B1.23:                        # Preds ..B1.22
                                # Execution count [1.00e+00]
..LN108:
	.loc    1  189  is_stmt 1

###   axpby_stride_esc();
###   axpby_stride_vec();
###   //axpby_stride_v2(x);
###   return 0;

        xorl      %eax, %eax                                    #189.10
..LN109:
	.loc    1  189  epilogue_begin  is_stmt 1
        addq      $120, %rsp                                    #189.10
	.cfi_restore 12
..LN110:
        popq      %r12                                          #189.10
..LN111:
        movq      %rbp, %rsp                                    #189.10
..LN112:
        popq      %rbp                                          #189.10
	.cfi_def_cfa 7, 8
	.cfi_restore 6
..LN113:
        ret                                                     #189.10
        .align    16,0x90
..LN114:
                                # LOE
..LN115:
	.cfi_endproc
# mark_end;
	.type	main,@function
	.size	main,.-main
..LNmain.116:
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
                                                         #58.1
..LN117:
	.loc    1  58  is_stmt 1
        subq      $24, %rsp                                     #58.1
	.cfi_def_cfa_offset 32
..LN118:
	.loc    1  60  prologue_end  is_stmt 1

###     struct timeval time;
###     if (gettimeofday(&time,NULL)) {

        xorl      %esi, %esi                                    #60.9
..LN119:
        lea       (%rsp), %rdi                                  #60.9
..LN120:
#       gettimeofday(struct timeval *__restrict__, __timezone_ptr_t)
        call      gettimeofday                                  #60.9
..LN121:
                                # LOE rbx rbp r12 r13 r14 r15 eax
..B2.2:                         # Preds ..B2.1
                                # Execution count [1.00e+00]
..LN122:
        testl     %eax, %eax                                    #60.9
..LN123:
        jne       ..B2.4        # Prob 0%                       #60.9
..LN124:
                                # LOE rbx rbp r12 r13 r14 r15
..B2.3:                         # Preds ..B2.2
                                # Execution count [9.95e-01]
..LN125:
	.loc    1  63  is_stmt 1

###         exit(-1); // return 0;
###     }
###     return (double)time.tv_sec + (double)time.tv_usec * .000001;

        vxorpd    %xmm0, %xmm0, %xmm0                           #63.42
..LN126:
        vxorpd    %xmm1, %xmm1, %xmm1                           #63.20
..LN127:
        vcvtsi2sdq 8(%rsp), %xmm0, %xmm0                        #63.42
..LN128:
        vcvtsi2sdq (%rsp), %xmm1, %xmm1                         #63.20
..LN129:
        vfmadd132sd .L_2il0floatpacket.4(%rip), %xmm1, %xmm0    #63.57
..LN130:
	.loc    1  63  epilogue_begin  is_stmt 1
        addq      $24, %rsp                                     #63.57
	.cfi_def_cfa_offset 8
..LN131:
        ret                                                     #63.57
	.cfi_def_cfa_offset 32
..LN132:
                                # LOE
..B2.4:                         # Preds ..B2.2
                                # Execution count [5.00e-03]: Infreq
..LN133:
	.loc    1  61  is_stmt 1
        movl      $-1, %edi                                     #61.9
..LN134:
#       exit(int)
        call      exit                                          #61.9
        .align    16,0x90
..LN135:
                                # LOE
..LN136:
	.cfi_endproc
# mark_end;
	.type	get_wall_time,@function
	.size	get_wall_time,.-get_wall_time
..LNget_wall_time.137:
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
                                                         #73.1
..LN138:
	.loc    1  73  is_stmt 1
        pushq     %rsi                                          #73.1
	.cfi_def_cfa_offset 16
..LN139:
	.loc    1  78  prologue_end  is_stmt 1

###   real sum = 0;
### #ifdef __INTEL_COMPILER
###   #pragma novector
### #endif
###   for (unsigned int i = 0; i < LEN; i++)

        xorl      %edx, %edx                                    #78.23
..LN140:
	.loc    1  74  is_stmt 1
        vxorps    %xmm0, %xmm0, %xmm0                           #74.12
..LN141:
	.loc    1  78  is_stmt 1
        xorl      %eax, %eax                                    #78.37
..LN142:
                                # LOE rdx rbx rbp rdi r12 r13 r14 r15 eax xmm0
..B3.2:                         # Preds ..B3.2 ..B3.1
                                # Execution count [1.02e+03]
..L63:
                # optimization report
                # %s was not vectorized: novector directive used
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN143:
..LN144:
        incl      %eax                                          #78.37
..LN145:
	.loc    1  79  is_stmt 1

###     sum += arr[i];

        vaddss    (%rdi,%rdx,4), %xmm0, %xmm0                   #79.5
..LN146:
	.loc    1  78  is_stmt 1
        movl      %eax, %edx                                    #78.37
..LN147:
        cmpl      $1024, %eax                                   #78.32
..LN148:
        jb        ..B3.2        # Prob 99%                      #78.32
..LN149:
                                # LOE rdx rbx rbp rdi r12 r13 r14 r15 eax xmm0
..B3.3:                         # Preds ..B3.2
                                # Execution count [1.00e+00]
..LN150:
	.loc    1  81  is_stmt 1

### 
###   printf("%f \n", sum);

        vcvtss2sd %xmm0, %xmm0, %xmm0                           #81.3
..LN151:
        movl      $.L_2__STRING.0, %edi                         #81.3
..LN152:
        movl      $1, %eax                                      #81.3
..___tag_value_check.64:
..LN153:
#       printf(const char *__restrict__, ...)
        call      printf                                        #81.3
..___tag_value_check.65:
..LN154:
                                # LOE rbx rbp r12 r13 r14 r15
..B3.4:                         # Preds ..B3.3
                                # Execution count [1.00e+00]

### }

..LN155:
	.loc    1  82  epilogue_begin  is_stmt 1
        popq      %rcx                                          #82.1
	.cfi_def_cfa_offset 8
..LN156:
        ret                                                     #82.1
        .align    16,0x90
..LN157:
                                # LOE
..LN158:
	.cfi_endproc
# mark_end;
	.type	check,@function
	.size	check,.-check
..LNcheck.159:
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
                                                         #103.1
..LN160:
	.loc    1  103  is_stmt 1
        movq      %rdi, %rsi                                    #103.1
..LN161:
	.loc    1  104  prologue_end  is_stmt 1

###     printf("%18s  %6.1f    %6.1f     ",

        vdivsd    .L_2il0floatpacket.5(%rip), %xmm0, %xmm2      #104.5
..LN162:
        vdivsd    .L_2il0floatpacket.6(%rip), %xmm0, %xmm1      #104.5
..LN163:
        movl      $.L_2__STRING.1, %edi                         #104.5
..LN164:
        movl      $2, %eax                                      #104.5
..LN165:
        vmovapd   %xmm2, %xmm0                                  #104.5
..LN166:
	.loc    1  104  epilogue_begin  is_stmt 1
#       printf(const char *__restrict__, ...)
        jmp       printf                                        #104.5
        .align    16,0x90
..LN167:
                                # LOE
..LN168:
	.cfi_endproc
# mark_end;
	.type	results,@function
	.size	results,.-results
..LNresults.169:
.LNresults:
	.data
# -- End  results
	.text
.L_2__routine_start_axpby_stride_esc_4:
# -- Begin  axpby_stride_esc
	.text
# mark_begin;
       .align    16,0x90
	.globl axpby_stride_esc
# --- axpby_stride_esc()
axpby_stride_esc:
..B5.1:                         # Preds ..B5.0
                                # Execution count [1.00e+00]

### {

	.cfi_startproc
..___tag_value_axpby_stride_esc.79:
..L80:
                                                         #115.1
..LN170:
	.loc    1  115  is_stmt 1
        subq      $24, %rsp                                     #115.1
	.cfi_def_cfa_offset 32

###   double start_t, end_t;
### 
###   init();

..___tag_value_axpby_stride_esc.83:
..LN171:
	.loc    1  118  prologue_end  is_stmt 1
#       init()
        call      init                                          #118.3
..___tag_value_axpby_stride_esc.84:
..LN172:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.2:                         # Preds ..B5.1
                                # Execution count [1.00e+00]

###   start_t = get_wall_time();

..___tag_value_axpby_stride_esc.85:
..LN173:
	.loc    1  119  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #119.13
..___tag_value_axpby_stride_esc.86:
..LN174:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B5.14:                        # Preds ..B5.2
                                # Execution count [1.00e+00]
..LN175:
        vmovsd    %xmm0, (%rsp)                                 #119.13[spill]
..LN176:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.3:                         # Preds ..B5.14
                                # Execution count [9.00e-01]
..LN177:
	.loc    1  120  is_stmt 1

###   for (unsigned int nl = 0; nl < NTIMES; nl++)

        xorl      %eax, %eax                                    #120.24

###  {
### #ifdef __INTEL_COMPILER
###   #pragma novector
### #endif
###     for (unsigned int i = 0; i < 2*LEN; i+=2)
###     {
###       y[i] = alpha*x[i] + beta*y[i];

..LN178:
	.loc    1  127  is_stmt 1
        movq      %r12, 8(%rsp)                                 #127.27[spill]
	.cfi_offset 12, -24
..LN179:
        movq      %rax, %r12                                    #127.27
..LN180:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.4:                         # Preds ..B5.7 ..B5.3
                                # Execution count [5.00e+00]
..L90:
                # optimization report
                # LOOP WITH UNSIGNED INDUCTION VARIABLE
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
                # COST MODEL DECISION WAS IGNORED
..LN181:
	.loc    1  120  is_stmt 1
..LN182:
	.loc    1  125  is_stmt 1
        vmovss    .L_2il0floatpacket.1(%rip), %xmm1             #125.41
..LN183:
        xorl      %ecx, %ecx                                    #125.25
..LN184:
        vmovss    .L_2il0floatpacket.0(%rip), %xmm2             #125.41
..LN185:
        xorl      %edx, %edx                                    #125.41
..LN186:
                                # LOE rcx rbx rbp r12 r13 r14 r15 edx xmm1 xmm2
..B5.5:                         # Preds ..B5.5 ..B5.4
                                # Execution count [5.12e+03]
..L91:
                # optimization report
                # %s was not vectorized: novector directive used
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN187:
..LN188:
	.loc    1  127  is_stmt 1
        vmulss    y(,%rcx,4), %xmm1, %xmm0                      #127.32
..LN189:
	.loc    1  125  is_stmt 1
        addl      $2, %edx                                      #125.41
..LN190:
	.loc    1  127  is_stmt 1
        vfmadd231ss x(,%rcx,4), %xmm2, %xmm0                    #127.7
..LN191:
        vmovss    %xmm0, y(,%rcx,4)                             #127.7
..LN192:
	.loc    1  125  is_stmt 1
        movl      %edx, %ecx                                    #125.41
..LN193:
        cmpl      $2048, %edx                                   #125.34
..LN194:
        jb        ..B5.5        # Prob 99%                      #125.34
..LN195:
                                # LOE rcx rbx rbp r12 r13 r14 r15 edx xmm1 xmm2
..B5.6:                         # Preds ..B5.5
                                # Execution count [5.00e+00]
..LN196:
	.loc    1  129  is_stmt 1

###     }
###     dummy(x, y, z, alpha, beta);

        vmovss    .L_2il0floatpacket.0(%rip), %xmm0             #129.5
..LN197:
        movl      $x, %edi                                      #129.5
..LN198:
        vmovss    .L_2il0floatpacket.1(%rip), %xmm1             #129.5
..LN199:
        movl      $y, %esi                                      #129.5
..LN200:
        movl      $z, %edx                                      #129.5
..___tag_value_axpby_stride_esc.92:
..LN201:
#       dummy(float *, float *, float *, float, float)
        call      dummy                                         #129.5
..___tag_value_axpby_stride_esc.93:
..LN202:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.7:                         # Preds ..B5.6
                                # Execution count [5.00e+00]
..LN203:
	.loc    1  120  is_stmt 1
        incl      %r12d                                         #120.42
..LN204:
        cmpq      $15728640, %r12                               #120.34
..LN205:
        jb        ..B5.4        # Prob 82%                      #120.34
..LN206:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.8:                         # Preds ..B5.7
                                # Execution count [1.00e+00]
..LN207:
        movq      8(%rsp), %r12                                 #[spill]
	.cfi_restore 12

###   }
###   end_t = get_wall_time();

..___tag_value_axpby_stride_esc.95:
..LN208:
	.loc    1  131  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #131.11
..___tag_value_axpby_stride_esc.96:
	.cfi_offset 12, -24
..LN209:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B5.9:                         # Preds ..B5.8
                                # Execution count [1.00e+00]
..LN210:
	.loc    1  132  is_stmt 1

###   results(end_t - start_t, "axpby_stride_esc");

        movl      $.L_2__STRING.2, %edi                         #132.3
..LN211:
        vsubsd    (%rsp), %xmm0, %xmm0                          #132.3[spill]
..___tag_value_axpby_stride_esc.98:
..LN212:
#       results(const double, const char *)
        call      results                                       #132.3
..___tag_value_axpby_stride_esc.99:
..LN213:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.10:                        # Preds ..B5.9
                                # Execution count [1.00e+00]
..LN214:
	.loc    1  133  is_stmt 1

###   check(y);

        movl      $y, %edi                                      #133.3
..___tag_value_axpby_stride_esc.101:
..LN215:
#       check(float *)
        call      check                                         #133.3
..___tag_value_axpby_stride_esc.102:
..LN216:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.11:                        # Preds ..B5.10
                                # Execution count [1.00e+00]
..LN217:
	.loc    1  134  is_stmt 1

###   return 0;

        xorl      %eax, %eax                                    #134.10
..LN218:
	.loc    1  134  epilogue_begin  is_stmt 1
        addq      $24, %rsp                                     #134.10
	.cfi_def_cfa_offset 8
..LN219:
        ret                                                     #134.10
        .align    16,0x90
..LN220:
                                # LOE
..LN221:
	.cfi_endproc
# mark_end;
	.type	axpby_stride_esc,@function
	.size	axpby_stride_esc,.-axpby_stride_esc
..LNaxpby_stride_esc.222:
.LNaxpby_stride_esc:
	.data
# -- End  axpby_stride_esc
	.text
.L_2__routine_start_axpby_stride_vec_5:
# -- Begin  axpby_stride_vec
	.text
# mark_begin;
       .align    16,0x90
	.globl axpby_stride_vec
# --- axpby_stride_vec()
axpby_stride_vec:
..B6.1:                         # Preds ..B6.0
                                # Execution count [1.00e+00]

### {

	.cfi_startproc
..___tag_value_axpby_stride_vec.108:
..L109:
                                                        #138.1
..LN223:
	.loc    1  138  is_stmt 1
        pushq     %rbp                                          #138.1
	.cfi_def_cfa_offset 16
..LN224:
        movq      %rsp, %rbp                                    #138.1
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
..LN225:
        andq      $-32, %rsp                                    #138.1
..LN226:
        subq      $32, %rsp                                     #138.1

###   double start_t, end_t;
### 
###   init();

..___tag_value_axpby_stride_vec.114:
..LN227:
	.loc    1  141  prologue_end  is_stmt 1
#       init()
        call      init                                          #141.3
..___tag_value_axpby_stride_vec.115:
..LN228:
                                # LOE rbx r12 r13 r14 r15
..B6.2:                         # Preds ..B6.1
                                # Execution count [1.00e+00]

###   start_t = get_wall_time();

..___tag_value_axpby_stride_vec.116:
..LN229:
	.loc    1  142  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #142.13
..___tag_value_axpby_stride_vec.117:
..LN230:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B6.14:                        # Preds ..B6.2
                                # Execution count [1.00e+00]
..LN231:
        vmovsd    %xmm0, (%rsp)                                 #142.13[spill]
..LN232:
                                # LOE rbx r12 r13 r14 r15
..B6.3:                         # Preds ..B6.14
                                # Execution count [9.00e-01]
..LN233:
	.loc    1  143  is_stmt 1

###   for (unsigned int nl = 0; nl < NTIMES; nl++)

        xorl      %eax, %eax                                    #143.3

###   {
###     for (unsigned int i = 0; i < 2*LEN; i+=2)
###     {
###         y[i] = alpha*x[i] + beta*y[i];

..LN234:
	.loc    1  147  is_stmt 1
        movq      %r12, 8(%rsp)                                 #147.29[spill]
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
..LN235:
        movq      %rax, %r12                                    #147.29
..LN236:
                                # LOE rbx r12 r13 r14 r15
..B6.4:                         # Preds ..B6.7 ..B6.3
                                # Execution count [5.00e+00]
..L121:
                # optimization report
                # LOOP WITH UNSIGNED INDUCTION VARIABLE
                # %s was not vectorized: inner loop was already vectorized
..LN237:
	.loc    1  143  is_stmt 1
..LN238:
	.loc    1  145  is_stmt 1
        vmovups   .L_2il0floatpacket.3(%rip), %xmm7             #145.5
..LN239:
        xorl      %edx, %edx                                    #145.5
..LN240:
        vmovups   .L_2il0floatpacket.2(%rip), %xmm8             #145.5
        .align    16,0x90
..LN241:
                                # LOE rbx r12 r13 r14 r15 edx xmm7 xmm8
..B6.5:                         # Preds ..B6.5 ..B6.4
                                # Execution count [5.12e+03]
..L122:
                # optimization report
                # LOOP WAS VECTORIZED
                # VECTORIZATION SPEEDUP COEFFECIENT 1.111328
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
                # VECTOR LENGTH 2
                # MAIN VECTOR TYPE: 32-bits floating point
                # COST MODEL DECISION WAS IGNORED
..LN242:
	.loc    1  147  is_stmt 1
        lea       (%rdx,%rdx), %ecx                             #147.22
..LN243:
	.loc    1  145  is_stmt 1
        addl      $2, %edx                                      #145.5
..LN244:
	.loc    1  147  is_stmt 1
        vmovss    8+y(,%rcx,4), %xmm3                           #147.34
..LN245:
	.loc    1  145  is_stmt 1
        cmpl      $1024, %edx                                   #145.5
..LN246:
	.loc    1  147  is_stmt 1
        vmovss    y(,%rcx,4), %xmm2                             #147.34
..LN247:
        vunpcklps %xmm3, %xmm2, %xmm4                           #147.34
..LN248:
        vmulps    %xmm4, %xmm7, %xmm6                           #147.34
..LN249:
        vmovss    8+x(,%rcx,4), %xmm1                           #147.22
..LN250:
        vmovss    x(,%rcx,4), %xmm0                             #147.22
..LN251:
        vunpcklps %xmm1, %xmm0, %xmm5                           #147.22
..LN252:
        vfmadd231ps %xmm8, %xmm5, %xmm6                         #147.34
..LN253:
        vmovss    %xmm6, y(,%rcx,4)                             #147.9
..LN254:
        vextractps $1, %xmm6, 8+y(,%rcx,4)                      #147.9
..LN255:
	.loc    1  145  is_stmt 1
        jb        ..B6.5        # Prob 99%                      #145.5
..LN256:
                                # LOE rbx r12 r13 r14 r15 edx xmm7 xmm8
..B6.6:                         # Preds ..B6.5
                                # Execution count [5.00e+00]
..LN257:
	.loc    1  149  is_stmt 1

###     }
###     dummy(x, y, z, alpha, beta);

        vmovss    .L_2il0floatpacket.0(%rip), %xmm0             #149.5
..LN258:
        movl      $x, %edi                                      #149.5
..LN259:
        vmovss    .L_2il0floatpacket.1(%rip), %xmm1             #149.5
..LN260:
        movl      $y, %esi                                      #149.5
..LN261:
        movl      $z, %edx                                      #149.5
..___tag_value_axpby_stride_vec.123:
..LN262:
#       dummy(float *, float *, float *, float, float)
        call      dummy                                         #149.5
..___tag_value_axpby_stride_vec.124:
..LN263:
                                # LOE rbx r12 r13 r14 r15
..B6.7:                         # Preds ..B6.6
                                # Execution count [5.00e+00]
..LN264:
	.loc    1  143  is_stmt 1
        incl      %r12d                                         #143.3
..LN265:
        cmpq      $15728640, %r12                               #143.3
..LN266:
        jb        ..B6.4        # Prob 82%                      #143.3
..LN267:
                                # LOE rbx r12 r13 r14 r15
..B6.8:                         # Preds ..B6.7
                                # Execution count [1.00e+00]
..LN268:
        movq      8(%rsp), %r12                                 #[spill]
	.cfi_restore 12

###   }
###   end_t = get_wall_time();

..___tag_value_axpby_stride_vec.126:
..LN269:
	.loc    1  151  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #151.11
..___tag_value_axpby_stride_vec.127:
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
..LN270:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B6.9:                         # Preds ..B6.8
                                # Execution count [1.00e+00]
..LN271:
	.loc    1  152  is_stmt 1

###   results(end_t - start_t, "axpby_stride_vec");

        movl      $.L_2__STRING.3, %edi                         #152.3
..LN272:
        vsubsd    (%rsp), %xmm0, %xmm0                          #152.3[spill]
..___tag_value_axpby_stride_vec.129:
..LN273:
#       results(const double, const char *)
        call      results                                       #152.3
..___tag_value_axpby_stride_vec.130:
..LN274:
                                # LOE rbx r12 r13 r14 r15
..B6.10:                        # Preds ..B6.9
                                # Execution count [1.00e+00]
..LN275:
	.loc    1  153  is_stmt 1

###   check(y);

        movl      $y, %edi                                      #153.3
..___tag_value_axpby_stride_vec.132:
..LN276:
#       check(float *)
        call      check                                         #153.3
..___tag_value_axpby_stride_vec.133:
..LN277:
                                # LOE rbx r12 r13 r14 r15
..B6.11:                        # Preds ..B6.10
                                # Execution count [1.00e+00]
..LN278:
	.loc    1  154  is_stmt 1

###   return 0;

        xorl      %eax, %eax                                    #154.10
..LN279:
	.loc    1  154  epilogue_begin  is_stmt 1
        movq      %rbp, %rsp                                    #154.10
..LN280:
        popq      %rbp                                          #154.10
	.cfi_def_cfa 7, 8
	.cfi_restore 6
..LN281:
        ret                                                     #154.10
        .align    16,0x90
..LN282:
                                # LOE
..LN283:
	.cfi_endproc
# mark_end;
	.type	axpby_stride_vec,@function
	.size	axpby_stride_vec,.-axpby_stride_vec
..LNaxpby_stride_vec.284:
.LNaxpby_stride_vec:
	.data
# -- End  axpby_stride_vec
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
                                                        #89.1
..LN285:
	.loc    1  89  prologue_end  is_stmt 1
..LN286:
	.loc    1  93  is_stmt 1

### #ifdef __INTEL_COMPILER
###   #pragma novector
### #endif
###   for (int j = 0; j < LEN; j++)

        xorl      %ecx, %ecx                                    #93.14
..LN287:
	.loc    1  95  is_stmt 1

###   {
###     x[j] = 2.0;

        movl      $1073741824, %edx                             #95.12
..LN288:
	.loc    1  96  is_stmt 1

###     y[j] = 0.5;

        movl      $1056964608, %eax                             #96.12
..LN289:
                                # LOE rcx rbx rbp r12 r13 r14 r15 eax edx
..B7.2:                         # Preds ..B7.2 ..B7.1
                                # Execution count [1.02e+03]
..L143:
                # optimization report
                # %s was not vectorized: novector directive used
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN290:
	.loc    1  93  is_stmt 1
..LN291:
	.loc    1  95  is_stmt 1
        movl      %edx, x(,%rcx,4)                              #95.5
..LN292:
	.loc    1  96  is_stmt 1
        movl      %eax, y(,%rcx,4)                              #96.5
..LN293:
	.loc    1  93  is_stmt 1
        incq      %rcx                                          #93.28
..LN294:
        cmpq      $1024, %rcx                                   #93.23
..LN295:
        jl        ..B7.2        # Prob 99%                      #93.23
..LN296:
                                # LOE rcx rbx rbp r12 r13 r14 r15 eax edx
..B7.3:                         # Preds ..B7.2
                                # Execution count [1.00e+00]
..LN297:
	.loc    1  98  is_stmt 1

###   }
###   return 0;

        xorl      %eax, %eax                                    #98.10
..LN298:
	.loc    1  98  epilogue_begin  is_stmt 1
        ret                                                     #98.10
        .align    16,0x90
..LN299:
                                # LOE
..LN300:
	.cfi_endproc
# mark_end;
	.type	init,@function
	.size	init,.-init
..LNinit.301:
.LNinit:
	.data
# -- End  init
	.bss
	.align 64
	.align 64
y:
	.type	y,@object
	.size	y,8192
	.space 8192	# pad
	.space 512	# pad
	.align 64
x:
	.type	x,@object
	.size	x,8192
	.space 8192	# pad
	.space 512	# pad
	.align 64
z:
	.type	z,@object
	.size	z,8192
	.space 8192	# pad
	.section .rodata, "a"
	.align 16
	.align 16
.L_2il0floatpacket.2:
	.long	0x3ecccccd,0x3ecccccd,0x3ecccccd,0x3ecccccd
	.type	.L_2il0floatpacket.2,@object
	.size	.L_2il0floatpacket.2,16
	.align 16
.L_2il0floatpacket.3:
	.long	0x3f19999a,0x3f19999a,0x3f19999a,0x3f19999a
	.type	.L_2il0floatpacket.3,@object
	.size	.L_2il0floatpacket.3,16
	.align 8
.L_2il0floatpacket.4:
	.long	0xa0b5ed8d,0x3eb0c6f7
	.type	.L_2il0floatpacket.4,@object
	.size	.L_2il0floatpacket.4,8
	.align 8
.L_2il0floatpacket.5:
	.long	0x29a4692c,0x3f901b2b
	.type	.L_2il0floatpacket.5,@object
	.size	.L_2il0floatpacket.5,8
	.align 8
.L_2il0floatpacket.6:
	.long	0xe91b0b70,0x3f907e1f
	.type	.L_2il0floatpacket.6,@object
	.size	.L_2il0floatpacket.6,8
	.align 4
.L_2il0floatpacket.0:
	.long	0x3ecccccd
	.type	.L_2il0floatpacket.0,@object
	.size	.L_2il0floatpacket.0,4
	.align 4
.L_2il0floatpacket.1:
	.long	0x3f19999a
	.type	.L_2il0floatpacket.1,@object
	.size	.L_2il0floatpacket.1,4
	.align 4
.L_2il0floatpacket.7:
	.long	0x40000000
	.type	.L_2il0floatpacket.7,@object
	.size	.L_2il0floatpacket.7,4
	.align 4
.L_2il0floatpacket.8:
	.long	0x3f000000
	.type	.L_2il0floatpacket.8,@object
	.size	.L_2il0floatpacket.8,4
	.section .rodata.str1.4, "aMS",@progbits,1
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.2:
	.long	1651538017
	.long	1953718137
	.long	1701079410
	.long	1668506975
	.byte	0
	.type	.L_2__STRING.2,@object
	.size	.L_2__STRING.2,17
	.space 3, 0x00 	# pad
	.align 4
.L_2__STRING.3:
	.long	1651538017
	.long	1953718137
	.long	1701079410
	.long	1667593823
	.byte	0
	.type	.L_2__STRING.3,@object
	.size	.L_2__STRING.3,17
	.space 3, 0x00 	# pad
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
	.long	177
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
	.long	-2045771008
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
	.long	-2088253552
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
	.long	-946831230
	.long	310412167
	.long	-2139090928
	.long	-2139062144
	.long	-2139062144
	.long	-2139062068
	.byte	1
	.section .note.GNU-stack, ""
// -- Begin DWARF2 SEGMENT .debug_info
	.section .debug_info
.debug_info_seg:
	.align 1
	.4byte 0x00000382
	.2byte 0x0004
	.4byte .debug_abbrev_seg
	.byte 0x08
//	DW_TAG_compile_unit:
	.byte 0x01
//	DW_AT_comp_dir:
	.4byte .debug_str
//	DW_AT_name:
	.4byte .debug_str+0x21
//	DW_AT_producer:
	.4byte .debug_str+0x33
	.4byte .debug_str+0xac
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
	.byte 0xb6
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000002f
//	DW_AT_name:
	.4byte .debug_str+0x13e
	.4byte .debug_str+0x13e
//	DW_AT_low_pc:
	.8byte ..L3
//	DW_AT_high_pc:
	.8byte ..LNmain.116-..L3
	.byte 0x01
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_inlined_subroutine:
	.byte 0x04
//	DW_AT_ranges:
	.4byte .debug_ranges_seg
//	DW_AT_entry_pc:
	.8byte ..LN59
//	DW_AT_abstract_origin:
	.4byte 0x000000ae
//	DW_AT_call_line:
	.byte 0xbb
//	DW_AT_call_column:
	.byte 0x03
//	DW_AT_call_file:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x8b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x154
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x8b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x163
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
	.byte 0xba
//	DW_AT_call_column:
	.byte 0x03
//	DW_AT_call_file:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x74
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x154
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x74
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x163
//	DW_AT_type:
	.4byte 0x000000c0
	.byte 0x00
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x89
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_declaration:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000002f
//	DW_AT_name:
	.4byte .debug_str+0x143
	.4byte .debug_str+0x143
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
	.4byte .debug_str+0x15c
//	DW_TAG_subprogram:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x72
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_declaration:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000002f
//	DW_AT_name:
	.4byte .debug_str+0x169
	.4byte .debug_str+0x169
//	DW_AT_external:
	.byte 0x01
//	DW_AT_inline:
	.byte 0x01
//	DW_TAG_subprogram:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0x39
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_AT_name:
	.4byte .debug_str+0x17a
	.4byte .debug_str+0x17a
//	DW_AT_frame_base:
	.2byte 0x7702
	.byte 0x00
//	DW_AT_low_pc:
	.8byte ..L50
//	DW_AT_high_pc:
	.8byte ..LNget_wall_time.137-..L50
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x3b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x183
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
	.4byte .debug_str+0x188
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
	.4byte .debug_str+0x190
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
	.4byte .debug_str+0x1a5
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
	.4byte .debug_str+0x197
//	DW_AT_type:
	.4byte 0x0000013b
//	DW_TAG_base_type:
	.byte 0x07
//	DW_AT_byte_size:
	.byte 0x08
//	DW_AT_encoding:
	.byte 0x05
//	DW_AT_name:
	.4byte .debug_str+0x1a0
//	DW_TAG_typedef:
	.byte 0x0c
//	DW_AT_decl_line:
	.byte 0x96
//	DW_AT_decl_file:
	.byte 0x03
//	DW_AT_name:
	.4byte .debug_str+0x1ad
//	DW_AT_type:
	.4byte 0x0000013b
//	DW_TAG_subprogram:
	.byte 0x0d
//	DW_AT_decl_line:
	.byte 0x48
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x1bb
	.4byte .debug_str+0x1bb
//	DW_AT_low_pc:
	.8byte ..L60
//	DW_AT_high_pc:
	.8byte ..LNcheck.159-..L60
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x0e
//	DW_AT_decl_line:
	.byte 0x48
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
	.byte 0x4a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x006d7573
//	DW_AT_type:
	.4byte 0x000001a5
//	DW_TAG_lexical_block:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x4e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN139
//	DW_AT_high_pc:
	.8byte ..LN155
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x4e
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
	.4byte .debug_str+0x1c1
//	DW_TAG_base_type:
	.byte 0x07
//	DW_AT_byte_size:
	.byte 0x04
//	DW_AT_encoding:
	.byte 0x07
//	DW_AT_name:
	.4byte .debug_str+0x1c7
//	DW_TAG_subprogram:
	.byte 0x0d
//	DW_AT_decl_line:
	.byte 0x66
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x1d4
	.4byte .debug_str+0x1d4
//	DW_AT_low_pc:
	.8byte ..L72
//	DW_AT_high_pc:
	.8byte ..LNresults.169-..L72
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0x66
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x000001eb
//	DW_AT_name:
	.4byte .debug_str+0x17e
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_formal_parameter:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0x66
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x000001f0
//	DW_AT_name:
	.4byte .debug_str+0x1e1
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
	.4byte .debug_str+0x1dc
//	DW_TAG_subprogram:
	.byte 0x14
//	DW_AT_decl_line:
	.byte 0x72
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_abstract_origin:
	.4byte 0x000000c7
//	DW_AT_low_pc:
	.8byte ..L80
//	DW_AT_high_pc:
	.8byte ..LNaxpby_stride_esc.222-..L80
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x74
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x154
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x74
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x163
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_lexical_block:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x78
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN177
//	DW_AT_high_pc:
	.8byte ..LN208
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x78
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
	.byte 0x7d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN178
//	DW_AT_high_pc:
	.8byte ..LN203
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x7d
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
	.byte 0x89
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_abstract_origin:
	.4byte 0x000000ae
//	DW_AT_low_pc:
	.8byte ..L109
//	DW_AT_high_pc:
	.8byte ..LNaxpby_stride_vec.284-..L109
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x8b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x154
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x8b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x163
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_lexical_block:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x8f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN234
//	DW_AT_high_pc:
	.8byte ..LN264
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x8f
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
	.byte 0x91
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN234
//	DW_AT_high_pc:
	.8byte ..LN264
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x91
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
	.byte 0x58
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000002f
//	DW_AT_name:
	.4byte .debug_str+0x1e6
	.4byte .debug_str+0x1e6
//	DW_AT_low_pc:
	.8byte ..L141
//	DW_AT_high_pc:
	.8byte ..LNinit.301-..L141
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_lexical_block:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x5d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN286
//	DW_AT_high_pc:
	.8byte ..LN297
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x5d
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
	.4byte .debug_str+0x1eb
//	DW_AT_type:
	.4byte 0x000001a5
//	DW_AT_declaration:
	.byte 0x01
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x19
//	DW_AT_decl_line:
	.byte 0x2f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x1f1
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
// -- Begin DWARF2 SEGMENT .debug_str
	.section .debug_str,"MS",@progbits,1
.debug_str_seg:
	.align 1
	.8byte 0x31752f656d6f682f
	.8byte 0x6f642f3233303133
	.8byte 0x6d2f6169636e6563
	.8byte 0x6c6b732f32702f70
	.byte 0x00
	.8byte 0x79627078612f2e2e
	.8byte 0x2e6564697274735f
	.2byte 0x0063
	.8byte 0x2952286c65746e49
	.8byte 0x6c65746e49204320
	.8byte 0x4320343620295228
	.8byte 0x2072656c69706d6f
	.8byte 0x2063697373616c43
	.8byte 0x6c70706120726f66
	.8byte 0x736e6f6974616369
	.8byte 0x676e696e6e757220
	.8byte 0x65746e49206e6f20
	.8byte 0x2c3436202952286c
	.8byte 0x6e6f697372655620
	.8byte 0x2e352e3132303220
	.8byte 0x20646c6975422030
	.8byte 0x3930313131323032
	.8byte 0x0a3030303030305f
	.byte 0x00
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
	.8byte 0x74735f7962707861
	.8byte 0x2e6b312e65646972
	.8byte 0x612e656c676e6973
	.8byte 0x2e6363692e327876
	.2byte 0x0073
	.4byte 0x6e69616d
	.byte 0x00
	.8byte 0x74735f7962707861
	.8byte 0x6365765f65646972
	.byte 0x00
	.8byte 0x00745f7472617473
	.4byte 0x62756f64
	.2byte 0x656c
	.byte 0x00
	.4byte 0x5f646e65
	.2byte 0x0074
	.8byte 0x74735f7962707861
	.8byte 0x6373655f65646972
	.byte 0x00
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
// -- Begin DWARF2 SEGMENT .debug_ranges
	.section .debug_ranges
.debug_ranges_seg:
	.align 1
	.8byte ..LN59
	.8byte ..LN66
	.8byte ..LN68
	.8byte ..LN108
	.8byte 0x0000000000000000
	.8byte 0x0000000000000000
	.8byte ..LN18
	.8byte ..LN59
	.8byte ..LN66
	.8byte ..LN68
	.8byte 0x0000000000000000
	.8byte 0x0000000000000000
	.8byte ..L3
	.8byte ..LNinit.301
	.8byte 0x0000000000000000
	.8byte 0x0000000000000000
	.section .text
.LNDBG_TXe:
# End
