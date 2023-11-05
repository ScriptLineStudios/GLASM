global main
section .text

extern glad_glClear, glad_glClearColor, glad_glGenVertexArrays, glad_glBindVertexArray, glad_glGenBuffers, glad_glBindBuffer, glad_glBufferData
extern glad_glVertexAttribPointer, glad_glEnableVertexAttribArray
extern glad_glCreateShader, glad_glShaderSource, glad_glCompileShader
extern glad_glCreateProgram, glad_glAttachShader, glad_glLinkProgram, glad_glUseProgram
extern glad_glDrawArrays
extern glfwInit, glfwTerminate, glfwCreateWindow, glfwSwapBuffers, glfwPollEvents, glfwWindowShouldClose, gladLoadGLLoader, glfwGetProcAddress, glfwMakeContextCurrent

extern printf

print:
    push rbp
    mov rsp, rbp

    mov rdx, len
    mov rsi, vsrc
    mov rax, 1
    mov rdi, 1
    syscall

    pop rbp
    ret

main:
    push rbp
    
    call glfwInit

    ; //Given the arguments in left-to-right order, the order of registers used is: %rdi, %rsi, %rdx, %rcx, %r8, and %r9
    mov rdi, 800
    mov rsi, 800
    mov rdx, title
    call glfwCreateWindow   
    ; at this point rax is a pointer to some memory representing the window, we need to store that memory at window
    mov [window], rax

    mov rdi, [window]
    call glfwMakeContextCurrent


    ; Load gl pointers using glad
    mov rdi, glfwGetProcAddress
    call gladLoadGLLoader
    
    cmp rax, 0
    jne glgarbage
    call print
    jmp term
    ; Finished with glad

glgarbage:
    mov rdi, string_format
    mov rsi, vsrc
    call printf

    ; VAO and VBO
    mov rdi, 1
    mov rsi, vao
    call [glad_glGenVertexArrays]
    mov rdi, [vao]
    call [glad_glBindVertexArray]
    
    mov rdi, int_format
    mov rsi, [vao]
    call printf
    ; VAO complete

    mov rdi, float_format
    movq xmm0, [vertices + 8*(5)]
    mov rax, 1
    call printf

    ; attrb pointers
    mov rdi, 0
    mov rsi, 2
    mov rdx, 0x140a
    mov rcx, 0
    mov r8, 40
    mov r9, 0
    call [glad_glVertexAttribPointer]

    mov rdi, 0
    call [glad_glEnableVertexAttribArray]

    mov rdi, 1
    mov rsi, 3
    mov rdx, 0x140a
    mov rcx, 0
    mov r8, 40 
    mov r9, 16 ; sizeof(double) * 2
    call [glad_glVertexAttribPointer]

    mov rdi, 1
    call [glad_glEnableVertexAttribArray]
    ; attrib pointers complete

    mov rdi, 1
    mov rsi, vbo
    call [glad_glGenBuffers]
    mov rdi, 34962
    mov rsi, [vbo]
    call [glad_glBindBuffer]
    mov rdi, 34962
    mov rsi, 120
    mov rdx, vertices
    mov rcx, 0x8892
    call [glad_glBufferData]

    ; ------------------------ Its shadering time --------------------------;
    mov rdi, 0x8B31
    call [glad_glCreateShader]
    mov [vshader], rax
    mov rdi, [vshader]
    mov rsi, 1
    mov rdx, pvsrc
    mov rcx, 0
    call [glad_glShaderSource]
    mov rdi, [vshader]
    call [glad_glCompileShader]

    mov rdi, 0x8B30
    call [glad_glCreateShader]
    mov [fshader], rax
    mov rdi, [fshader]
    mov rsi, 1
    mov rdx, pfsrc
    mov rcx, 0
    call [glad_glShaderSource]
    mov rdi, [fshader]
    call [glad_glCompileShader]

    mov rdi, int_format
    mov rsi, [vshader]
    call printf

    mov rdi, int_format
    mov rsi, [fshader]
    call printf

    ; ------------------------- Shaders DONE ---------------------------------;


    ; ------------------------- Shader program ------------------------------;
    call [glad_glCreateProgram]
    mov [program], rax
    mov rdi, [program]
    mov rsi, [vshader]
    call [glad_glAttachShader]
    mov rdi, [program]
    mov rsi, [fshader]
    call [glad_glAttachShader]
    mov rdi, [program]
    call [glad_glLinkProgram]
    mov rdi, [program]
    call [glad_glUseProgram]
    ; ------------------------- Shader program DONE ---------------------------;

    mov rdi, int_format
    mov rsi, [program]
    call printf
    
loop:
    movd xmm0, [zero]
    movd xmm1, [r]
    movd xmm2, [r]
    movd xmm3, [r]
    call [glad_glClearColor]
    
    mov rdi, 16384
    call [glad_glClear]
    
    mov rdi, [vao]
    call [glad_glBindVertexArray]

    mov rdi, [program]
    call [glad_glUseProgram]

    mov rdi, 0x0004
    mov rsi, 0
    mov rdx, 3
    call [glad_glDrawArrays]

    mov rdi, [window]
    call glfwSwapBuffers
    call glfwPollEvents

    mov rdi, [window]
    call glfwWindowShouldClose
    cmp rax, 0
    jz loop

term:
    call glfwTerminate

    pop rbp
    ret    

section .bss
    window: resb 8
    vao: resb 4
    vbo: resb 4
    vshader: resb 4
    fshader: resb 4
    program: resb 4

verts:
    dd 1.0

section .rodata
    int_format: db "%d", 10, 0
    float_format: db "%f", 10, 0
    pointer_format: db "%p", 10, 0
    string_format: db "%s", 10, 0
    title: db "Hello, world!", 0
    error: db "Failed to load gl functions!", 10
    len equ $ - error
    r: dd 0.2
    test: dq 0.2
    zero: dd 0.0
    vertices: dq -0.5, -0.5, 1.0, 0.0, 0.0, 0.0, 0.37, 0.0, 1.0, 0.0, 0.5, -0.5, 0.0, 0.0, 1.0     
    vsrc:
        db 0xa, 0x23, 0x76, 0x65, 0x72, 0x73, 0x69, 0x6f, 0x6e, 0x20, 0x33, 0x33, 0x30, 0x20, 0x63, 0x6f, 0x72, 0x65, 0xa, 0x6c, 0x61, 0x79, 0x6f, 0x75, 0x74, 0x28, 0x6c, 0x6f, 0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x3d, 0x30, 0x29, 0x20, 0x69, 0x6e, 0x20, 0x76, 0x65, 0x63, 0x32, 0x20, 0x61, 0x50, 0x6f, 0x73, 0x3b, 0xa, 0x6c, 0x61, 0x79, 0x6f, 0x75, 0x74, 0x28, 0x6c, 0x6f, 0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x3d, 0x31, 0x29, 0x20, 0x69, 0x6e, 0x20, 0x76, 0x65, 0x63, 0x33, 0x20, 0x61, 0x43, 0x6f, 0x6c, 0x3b, 0xa, 0xa, 0x6f, 0x75, 0x74, 0x20, 0x76, 0x65, 0x63, 0x33, 0x20, 0x63, 0x6f, 0x6c, 0x6f, 0x72, 0x3b, 0xa, 0xa, 0x76, 0x6f, 0x69, 0x64, 0x20, 0x6d, 0x61, 0x69, 0x6e, 0x28, 0x29, 0x20, 0x7b, 0xa, 0x20, 0x20, 0x20, 0x20, 0x67, 0x6c, 0x5f, 0x50, 0x6f, 0x73, 0x69, 0x74, 0x69, 0x6f, 0x6e, 0x20, 0x3d, 0x20, 0x76, 0x65, 0x63, 0x34, 0x28, 0x61, 0x50, 0x6f, 0x73, 0x2e, 0x78, 0x79, 0x2c, 0x20, 0x30, 0x2e, 0x30, 0x2c, 0x20, 0x31, 0x2e, 0x30, 0x29, 0x3b, 0x20, 0xa, 0x20, 0x20, 0x20, 0x20, 0x63, 0x6f, 0x6c, 0x6f, 0x72, 0x20, 0x3d, 0x20, 0x61, 0x43, 0x6f, 0x6c, 0x3b, 0xa, 0x7d, 0xa, 0
    fsrc:
        db 0xa, 0x23, 0x76, 0x65, 0x72, 0x73, 0x69, 0x6f, 0x6e, 0x20, 0x33, 0x33, 0x30, 0x20, 0x63, 0x6f, 0x72, 0x65, 0xa, 0x69, 0x6e, 0x20, 0x76, 0x65, 0x63, 0x33, 0x20, 0x63, 0x6f, 0x6c, 0x6f, 0x72, 0x3b, 0xa, 0xa, 0x76, 0x6f, 0x69, 0x64, 0x20, 0x6d, 0x61, 0x69, 0x6e, 0x28, 0x29, 0x20, 0x7b, 0xa, 0x20, 0x20, 0x20, 0x20, 0x67, 0x6c, 0x5f, 0x46, 0x72, 0x61, 0x67, 0x43, 0x6f, 0x6c, 0x6f, 0x72, 0x20, 0x3d, 0x20, 0x76, 0x65, 0x63, 0x34, 0x28, 0x63, 0x6f, 0x6c, 0x6f, 0x72, 0x2e, 0x78, 0x79, 0x7a, 0x2c, 0x20, 0x31, 0x2e, 0x30, 0x29, 0x3b, 0xa, 0x7d, 0xa, 0
    pvsrc:
        dq vsrc
    pfsrc:
        dq fsrc
