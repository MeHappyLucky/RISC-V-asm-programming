# #include <stdio.h>

# int a[5] = {1, 2, 3, 4, 5};
# int b[5] = {6, 7, 8, 9, 10};

# int main() {
#     int i, sop = 0;
    
#     for (i = 0; i < 5; i++) {
#         sop += a[i] * b[i];
#     }
    
#     printf("The dot product is: %d\n", sop);
#     return 0;
# }

.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10

.text
main:
    # Load addresses of a, b into a0, a1
    la s0 a
    la s1 b
    # Initialize necessary loop components
    li t0, 0 # loop counter (i)
    li t1, 5 # loop ending condition (5)
    # Accumulator (sop)
    li t2, 0
    
loop:
    # if t0 (i) is greater than t1 (5), jumps to end
    bge t0, t1, end
    # Load values of a[i] and b[i]
    slli s2 t0 2    # s2 = i * 4
    add s3 s2 s0
    add s4 s2 s1
    lw t3, 0(s3)    # Load a[i] into t3
    lw t4, 0(s4)    # Load b[i] into t4
    # Multiply a[i] and b[i]
    mul t5, t3, t4
    # Accumulate mul products in t2 (sop)
    add t2, t2, t5
    # Increment loop counter
    addi t0, t0, 1
    # repeat loop
    j loop
    
end:
    # Print the result
    add a1, t2, zero   # Move the result to a0 for printing
    li a0, 1    # Print integer system call
    ecall