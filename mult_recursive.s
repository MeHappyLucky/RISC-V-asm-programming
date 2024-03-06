# #include <stdio.h>

# int mult(int a, int b) {
#     if (b == 1) return a;
#     return a + mult(a, b-1);
# }

# int main() {
#     int result;

#     printf("%d\n", mult(110, 50));
#     return 0;
# }

.text
main:
    # pass arguments to a0, a1
    addi a0, x0, 110
    addi a1, x0, 50
    jal mult
    
    # print_int
    mv a1, a0
    addi a0, x0, 1
    ecall

    addi a0, x0, 10
    ecall
    
mult:
    # base case
    # if a1 = t0, exit
    addi t0, x0, 1
    beq a1, t0, exit_base_case
    
    # recursive case
    addi sp, sp, -4
    sw ra, 0(sp)
    
    # mult(a, b-1)
    addi sp, sp, -4
    sw a0, 0(sp)
    addi a1, a1, -1
    jal mult
    
    # a + mult(a, b-1)
    # restore the original a value before the call to mult
    lw t1, 0(sp)
    addi sp, sp, 4
    add a0, a0, t1
    
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra
    
exit_base_case:
    jr ra