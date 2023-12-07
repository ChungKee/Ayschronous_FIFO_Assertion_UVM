# Ayschronous_FIFO_Assertion_UVM
## Target
- Learning Asychronous FIFO
- Learning assertion and UVM

## Online IDE
- https://edaplayground.com/x/AkW8

## Assertion List (due 12/10)
1. empty --> !full
2. full  --> !empty
3. !Rresetn --> empty 1
4. !Wresetn --> full  0 
(Check the other value after reset)
5. empty --> ReadPtr don't change
6. full  --> WritePtr don't change
7. full  --> mem[R] = mem[W] , W == R


## Design (due 12/17)

## UVM Testbench overview (due 12/17)
- maybe use 2 agent(read/write) to verify asychronous FIFO
