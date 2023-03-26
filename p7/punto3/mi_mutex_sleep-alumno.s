
    .global mi_mutex_lock

mi_mutex_lock:
    .cfi_startproc

    ret 
    .cfi_endproc

    .global mi_mutex_unlock
    .align 2
    .type mi_mutex_unlock,%function
mi_mutex_unlock:
    .cfi_startproc
    ret
    .cfi_endproc
