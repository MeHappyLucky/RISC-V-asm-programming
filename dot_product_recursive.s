# #include <stdio.h>

# int a[5] = {1, 2, 3, 4, 5};
# int b[5] = {6, 7, 8, 9, 10};

# int dot_product_recursive(int *a, int *b, int size) {
#     if (size == 1) return a[0]*b[0];
#     return a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1);
# }

# int main() {
#     int result;

#     result = dot_product_recursive(a, b, 5);
#     printf("The dot product is: %d\n", result);
#     return 0;
# }

.data
a: .word 1, 2, 3, 4, 5  # int a[5] = {1, 2, 3, 4, 5};
b: .word 6, 7, 8, 9, 10  # int b[5] = {6, 7, 8, 9, 10};

.text
main:
    # passing arguments to a0, a1, a2
    la a0 a
    la a1 b
    addi a2 x0 5 # size
    jal dot_product
    j exit

dot_product:
    addi sp sp -12
    sw ra 0(sp)
    sw a0 4(sp)
    sw a1 8(sp)

    # If size != 1, recursive begins
    addi t0 x0 1
    bne a2 t0 loop
    
    # other wise base case
    addi sp sp 12
    
    # a[0]*b[0]
    lw t1 0(a0)
    lw t2 0(a1)
    mul a0 t1 t2
    jr ra
    
loop:
    addi a0 a0 4  # a + 1
    addi a1 a1 4  # b + 1
    addi a2 a2 -1  # size - 1
    jal dot_product
    
    lw ra 0(sp) # load ra
    lw t0 4(sp) # load t0 = a
    lw t1 8(sp) # load t1 = b
    
    addi sp sp 12
    
    # a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1)
    lw t3 0(t0)
    lw t4 0(t1)
    mul t5 t3 t4
    add a0 a0 t5
    jr ra
    
exit:
    mv t0 a0
    mv a1 t0
    addi a0 x0 1
    ecall
    addi a0 x0 10
    ecall