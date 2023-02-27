	.section .text
.LNDBG_TX:
# mark_description "Intel(R) C Intel(R) 64 Compiler Classic for applications running on Intel(R) 64, Version 2021.8.0 Build 2022";
# mark_description "1119_000000";
# mark_description "-march=core-avx2 -vec-threshold0 -std=c11 -g -O3 -DPRECISION=0 -DLEN=1024 -unroll0 -S -fsource-asm -o assemb";
# mark_description "ler/triad_stride.1k.single.avx2.icc.s";
	.file "triad_stride.c"
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
                                                          #184.1
..LN0:
	.file   1 "../triad_stride.c"
	.loc    1  184  is_stmt 1
        pushq     %rbp                                          #184.1
	.cfi_def_cfa_offset 16
..LN1:
        movq      %rsp, %rbp                                    #184.1
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
..LN2:
        andq      $-128, %rsp                                   #184.1
..LN3:
        pushq     %r12                                          #184.1
..LN4:
        subq      $120, %rsp                                    #184.1
..LN5:
        movl      $3, %edi                                      #184.1
..LN6:
        xorl      %esi, %esi                                    #184.1
..LN7:
        call      __intel_new_feature_proc_init                 #184.1
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
..LN8:
                                # LOE rbx r12 r13 r14 r15
..B1.26:                        # Preds ..B1.1
                                # Execution count [1.00e+00]
..LN9:
        vstmxcsr  (%rsp)                                        #184.1
..LN10:
	.loc    1  185  prologue_end  is_stmt 1

###   printf("                     Time       TPI\n");

        movl      $il0_peep_printf_format_0, %edi               #185.3
..LN11:
	.loc    1  184  is_stmt 1
        orl       $32832, (%rsp)                                #184.1
..LN12:
        vldmxcsr  (%rsp)                                        #184.1
..LN13:
	.loc    1  185  is_stmt 1
        call      puts                                          #185.3
..LN14:
                                # LOE rbx r12 r13 r14 r15
..B1.2:                         # Preds ..B1.26
                                # Execution count [1.00e+00]
..LN15:
	.loc    1  186  is_stmt 1

###   printf("             Loop     ns       ps/el     Checksum\n");

        movl      $il0_peep_printf_format_1, %edi               #186.3
..LN16:
        call      puts                                          #186.3
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
        vmovss    .L_2il0floatpacket.0(%rip), %xmm1             #125.5
..LN28:
        xorl      %edx, %edx                                    #125.5
..LN29:
                                # LOE rbx r12 r13 r14 r15 edx xmm1
..B1.7:                         # Preds ..B1.7 ..B1.6
                                # Execution count [5.12e+03]
..L15:
                # optimization report
                # %s was not vectorized: novector directive used
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN30:
	.loc    1  127  is_stmt 1
        lea       (%rdx,%rdx), %ecx                             #127.14
..LN31:
	.loc    1  125  is_stmt 1
        incl      %edx                                          #125.5
..LN32:
	.loc    1  127  is_stmt 1
        vmovss    c(,%rcx,4), %xmm0                             #127.28
..LN33:
        vfmadd213ss b(,%rcx,4), %xmm1, %xmm0                    #127.7
..LN34:
        vmovss    %xmm0, a(,%rcx,4)                             #127.7
..LN35:
	.loc    1  125  is_stmt 1
        cmpl      $1024, %edx                                   #125.5
..LN36:
        jb        ..B1.7        # Prob 99%                      #125.5
..LN37:
                                # LOE rbx r12 r13 r14 r15 edx xmm1
..B1.8:                         # Preds ..B1.7
                                # Execution count [5.00e+00]
..LN38:
	.loc    1  129  is_stmt 1
        vmovss    .L_2il0floatpacket.0(%rip), %xmm0             #129.5
..LN39:
        movl      $a, %edi                                      #129.5
..LN40:
        movl      $b, %esi                                      #129.5
..LN41:
        movl      $c, %edx                                      #129.5
..___tag_value_main.16:
..LN42:
#       dummy(float *, float *, float *, float)
        call      dummy                                         #129.5
..___tag_value_main.17:
..LN43:
                                # LOE rbx r12 r13 r14 r15
..B1.9:                         # Preds ..B1.8
                                # Execution count [5.00e+00]
..LN44:
	.loc    1  120  is_stmt 1
        incl      %r12d                                         #120.3
..LN45:
        cmpq      $15728640, %r12                               #120.3
..LN46:
        jb        ..B1.6        # Prob 82%                      #120.3
..LN47:
                                # LOE rbx r12 r13 r14 r15
..B1.10:                        # Preds ..B1.9
                                # Execution count [1.00e+00]
..___tag_value_main.18:
..LN48:
	.loc    1  131  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #131.11
..___tag_value_main.19:
..LN49:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.11:                        # Preds ..B1.10
                                # Execution count [1.00e+00]
..LN50:
	.loc    1  132  is_stmt 1
        movl      $.L_2__STRING.2, %edi                         #132.3
..LN51:
        vsubsd    (%rsp), %xmm0, %xmm0                          #132.3[spill]
..___tag_value_main.20:
..LN52:
#       results(const double, const char *)
        call      results                                       #132.3
..___tag_value_main.21:
..LN53:
                                # LOE rbx r12 r13 r14 r15
..B1.12:                        # Preds ..B1.11
                                # Execution count [1.00e+00]
..LN54:
	.loc    1  133  is_stmt 1
        movl      $a, %edi                                      #133.3
..___tag_value_main.23:
..LN55:
#       check(float *)
        call      check                                         #133.3
..___tag_value_main.24:
..LN56:
                                # LOE rbx r12 r13 r14 r15
..B1.13:                        # Preds ..B1.12
                                # Execution count [1.00e+00]
..___tag_value_main.25:
..LN57:
	.loc    1  141  is_stmt 1
#       init()
        call      init                                          #141.3
..___tag_value_main.26:
..LN58:
                                # LOE rbx r12 r13 r14 r15
..B1.14:                        # Preds ..B1.13
                                # Execution count [1.00e+00]
..___tag_value_main.27:
..LN59:
	.loc    1  142  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #142.13
..___tag_value_main.28:
..LN60:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.29:                        # Preds ..B1.14
                                # Execution count [1.00e+00]
..LN61:
        vmovsd    %xmm0, (%rsp)                                 #142.13[spill]
..LN62:
                                # LOE rbx r12 r13 r14 r15
..B1.15:                        # Preds ..B1.29
                                # Execution count [9.00e-01]
..LN63:
	.loc    1  143  is_stmt 1
        xorl      %eax, %eax                                    #143.3
..LN64:
	.loc    1  127  is_stmt 1
        movq      %rax, %r12                                    #127.21
..LN65:
                                # LOE rbx r12 r13 r14 r15
..B1.16:                        # Preds ..B1.19 ..B1.15
                                # Execution count [5.00e+00]
..L30:
                # optimization report
                # LOOP WITH UNSIGNED INDUCTION VARIABLE
                # %s was not vectorized: inner loop was already vectorized
..LN66:
	.loc    1  143  is_stmt 1
..LN67:
	.loc    1  145  is_stmt 1
        vmovups   .L_2il0floatpacket.1(%rip), %xmm6             #145.5
..LN68:
        xorl      %edx, %edx                                    #145.5
        .align    16,0x90
..LN69:
                                # LOE rbx r12 r13 r14 r15 edx xmm6
..B1.17:                        # Preds ..B1.17 ..B1.16
                                # Execution count [5.12e+03]
..L31:
                # optimization report
                # LOOP WAS VECTORIZED
                # VECTORIZATION SPEEDUP COEFFECIENT 0.941406
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
                # VECTOR LENGTH 2
                # MAIN VECTOR TYPE: 32-bits floating point
                # COST MODEL DECISION WAS IGNORED
..LN70:
	.loc    1  147  is_stmt 1
        lea       (%rdx,%rdx), %ecx                             #147.14
..LN71:
	.loc    1  145  is_stmt 1
        addl      $2, %edx                                      #145.5
..LN72:
	.loc    1  147  is_stmt 1
        vmovss    8+b(,%rcx,4), %xmm1                           #147.14
..LN73:
	.loc    1  145  is_stmt 1
        cmpl      $1024, %edx                                   #145.5
..LN74:
	.loc    1  147  is_stmt 1
        vmovss    b(,%rcx,4), %xmm0                             #147.14
..LN75:
        vmovss    8+c(,%rcx,4), %xmm3                           #147.28
..LN76:
        vmovss    c(,%rcx,4), %xmm2                             #147.28
..LN77:
        vunpcklps %xmm1, %xmm0, %xmm5                           #147.14
..LN78:
        vunpcklps %xmm3, %xmm2, %xmm4                           #147.28
..LN79:
        vfmadd231ps %xmm6, %xmm4, %xmm5                         #147.28
..LN80:
        vmovss    %xmm5, a(,%rcx,4)                             #147.7
..LN81:
        vextractps $1, %xmm5, 8+a(,%rcx,4)                      #147.7
..LN82:
	.loc    1  145  is_stmt 1
        jb        ..B1.17       # Prob 99%                      #145.5
..LN83:
                                # LOE rbx r12 r13 r14 r15 edx xmm6
..B1.18:                        # Preds ..B1.17
                                # Execution count [5.00e+00]
..LN84:
	.loc    1  149  is_stmt 1
        vmovss    .L_2il0floatpacket.0(%rip), %xmm0             #149.5
..LN85:
        movl      $a, %edi                                      #149.5
..LN86:
        movl      $b, %esi                                      #149.5
..LN87:
        movl      $c, %edx                                      #149.5
..___tag_value_main.32:
..LN88:
#       dummy(float *, float *, float *, float)
        call      dummy                                         #149.5
..___tag_value_main.33:
..LN89:
                                # LOE rbx r12 r13 r14 r15
..B1.19:                        # Preds ..B1.18
                                # Execution count [5.00e+00]
..LN90:
	.loc    1  143  is_stmt 1
        incl      %r12d                                         #143.3
..LN91:
        cmpq      $15728640, %r12                               #143.3
..LN92:
        jb        ..B1.16       # Prob 82%                      #143.3
..LN93:
                                # LOE rbx r12 r13 r14 r15
..B1.20:                        # Preds ..B1.19
                                # Execution count [1.00e+00]
..___tag_value_main.34:
..LN94:
	.loc    1  151  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #151.11
..___tag_value_main.35:
..LN95:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.21:                        # Preds ..B1.20
                                # Execution count [1.00e+00]
..LN96:
	.loc    1  152  is_stmt 1
        movl      $.L_2__STRING.3, %edi                         #152.3
..LN97:
        vsubsd    (%rsp), %xmm0, %xmm0                          #152.3[spill]
..___tag_value_main.36:
..LN98:
#       results(const double, const char *)
        call      results                                       #152.3
..___tag_value_main.37:
..LN99:
                                # LOE rbx r12 r13 r14 r15
..B1.22:                        # Preds ..B1.21
                                # Execution count [1.00e+00]
..LN100:
	.loc    1  153  is_stmt 1
        movl      $a, %edi                                      #153.3
..___tag_value_main.39:
..LN101:
#       check(float *)
        call      check                                         #153.3
..___tag_value_main.40:
..LN102:
                                # LOE rbx r12 r13 r14 r15
..B1.23:                        # Preds ..B1.22
                                # Execution count [1.00e+00]
..LN103:
	.loc    1  190  is_stmt 1

###   triad_stride_esc();
###   triad_stride_vec();
###   //triad_stride_v2(a,b,c);
###   return 0;

        xorl      %eax, %eax                                    #190.10
..LN104:
	.loc    1  190  epilogue_begin  is_stmt 1
        addq      $120, %rsp                                    #190.10
	.cfi_restore 12
..LN105:
        popq      %r12                                          #190.10
..LN106:
        movq      %rbp, %rsp                                    #190.10
..LN107:
        popq      %rbp                                          #190.10
	.cfi_def_cfa 7, 8
	.cfi_restore 6
..LN108:
        ret                                                     #190.10
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
                                                         #103.1
..LN155:
	.loc    1  103  is_stmt 1
        movq      %rdi, %rsi                                    #103.1
..LN156:
	.loc    1  104  prologue_end  is_stmt 1

###     printf("%18s  %6.1f    %6.1f     ",

        vdivsd    .L_2il0floatpacket.3(%rip), %xmm0, %xmm2      #104.5
..LN157:
        vdivsd    .L_2il0floatpacket.4(%rip), %xmm0, %xmm1      #104.5
..LN158:
        movl      $.L_2__STRING.1, %edi                         #104.5
..LN159:
        movl      $2, %eax                                      #104.5
..LN160:
        vmovapd   %xmm2, %xmm0                                  #104.5
..LN161:
	.loc    1  104  epilogue_begin  is_stmt 1
#       printf(const char *__restrict__, ...)
        jmp       printf                                        #104.5
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
.L_2__routine_start_triad_stride_esc_4:
# -- Begin  triad_stride_esc
	.text
# mark_begin;
       .align    16,0x90
	.globl triad_stride_esc
# --- triad_stride_esc()
triad_stride_esc:
..B5.1:                         # Preds ..B5.0
                                # Execution count [1.00e+00]

### {

	.cfi_startproc
..___tag_value_triad_stride_esc.79:
..L80:
                                                         #115.1
..LN165:
	.loc    1  115  is_stmt 1
        subq      $24, %rsp                                     #115.1
	.cfi_def_cfa_offset 32

###   double start_t, end_t;
### 
###   init();

..___tag_value_triad_stride_esc.83:
..LN166:
	.loc    1  118  prologue_end  is_stmt 1
#       init()
        call      init                                          #118.3
..___tag_value_triad_stride_esc.84:
..LN167:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.2:                         # Preds ..B5.1
                                # Execution count [1.00e+00]

###   start_t = get_wall_time();

..___tag_value_triad_stride_esc.85:
..LN168:
	.loc    1  119  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #119.13
..___tag_value_triad_stride_esc.86:
..LN169:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B5.14:                        # Preds ..B5.2
                                # Execution count [1.00e+00]
..LN170:
        vmovsd    %xmm0, (%rsp)                                 #119.13[spill]
..LN171:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.3:                         # Preds ..B5.14
                                # Execution count [9.00e-01]
..LN172:
	.loc    1  120  is_stmt 1

###   for (unsigned int nl = 0; nl < NTIMES; nl++)

        xorl      %eax, %eax                                    #120.24

###  {
### #ifdef __INTEL_COMPILER
###   #pragma novector
### #endif
###     for (unsigned int i = 0; i < 2*LEN; i+=2)
###     {
###       a[i] = b[i] + scalar*c[i];

..LN173:
	.loc    1  127  is_stmt 1
        movq      %r12, 8(%rsp)                                 #127.21[spill]
	.cfi_offset 12, -24
..LN174:
        movq      %rax, %r12                                    #127.21
..LN175:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.4:                         # Preds ..B5.7 ..B5.3
                                # Execution count [5.00e+00]
..L90:
                # optimization report
                # LOOP WITH UNSIGNED INDUCTION VARIABLE
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
                # COST MODEL DECISION WAS IGNORED
..LN176:
	.loc    1  120  is_stmt 1
..LN177:
	.loc    1  125  is_stmt 1
        vmovss    .L_2il0floatpacket.0(%rip), %xmm1             #125.41
..LN178:
        xorl      %ecx, %ecx                                    #125.25
..LN179:
        xorl      %edx, %edx                                    #125.41
..LN180:
                                # LOE rcx rbx rbp r12 r13 r14 r15 edx xmm1
..B5.5:                         # Preds ..B5.5 ..B5.4
                                # Execution count [5.12e+03]
..L91:
                # optimization report
                # %s was not vectorized: novector directive used
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN181:
..LN182:
	.loc    1  127  is_stmt 1
        vmovss    c(,%rcx,4), %xmm0                             #127.28
..LN183:
	.loc    1  125  is_stmt 1
        addl      $2, %edx                                      #125.41
..LN184:
	.loc    1  127  is_stmt 1
        vfmadd213ss b(,%rcx,4), %xmm1, %xmm0                    #127.7
..LN185:
        vmovss    %xmm0, a(,%rcx,4)                             #127.7
..LN186:
	.loc    1  125  is_stmt 1
        movl      %edx, %ecx                                    #125.41
..LN187:
        cmpl      $2048, %edx                                   #125.34
..LN188:
        jb        ..B5.5        # Prob 99%                      #125.34
..LN189:
                                # LOE rcx rbx rbp r12 r13 r14 r15 edx xmm1
..B5.6:                         # Preds ..B5.5
                                # Execution count [5.00e+00]
..LN190:
	.loc    1  129  is_stmt 1

###     }
###     dummy(a, b, c, scalar);

        vmovss    .L_2il0floatpacket.0(%rip), %xmm0             #129.5
..LN191:
        movl      $a, %edi                                      #129.5
..LN192:
        movl      $b, %esi                                      #129.5
..LN193:
        movl      $c, %edx                                      #129.5
..___tag_value_triad_stride_esc.92:
..LN194:
#       dummy(float *, float *, float *, float)
        call      dummy                                         #129.5
..___tag_value_triad_stride_esc.93:
..LN195:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.7:                         # Preds ..B5.6
                                # Execution count [5.00e+00]
..LN196:
	.loc    1  120  is_stmt 1
        incl      %r12d                                         #120.42
..LN197:
        cmpq      $15728640, %r12                               #120.34
..LN198:
        jb        ..B5.4        # Prob 82%                      #120.34
..LN199:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.8:                         # Preds ..B5.7
                                # Execution count [1.00e+00]
..LN200:
        movq      8(%rsp), %r12                                 #[spill]
	.cfi_restore 12

###   }
###   end_t = get_wall_time();

..___tag_value_triad_stride_esc.95:
..LN201:
	.loc    1  131  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #131.11
..___tag_value_triad_stride_esc.96:
	.cfi_offset 12, -24
..LN202:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B5.9:                         # Preds ..B5.8
                                # Execution count [1.00e+00]
..LN203:
	.loc    1  132  is_stmt 1

###   results(end_t - start_t, "triad_stride_esc");

        movl      $.L_2__STRING.2, %edi                         #132.3
..LN204:
        vsubsd    (%rsp), %xmm0, %xmm0                          #132.3[spill]
..___tag_value_triad_stride_esc.98:
..LN205:
#       results(const double, const char *)
        call      results                                       #132.3
..___tag_value_triad_stride_esc.99:
..LN206:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.10:                        # Preds ..B5.9
                                # Execution count [1.00e+00]
..LN207:
	.loc    1  133  is_stmt 1

###   check(a);

        movl      $a, %edi                                      #133.3
..___tag_value_triad_stride_esc.101:
..LN208:
#       check(float *)
        call      check                                         #133.3
..___tag_value_triad_stride_esc.102:
..LN209:
                                # LOE rbx rbp r12 r13 r14 r15
..B5.11:                        # Preds ..B5.10
                                # Execution count [1.00e+00]
..LN210:
	.loc    1  134  is_stmt 1

###   return 0;

        xorl      %eax, %eax                                    #134.10
..LN211:
	.loc    1  134  epilogue_begin  is_stmt 1
        addq      $24, %rsp                                     #134.10
	.cfi_def_cfa_offset 8
..LN212:
        ret                                                     #134.10
        .align    16,0x90
..LN213:
                                # LOE
..LN214:
	.cfi_endproc
# mark_end;
	.type	triad_stride_esc,@function
	.size	triad_stride_esc,.-triad_stride_esc
..LNtriad_stride_esc.215:
.LNtriad_stride_esc:
	.data
# -- End  triad_stride_esc
	.text
.L_2__routine_start_triad_stride_vec_5:
# -- Begin  triad_stride_vec
	.text
# mark_begin;
       .align    16,0x90
	.globl triad_stride_vec
# --- triad_stride_vec()
triad_stride_vec:
..B6.1:                         # Preds ..B6.0
                                # Execution count [1.00e+00]

### {

	.cfi_startproc
..___tag_value_triad_stride_vec.108:
..L109:
                                                        #138.1
..LN216:
	.loc    1  138  is_stmt 1
        pushq     %rbp                                          #138.1
	.cfi_def_cfa_offset 16
..LN217:
        movq      %rsp, %rbp                                    #138.1
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
..LN218:
        andq      $-32, %rsp                                    #138.1
..LN219:
        subq      $32, %rsp                                     #138.1

###   double start_t, end_t;
### 
###   init();

..___tag_value_triad_stride_vec.114:
..LN220:
	.loc    1  141  prologue_end  is_stmt 1
#       init()
        call      init                                          #141.3
..___tag_value_triad_stride_vec.115:
..LN221:
                                # LOE rbx r12 r13 r14 r15
..B6.2:                         # Preds ..B6.1
                                # Execution count [1.00e+00]

###   start_t = get_wall_time();

..___tag_value_triad_stride_vec.116:
..LN222:
	.loc    1  142  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #142.13
..___tag_value_triad_stride_vec.117:
..LN223:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B6.14:                        # Preds ..B6.2
                                # Execution count [1.00e+00]
..LN224:
        vmovsd    %xmm0, (%rsp)                                 #142.13[spill]
..LN225:
                                # LOE rbx r12 r13 r14 r15
..B6.3:                         # Preds ..B6.14
                                # Execution count [9.00e-01]
..LN226:
	.loc    1  143  is_stmt 1

###   for (unsigned int nl = 0; nl < NTIMES; nl++)

        xorl      %eax, %eax                                    #143.3

###   {
###     for (unsigned int i = 0; i < 2*LEN; i+=2)
###     {
###       a[i] = b[i] + scalar*c[i];

..LN227:
	.loc    1  147  is_stmt 1
        movq      %r12, 8(%rsp)                                 #147.21[spill]
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
..LN228:
        movq      %rax, %r12                                    #147.21
..LN229:
                                # LOE rbx r12 r13 r14 r15
..B6.4:                         # Preds ..B6.7 ..B6.3
                                # Execution count [5.00e+00]
..L121:
                # optimization report
                # LOOP WITH UNSIGNED INDUCTION VARIABLE
                # %s was not vectorized: inner loop was already vectorized
..LN230:
	.loc    1  143  is_stmt 1
..LN231:
	.loc    1  145  is_stmt 1
        vmovups   .L_2il0floatpacket.1(%rip), %xmm6             #145.5
..LN232:
        xorl      %edx, %edx                                    #145.5
        .align    16,0x90
..LN233:
                                # LOE rbx r12 r13 r14 r15 edx xmm6
..B6.5:                         # Preds ..B6.5 ..B6.4
                                # Execution count [5.12e+03]
..L122:
                # optimization report
                # LOOP WAS VECTORIZED
                # VECTORIZATION SPEEDUP COEFFECIENT 0.941406
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
                # VECTOR LENGTH 2
                # MAIN VECTOR TYPE: 32-bits floating point
                # COST MODEL DECISION WAS IGNORED
..LN234:
	.loc    1  147  is_stmt 1
        lea       (%rdx,%rdx), %ecx                             #147.14
..LN235:
	.loc    1  145  is_stmt 1
        addl      $2, %edx                                      #145.5
..LN236:
	.loc    1  147  is_stmt 1
        vmovss    8+b(,%rcx,4), %xmm1                           #147.14
..LN237:
	.loc    1  145  is_stmt 1
        cmpl      $1024, %edx                                   #145.5
..LN238:
	.loc    1  147  is_stmt 1
        vmovss    b(,%rcx,4), %xmm0                             #147.14
..LN239:
        vmovss    8+c(,%rcx,4), %xmm3                           #147.28
..LN240:
        vmovss    c(,%rcx,4), %xmm2                             #147.28
..LN241:
        vunpcklps %xmm1, %xmm0, %xmm5                           #147.14
..LN242:
        vunpcklps %xmm3, %xmm2, %xmm4                           #147.28
..LN243:
        vfmadd231ps %xmm6, %xmm4, %xmm5                         #147.28
..LN244:
        vmovss    %xmm5, a(,%rcx,4)                             #147.7
..LN245:
        vextractps $1, %xmm5, 8+a(,%rcx,4)                      #147.7
..LN246:
	.loc    1  145  is_stmt 1
        jb        ..B6.5        # Prob 99%                      #145.5
..LN247:
                                # LOE rbx r12 r13 r14 r15 edx xmm6
..B6.6:                         # Preds ..B6.5
                                # Execution count [5.00e+00]
..LN248:
	.loc    1  149  is_stmt 1

###     }
###     dummy(a, b, c, scalar);

        vmovss    .L_2il0floatpacket.0(%rip), %xmm0             #149.5
..LN249:
        movl      $a, %edi                                      #149.5
..LN250:
        movl      $b, %esi                                      #149.5
..LN251:
        movl      $c, %edx                                      #149.5
..___tag_value_triad_stride_vec.123:
..LN252:
#       dummy(float *, float *, float *, float)
        call      dummy                                         #149.5
..___tag_value_triad_stride_vec.124:
..LN253:
                                # LOE rbx r12 r13 r14 r15
..B6.7:                         # Preds ..B6.6
                                # Execution count [5.00e+00]
..LN254:
	.loc    1  143  is_stmt 1
        incl      %r12d                                         #143.3
..LN255:
        cmpq      $15728640, %r12                               #143.3
..LN256:
        jb        ..B6.4        # Prob 82%                      #143.3
..LN257:
                                # LOE rbx r12 r13 r14 r15
..B6.8:                         # Preds ..B6.7
                                # Execution count [1.00e+00]
..LN258:
        movq      8(%rsp), %r12                                 #[spill]
	.cfi_restore 12

###   }
###   end_t = get_wall_time();

..___tag_value_triad_stride_vec.126:
..LN259:
	.loc    1  151  is_stmt 1
#       get_wall_time()
        call      get_wall_time                                 #151.11
..___tag_value_triad_stride_vec.127:
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
..LN260:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B6.9:                         # Preds ..B6.8
                                # Execution count [1.00e+00]
..LN261:
	.loc    1  152  is_stmt 1

###   results(end_t - start_t, "triad_stride_vec");

        movl      $.L_2__STRING.3, %edi                         #152.3
..LN262:
        vsubsd    (%rsp), %xmm0, %xmm0                          #152.3[spill]
..___tag_value_triad_stride_vec.129:
..LN263:
#       results(const double, const char *)
        call      results                                       #152.3
..___tag_value_triad_stride_vec.130:
..LN264:
                                # LOE rbx r12 r13 r14 r15
..B6.10:                        # Preds ..B6.9
                                # Execution count [1.00e+00]
..LN265:
	.loc    1  153  is_stmt 1

###   check(a);

        movl      $a, %edi                                      #153.3
..___tag_value_triad_stride_vec.132:
..LN266:
#       check(float *)
        call      check                                         #153.3
..___tag_value_triad_stride_vec.133:
..LN267:
                                # LOE rbx r12 r13 r14 r15
..B6.11:                        # Preds ..B6.10
                                # Execution count [1.00e+00]
..LN268:
	.loc    1  154  is_stmt 1

###   return 0;

        xorl      %eax, %eax                                    #154.10
..LN269:
	.loc    1  154  epilogue_begin  is_stmt 1
        movq      %rbp, %rsp                                    #154.10
..LN270:
        popq      %rbp                                          #154.10
	.cfi_def_cfa 7, 8
	.cfi_restore 6
..LN271:
        ret                                                     #154.10
        .align    16,0x90
..LN272:
                                # LOE
..LN273:
	.cfi_endproc
# mark_end;
	.type	triad_stride_vec,@function
	.size	triad_stride_vec,.-triad_stride_vec
..LNtriad_stride_vec.274:
.LNtriad_stride_vec:
	.data
# -- End  triad_stride_vec
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
..LN275:
	.loc    1  88  prologue_end  is_stmt 1
..LN276:
	.loc    1  96  is_stmt 1

### #ifdef __INTEL_COMPILER
###   #pragma novector
### #endif
###   for (unsigned int j = 0; j < LEN; j++)
###   {
###     a[j] = 1.0;
###     b[j] = 2.0;
###     c[j] = 0.0;

        xorl      %edx, %edx                                    #96.12
..LN277:
	.loc    1  92  is_stmt 1
        xorl      %edi, %edi                                    #92.23
..LN278:
	.loc    1  94  is_stmt 1
        movl      $1065353216, %esi                             #94.12
..LN279:
	.loc    1  95  is_stmt 1
        movl      $1073741824, %ecx                             #95.12
..LN280:
	.loc    1  92  is_stmt 1
        xorl      %eax, %eax                                    #92.37
..LN281:
                                # LOE rbx rbp rdi r12 r13 r14 r15 eax edx ecx esi
..B7.2:                         # Preds ..B7.2 ..B7.1
                                # Execution count [1.02e+03]
..L143:
                # optimization report
                # %s was not vectorized: novector directive used
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN282:
..LN283:
        incl      %eax                                          #92.37
..LN284:
	.loc    1  94  is_stmt 1
        movl      %esi, a(,%rdi,4)                              #94.5
..LN285:
	.loc    1  95  is_stmt 1
        movl      %ecx, b(,%rdi,4)                              #95.5
..LN286:
	.loc    1  96  is_stmt 1
        movl      %edx, c(,%rdi,4)                              #96.5
..LN287:
	.loc    1  92  is_stmt 1
        movl      %eax, %edi                                    #92.37
..LN288:
        cmpl      $1024, %eax                                   #92.32
..LN289:
        jb        ..B7.2        # Prob 99%                      #92.32
..LN290:
                                # LOE rbx rbp rdi r12 r13 r14 r15 eax edx ecx esi
..B7.3:                         # Preds ..B7.2
                                # Execution count [1.00e+00]
..LN291:
	.loc    1  98  is_stmt 1

###   }
###   return 0;

        xorl      %eax, %eax                                    #98.10
..LN292:
	.loc    1  98  epilogue_begin  is_stmt 1
        ret                                                     #98.10
        .align    16,0x90
..LN293:
                                # LOE
..LN294:
	.cfi_endproc
# mark_end;
	.type	init,@function
	.size	init,.-init
..LNinit.295:
.LNinit:
	.data
# -- End  init
	.bss
	.align 64
	.align 64
c:
	.type	c,@object
	.size	c,8192
	.space 8192	# pad
	.space 512	# pad
	.align 64
b:
	.type	b,@object
	.size	b,8192
	.space 8192	# pad
	.space 512	# pad
	.align 64
a:
	.type	a,@object
	.size	a,8192
	.space 8192	# pad
	.section .rodata, "a"
	.align 16
	.align 16
.L_2il0floatpacket.1:
	.long	0x40400000,0x40400000,0x40400000,0x40400000
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
	.long	0x40400000
	.type	.L_2il0floatpacket.0,@object
	.size	.L_2il0floatpacket.0,4
	.align 4
.L_2il0floatpacket.5:
	.long	0x40000000
	.type	.L_2il0floatpacket.5,@object
	.size	.L_2il0floatpacket.5,4
	.align 4
.L_2il0floatpacket.6:
	.long	0x3f800000
	.type	.L_2il0floatpacket.6,@object
	.size	.L_2il0floatpacket.6,4
	.section .rodata.str1.4, "aMS",@progbits,1
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.2:
	.long	1634300532
	.long	1953718116
	.long	1701079410
	.long	1668506975
	.byte	0
	.type	.L_2__STRING.2,@object
	.size	.L_2__STRING.2,17
	.space 3, 0x00 	# pad
	.align 4
.L_2__STRING.3:
	.long	1634300532
	.long	1953718116
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
	.long	-2088257344
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
	.long	-1195343742
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
	.4byte 0x00000375
	.2byte 0x0004
	.4byte .debug_abbrev_seg
	.byte 0x08
//	DW_TAG_compile_unit:
	.byte 0x01
//	DW_AT_comp_dir:
	.4byte .debug_str
//	DW_AT_name:
	.4byte .debug_str+0x1e
//	DW_AT_producer:
	.4byte .debug_str+0x30
	.4byte .debug_str+0xa9
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
	.byte 0xb7
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000002f
//	DW_AT_name:
	.4byte .debug_str+0x13b
	.4byte .debug_str+0x13b
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
	.byte 0xbc
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
	.4byte .debug_str+0x151
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x8b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x160
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
	.byte 0xbb
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
	.4byte .debug_str+0x151
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x74
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x160
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
	.4byte .debug_str+0x140
	.4byte .debug_str+0x140
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
	.4byte .debug_str+0x159
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
	.4byte .debug_str+0x166
	.4byte .debug_str+0x166
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
	.4byte .debug_str+0x177
	.4byte .debug_str+0x177
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
	.4byte .debug_str+0x180
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
	.4byte .debug_str+0x185
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
	.4byte .debug_str+0x18d
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
	.4byte .debug_str+0x1a2
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
	.4byte .debug_str+0x194
//	DW_AT_type:
	.4byte 0x0000013b
//	DW_TAG_base_type:
	.byte 0x07
//	DW_AT_byte_size:
	.byte 0x08
//	DW_AT_encoding:
	.byte 0x05
//	DW_AT_name:
	.4byte .debug_str+0x19d
//	DW_TAG_typedef:
	.byte 0x0c
//	DW_AT_decl_line:
	.byte 0x96
//	DW_AT_decl_file:
	.byte 0x03
//	DW_AT_name:
	.4byte .debug_str+0x1aa
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
	.4byte .debug_str+0x1b8
	.4byte .debug_str+0x1b8
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
	.4byte .debug_str+0x1be
//	DW_TAG_base_type:
	.byte 0x07
//	DW_AT_byte_size:
	.byte 0x04
//	DW_AT_encoding:
	.byte 0x07
//	DW_AT_name:
	.4byte .debug_str+0x1c4
//	DW_TAG_subprogram:
	.byte 0x0d
//	DW_AT_decl_line:
	.byte 0x66
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x1d1
	.4byte .debug_str+0x1d1
//	DW_AT_low_pc:
	.8byte ..L72
//	DW_AT_high_pc:
	.8byte ..LNresults.164-..L72
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
	.4byte .debug_str+0x17b
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
	.4byte .debug_str+0x1de
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
	.4byte .debug_str+0x1d9
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
	.8byte ..LNtriad_stride_esc.215-..L80
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x74
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x151
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x74
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x160
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_lexical_block:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x78
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN172
//	DW_AT_high_pc:
	.8byte ..LN201
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
	.8byte ..LN173
//	DW_AT_high_pc:
	.8byte ..LN196
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
	.8byte ..LNtriad_stride_vec.274-..L109
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x8b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x151
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x8b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x160
//	DW_AT_type:
	.4byte 0x000000c0
//	DW_TAG_lexical_block:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x8f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN227
//	DW_AT_high_pc:
	.8byte ..LN254
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
	.8byte ..LN227
//	DW_AT_high_pc:
	.8byte ..LN254
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
	.byte 0x57
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000002f
//	DW_AT_name:
	.4byte .debug_str+0x1e3
	.4byte .debug_str+0x1e3
//	DW_AT_low_pc:
	.8byte ..L141
//	DW_AT_high_pc:
	.8byte ..LNinit.295-..L141
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_lexical_block:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x5c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN276
//	DW_AT_high_pc:
	.8byte ..LN291
//	DW_TAG_variable:
	.byte 0x0f
//	DW_AT_decl_line:
	.byte 0x5c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x006a
//	DW_AT_type:
	.4byte 0x000001ac
	.byte 0x00
	.byte 0x00
//	DW_TAG_variable:
	.byte 0x16
//	DW_AT_decl_line:
	.byte 0x2a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0061
//	DW_AT_type:
	.4byte 0x00000324
//	DW_AT_location:
	.2byte 0x0309
	.8byte a
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
	.byte 0x2b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0062
//	DW_AT_type:
	.4byte 0x00000342
//	DW_AT_location:
	.2byte 0x0309
	.8byte b
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
	.2byte 0x0063
//	DW_AT_type:
	.4byte 0x00000360
//	DW_AT_location:
	.2byte 0x0309
	.8byte c
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
	.4byte .debug_str+0x1e8
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
	.8byte 0x706d2f3434323638
	.8byte 0x636f72502f32702f
	.4byte 0x6f737365
	.2byte 0x0072
	.8byte 0x64616972742f2e2e
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
	.8byte 0x2e382e3132303220
	.8byte 0x20646c6975422030
	.8byte 0x3931313132323032
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
	.8byte 0x74735f6461697274
	.8byte 0x2e6b312e65646972
	.8byte 0x612e656c676e6973
	.8byte 0x2e6363692e327876
	.2byte 0x0073
	.4byte 0x6e69616d
	.byte 0x00
	.8byte 0x74735f6461697274
	.8byte 0x6365765f65646972
	.byte 0x00
	.8byte 0x00745f7472617473
	.4byte 0x62756f64
	.2byte 0x656c
	.byte 0x00
	.4byte 0x5f646e65
	.2byte 0x0074
	.8byte 0x74735f6461697274
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
	.4byte 0x6c616373
	.2byte 0x7261
	.byte 0x00
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
	.8byte ..LNinit.295
	.8byte 0x0000000000000000
	.8byte 0x0000000000000000
	.section .text
.LNDBG_TXe:
# End
