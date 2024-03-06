# #include <stdio.h>

# void print_array(int A[], int size) {
#     int i;
#     for (i=0; i<size; i++)
#         printf("%d ", A[i]);
#     printf("\n");

# }

# int A[5] = {11, 22, 33, 44, 55};

# int main() {

#     print_array(A, 5);

#     return 0;
# }

.data
A: .word 11, 22, 33, 44, 55
space: .asciiz " "
newline: .asciiz "\n"

.text
main:

    # passing arguments to a0 and a1
    la a0, A
    addi a1, x0, 5 # size
    jal print_array

    addi a0, x0, 10
    addi a1, x0, 0
    ecall

print_array:
    addi sp, sp, -12
    sw ra, 8(sp)
    sw s1, 4(sp)
    sw s0, 0(sp)
    addi t0, x0, 0
    mv s0, a0
    mv s1, a1
    
loop:
    # loop condition (if i > 5, exit)
    bge t0, s1, loop_exit
    slli t1, t0, 2 # i = i * 4
    add t1, s0, t1 # t1 = &A[0] + i*4
    lw t1, 0(t1) # t1 = A[i]

    # printf("%d ", A[i])
    addi a0, x0, 1
    mv a1, t1
    ecall
    addi a0, x0, 4
    la a1, space
    ecall

    # increment loop variable
    addi t0, t0, 1
    j loop
    
loop_exit:
    addi a0, x0, 4
    la a1, newline
    ecall

    # restore ra and return
    lw ra, 8(sp)
    lw s1, 4(sp)
    lw s0, 0(sp)
    addi sp, sp, 12
    jr ra