# Ayschronous_FIFO_Assertion_UVM
## Target
- Learning Asychronous FIFO
- Learning assertion and UVM

## Online IDE
- https://edaplayground.com/x/AkW8

## Assertion List 
1. empty --> !full
2. full  --> !empty
3. !Rresetn --> empty 1
4. !Wresetn --> full  0 
5. empty --> ReadPtr don't change
6. full  --> WritePtr don't change
7. full  --> !write 
8. empty --> !read

## UVM Testbench overview
- Complete create a overview testbench
- Use 2 agent(read/write) to verify asychronous FIFO 
