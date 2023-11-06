global main
section .text

extern glad_glClear, glad_glClearColor, glad_glGenVertexArrays, glad_glBindVertexArray, glad_glGenBuffers, glad_glBindBuffer, glad_glBufferData
extern glad_glVertexAttribPointer, glad_glEnableVertexAttribArray
extern glad_glCreateShader, glad_glShaderSource, glad_glCompileShader
extern glad_glCreateProgram, glad_glAttachShader, glad_glLinkProgram, glad_glUseProgram
extern glad_glDrawArrays, glad_glGetShaderiv
extern glfwInit, glfwTerminate, glfwCreateWindow, glfwSwapBuffers, glfwPollEvents, glfwWindowShouldClose, gladLoadGLLoader, glfwGetProcAddress, glfwMakeContextCurrent
extern glad_glGenTextures, glad_glBindTexture, glad_glTexParameteri, glad_glTexImage2D
extern printf, exit
extern glfwGetKey

extern stbi_load, stbi_image_free

%define GL_ARRAY_BUFFER 34962
%define GL_STATIC_DRAW 35044
%define GL_DOUBLE 5130
%define GL_VERTEX_SHADER 35633
%define GL_FRAGMENT_SHADER 35632
%define GL_TEXTURE_2D 0x0DE1
%define GL_RGBA 0x1908
%define GL_UNSIGNED_BYTE 0x1401

create_tex:
    push rbp
    mov rbp, rsp

    mov rdi, 1
    mov rsi, tex
    call [glad_glGenTextures]

    mov rdi, GL_TEXTURE_2D
    mov rsi, [tex]
    call [glad_glBindTexture]

    mov rdi, GL_TEXTURE_2D
    mov rsi, 0x2800
    mov rdx, 0x2600
    call [glad_glTexParameteri]

    mov rdi, GL_TEXTURE_2D
    mov rsi, 0x2801
    mov rdx, 0x2600
    call [glad_glTexParameteri]

    mov rdi, GL_TEXTURE_2D
    mov rsi, 0x2802
    mov rdx, 0x2901
    call [glad_glTexParameteri]

    mov rdi, GL_TEXTURE_2D
    mov rsi, 0x2803
    mov rdx, 0x2901
    call [glad_glTexParameteri]

    mov rdi, GL_TEXTURE_2D
    mov rsi, 0
    mov rdx, GL_RGBA
    mov rcx, 1000
    mov r8, 1000
    mov r9, 0

    sub rsp, 8
    push qword [image] ; 8 bytes
    push GL_UNSIGNED_BYTE ; 4 bytes
    push GL_RGBA ; 4 bytes
    call [glad_glTexImage2D]
    add rsp, 32

    pop rbp
    ret

%define GLFW_KEY_A 65

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
    jmp term
    ; Finished with glad

glgarbage:
    ;%rdi, %rsi, %rdx, %rcx, %r8, and %r9
    mov rdi, 1
    mov rsi, vao
    call [glad_glGenVertexArrays]
    mov rdi, [vao]
    call [glad_glBindVertexArray]

    ; glGenBuffers(1, &vbo);
    mov rdi, 1
    mov rsi, vbo
    call [glad_glGenBuffers]

    ;glBindBuffer(GL_ARRAY_BUFFER, vbo);
    mov rdi, GL_ARRAY_BUFFER
    mov rsi, [vbo]
    call [glad_glBindBuffer]

    ; glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    mov rdi, GL_ARRAY_BUFFER
    mov rsi, 192
    mov rdx, vertices
    mov rcx, GL_STATIC_DRAW
    call [glad_glBufferData]

    ; glVertexAttribPointer(0, 2, GL_DOUBLE, GL_FALSE, sizeof(double) * 5, (void *)0);
    mov rdi, 0
    mov rsi, 2
    mov rdx, GL_DOUBLE
    mov rcx, 0
    mov r8, 32
    mov r9, 0
    call [glad_glVertexAttribPointer]

    ; glEnableVertexAttribArray(0);
    mov rdi, 0
    call [glad_glEnableVertexAttribArray]

    ; glVertexAttribPointer(1, 3, GL_DOUBLE, GL_FALSE, sizeof(double) * 5, (void *)(2 * sizeof(double)));
    mov rdi, 1
    mov rsi, 2
    mov rdx, GL_DOUBLE
    mov rcx, 0
    mov r8, 32
    mov r9, 16
    call [glad_glVertexAttribPointer]

    ; glEnableVertexAttribArray(1);
    mov rdi, 1
    call [glad_glEnableVertexAttribArray]

    ; VERTEX 

    ; vertex_shader = glCreateShader(GL_VERTEX_SHADER);
    mov rdi, GL_VERTEX_SHADER
    call [glad_glCreateShader]
    mov [vshader], rax ; move rax into vshader

    ; glShaderSource(vertex_shader, 1, &vertex_src, NULL);
    mov rdi, [vshader]
    mov rsi, 1
    mov rdx, pvsrc
    mov rcx, 0
    call [glad_glShaderSource]

    ; glCompileShader
    mov rdi, [vshader]
    call [glad_glCompileShader]

    ; FRAGMENT

    ; fragment_shader = glCreateShader(GL_FRAGMENT_SHADER);
    mov rdi, GL_FRAGMENT_SHADER
    call [glad_glCreateShader]
    mov [fshader], rax ; move rax into vshader

    ; glShaderSource(fragment_shader, 1, &fragment_src, NULL);
    mov rdi, [fshader]
    mov rsi, 1
    mov rdx, pfsrc
    mov rcx, 0
    call [glad_glShaderSource]

    ; glCompileShader
    mov rdi, [fshader]
    call [glad_glCompileShader]

    ; program = glCreateProgram();
    call [glad_glCreateProgram]
    mov [program], rax

    ;glAttachShader(program, vertex_shader);
    mov rdi, [program]
    mov rsi, [vshader]
    call [glad_glAttachShader]

    ;glAttachShader(program, fragment_shader);
    mov rdi, [program]
    mov rsi, [fshader]
    call [glad_glAttachShader]

    ; glLinkProgram(program);
    mov rdi, [program]
    call [glad_glLinkProgram]

    ; glUseProgram(program);
    mov rdi, [program]
    call [glad_glUseProgram]

    ; stb image loading
    mov rdi, imgpath
    mov rsi, w
    mov rdx, h
    mov rcx, c
    mov r8, 0
    call stbi_load
    mov [image], rax

    mov rdi, pf
    mov rsi, [w]
    mov rdx, [h]
    mov rcx, [c]
    call printf

    ; mov rdi, pointer_format
    ; mov rsi, rsp
    ; call printf
    
    call create_tex

loop:
    movd xmm0, [zero]
    movd xmm1, [r]
    movd xmm2, [zero]
    movd xmm3, [r]
    call [glad_glClearColor]
    
    mov rdi, 16384
    call [glad_glClear]

    mov rdi, [program]
    call [glad_glUseProgram]

    mov rdi, 0x0004
    mov rsi, 0
    mov rdx, 6
    call [glad_glDrawArrays]

    mov rdi, [window]
    call glfwSwapBuffers
    call glfwPollEvents

    mov rdi, [window]
    mov rsi, GLFW_KEY_A
    call glfwGetKey
    cmp rax, 0
    je handle_a_end

handle_a_start:
    push __float32__(0.01)
    cvtss2sd xmm0, [rsp]
    movsd xmm1, [vertices] 
    addsd xmm0, xmm1
    pop rax

    movsd [number], xmm0
    movsd xmm0, [number]
    movsd [vertices], xmm0

    mov rdi, GL_ARRAY_BUFFER
    mov rsi, [vbo]
    call [glad_glBindBuffer]

    mov rdi, GL_ARRAY_BUFFER
    mov rsi, 192
    mov rdx, vertices
    mov rcx, GL_STATIC_DRAW
    call [glad_glBufferData]
handle_a_end:

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
    status: resb 4
    number: resb 8
    image: resb 8
    w: resb 4
    h: resb 4
    c: resb 4
    tex: resb 4

section .data
    vertices: dq -0.5, -0.5, 0.0, 0.0,   0.5, 0.5, 1.0, 1.0,    0.5, -0.5, 1.0, 0.0,   -0.5, -0.5, 0.0, 0.0,   0.5, 0.5, 1.0, 1.0,  -0.5, 0.5, 0.0, 1.0

section .rodata
    int_format: db "%d", 10, 0
    float_format: db "%f", 10, 0
    pointer_format: db "%p", 10, 0
    string_format: db "%s", 10, 0
    title: db "Hello, world!", 0
    error: db "Failed to load gl functions!", 10
    imgpath: db "assets/test.png", 0
    pf: db "w: %d, h: %d, c: %d", 10, 0
    len equ $ - error
    r: dd 1.0
    test: dq 0.2
    zero: dq 0.0

    vsrc:
        db 0xa, 0x23, 0x76, 0x65, 0x72, 0x73, 0x69, 0x6f, 0x6e, 0x20, 0x33, 0x33, 0x30, 0x20, 0x63, 0x6f, 0x72, 0x65, 0xa, 0x6c, 0x61, 0x79, 0x6f, 0x75, 0x74, 0x28, 0x6c, 0x6f, 0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x3d, 0x30, 0x29, 0x20, 0x69, 0x6e, 0x20, 0x76, 0x65, 0x63, 0x32, 0x20, 0x61, 0x50, 0x6f, 0x73, 0x3b, 0xa, 0x6c, 0x61, 0x79, 0x6f, 0x75, 0x74, 0x28, 0x6c, 0x6f, 0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x3d, 0x31, 0x29, 0x20, 0x69, 0x6e, 0x20, 0x76, 0x65, 0x63, 0x32, 0x20, 0x61, 0x55, 0x76, 0x3b, 0xa, 0xa, 0x6f, 0x75, 0x74, 0x20, 0x76, 0x65, 0x63, 0x32, 0x20, 0x75, 0x76, 0x3b, 0xa, 0xa, 0x76, 0x6f, 0x69, 0x64, 0x20, 0x6d, 0x61, 0x69, 0x6e, 0x28, 0x29, 0x20, 0x7b, 0xa, 0x20, 0x20, 0x20, 0x20, 0x67, 0x6c, 0x5f, 0x50, 0x6f, 0x73, 0x69, 0x74, 0x69, 0x6f, 0x6e, 0x20, 0x3d, 0x20, 0x76, 0x65, 0x63, 0x34, 0x28, 0x61, 0x50, 0x6f, 0x73, 0x2e, 0x78, 0x79, 0x2c, 0x20, 0x30, 0x2e, 0x30, 0x2c, 0x20, 0x31, 0x2e, 0x30, 0x29, 0x3b, 0x20, 0xa, 0x20, 0x20, 0x20, 0x20, 0x75, 0x76, 0x20, 0x3d, 0x20, 0x61, 0x55, 0x76, 0x3b, 0xa, 0x7d, 0xa, 0
    fsrc:
        db 0xa, 0x23, 0x76, 0x65, 0x72, 0x73, 0x69, 0x6f, 0x6e, 0x20, 0x33, 0x33, 0x30, 0x20, 0x63, 0x6f, 0x72, 0x65, 0xa, 0x69, 0x6e, 0x20, 0x76, 0x65, 0x63, 0x32, 0x20, 0x75, 0x76, 0x3b, 0xa, 0x75, 0x6e, 0x69, 0x66, 0x6f, 0x72, 0x6d, 0x20, 0x73, 0x61, 0x6d, 0x70, 0x6c, 0x65, 0x72, 0x32, 0x44, 0x20, 0x69, 0x6d, 0x61, 0x67, 0x65, 0x3b, 0xa, 0xa, 0x76, 0x6f, 0x69, 0x64, 0x20, 0x6d, 0x61, 0x69, 0x6e, 0x28, 0x29, 0x20, 0x7b, 0xa, 0x20, 0x20, 0x20, 0x20, 0x67, 0x6c, 0x5f, 0x46, 0x72, 0x61, 0x67, 0x43, 0x6f, 0x6c, 0x6f, 0x72, 0x20, 0x3d, 0x20, 0x74, 0x65, 0x78, 0x74, 0x75, 0x72, 0x65, 0x28, 0x69, 0x6d, 0x61, 0x67, 0x65, 0x2c, 0x20, 0x75, 0x76, 0x29, 0x3b, 0xa, 0x7d, 0xa, 0
    pvsrc:
        dq vsrc
    pfsrc:
        dq fsrc
