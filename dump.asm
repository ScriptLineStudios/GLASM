	.file	"test.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"#version 330 core\nlayout (location = 0) in vec2 aPos; layout (location = 1) in vec3 aCol; out vec3 color; void main() { gl_Position = vec4(aPos.xy, 0.0, 1.0); color = aCol; }"
	.align 8
.LC1:
	.string	"#version 330 core\nin vec3 color; void main() { gl_FragColor = vec4(color.xyz, 1.0); }"
.LC2:
	.string	"Hello World"
.LC3:
	.string	"Failed to load"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 176
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	lea	rax, .LC0[rip]
	mov	QWORD PTR -152[rbp], rax
	lea	rax, .LC1[rip]
	mov	QWORD PTR -144[rbp], rax
	call	glfwInit@PLT
	mov	r8d, 0
	mov	ecx, 0
	lea	rax, .LC2[rip]
	mov	rdx, rax
	mov	esi, 800
	mov	edi, 800
	call	glfwCreateWindow@PLT
	mov	QWORD PTR -136[rbp], rax
	mov	rax, QWORD PTR -136[rbp]
	mov	rdi, rax
	call	glfwMakeContextCurrent@PLT
	mov	rax, QWORD PTR glfwGetProcAddress@GOTPCREL[rip]
	mov	rdi, rax
	call	gladLoadGLLoader@PLT
	test	eax, eax
	jne	.L2
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	puts@PLT
.L2:
	mov	rdx, QWORD PTR glad_glGenVertexArrays[rip]
	lea	rax, -172[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	rdx
	mov	rdx, QWORD PTR glad_glBindVertexArray[rip]
	mov	eax, DWORD PTR -172[rbp]
	mov	edi, eax
	call	rdx
	movsd	xmm0, QWORD PTR .LC4[rip]
	movsd	QWORD PTR -128[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC4[rip]
	movsd	QWORD PTR -120[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC5[rip]
	movsd	QWORD PTR -112[rbp], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -104[rbp], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -96[rbp], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -88[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC7[rip]
	movsd	QWORD PTR -80[rbp], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -72[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC5[rip]
	movsd	QWORD PTR -64[rbp], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -56[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC8[rip]
	movsd	QWORD PTR -48[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC4[rip]
	movsd	QWORD PTR -40[rbp], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -32[rbp], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -24[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC5[rip]
	movsd	QWORD PTR -16[rbp], xmm0
	mov	rdx, QWORD PTR glad_glGenBuffers[rip]
	lea	rax, -168[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	rdx
	mov	rdx, QWORD PTR glad_glBindBuffer[rip]
	mov	eax, DWORD PTR -168[rbp]
	mov	esi, eax
	mov	edi, 34962
	call	rdx
	mov	r8, QWORD PTR glad_glBufferData[rip]
	lea	rax, -128[rbp]
	mov	ecx, 35044
	mov	rdx, rax
	mov	esi, 120
	mov	edi, 34962
	call	r8
	mov	rax, QWORD PTR glad_glVertexAttribPointer[rip]
	mov	r9d, 0
	mov	r8d, 40
	mov	ecx, 0
	mov	edx, 5130
	mov	esi, 2
	mov	edi, 0
	call	rax
	mov	rax, QWORD PTR glad_glEnableVertexAttribArray[rip]
	mov	edi, 0
	call	rax
	mov	rax, QWORD PTR glad_glVertexAttribPointer[rip]
	mov	r9d, 16
	mov	r8d, 40
	mov	ecx, 0
	mov	edx, 5130
	mov	esi, 3
	mov	edi, 1
	call	rax
	mov	rax, QWORD PTR glad_glEnableVertexAttribArray[rip]
	mov	edi, 1
	call	rax
	mov	rax, QWORD PTR glad_glCreateShader[rip]
	mov	edi, 35633
	call	rax
	mov	DWORD PTR -164[rbp], eax
	mov	r8, QWORD PTR glad_glShaderSource[rip]
	lea	rdx, -152[rbp]
	mov	eax, DWORD PTR -164[rbp]
	mov	ecx, 0
	mov	esi, 1
	mov	edi, eax
	call	r8
	mov	rdx, QWORD PTR glad_glCompileShader[rip]
	mov	eax, DWORD PTR -164[rbp]
	mov	edi, eax
	call	rdx
	mov	rax, QWORD PTR glad_glCreateShader[rip]
	mov	edi, 35632
	call	rax
	mov	DWORD PTR -160[rbp], eax
	mov	r8, QWORD PTR glad_glShaderSource[rip]
	lea	rdx, -144[rbp]
	mov	eax, DWORD PTR -160[rbp]
	mov	ecx, 0
	mov	esi, 1
	mov	edi, eax
	call	r8
	mov	rdx, QWORD PTR glad_glCompileShader[rip]
	mov	eax, DWORD PTR -160[rbp]
	mov	edi, eax
	call	rdx
	mov	rax, QWORD PTR glad_glCreateProgram[rip]
	call	rax
	mov	DWORD PTR -156[rbp], eax
	mov	rcx, QWORD PTR glad_glAttachShader[rip]
	mov	edx, DWORD PTR -164[rbp]
	mov	eax, DWORD PTR -156[rbp]
	mov	esi, edx
	mov	edi, eax
	call	rcx
	mov	rcx, QWORD PTR glad_glAttachShader[rip]
	mov	edx, DWORD PTR -160[rbp]
	mov	eax, DWORD PTR -156[rbp]
	mov	esi, edx
	mov	edi, eax
	call	rcx
	mov	rdx, QWORD PTR glad_glLinkProgram[rip]
	mov	eax, DWORD PTR -156[rbp]
	mov	edi, eax
	call	rdx
	mov	rdx, QWORD PTR glad_glUseProgram[rip]
	mov	eax, DWORD PTR -156[rbp]
	mov	edi, eax
	call	rdx
	mov	rax, QWORD PTR glad_glTexImage2D[rip]
	sub	rsp, 8
	push	0
	push	5121
	push	6408
	mov	r9d, 0
	mov	r8d, 1000
	mov	ecx, 1000
	mov	edx, 6408
	mov	esi, 0
	mov	edi, 3553
	call	rax
	add	rsp, 32
	jmp	.L3
.L4:
	mov	rdx, QWORD PTR glad_glClearColor[rip]
	movss	xmm3, DWORD PTR .LC9[rip]
	movss	xmm2, DWORD PTR .LC10[rip]
	movss	xmm1, DWORD PTR .LC10[rip]
	mov	eax, DWORD PTR .LC10[rip]
	movd	xmm0, eax
	call	rdx
	mov	rax, QWORD PTR glad_glClear[rip]
	mov	edi, 16384
	call	rax
	mov	rax, QWORD PTR glad_glDrawArrays[rip]
	mov	edx, 3
	mov	esi, 0
	mov	edi, 4
	call	rax
	mov	rax, QWORD PTR -136[rbp]
	mov	rdi, rax
	call	glfwSwapBuffers@PLT
	call	glfwPollEvents@PLT
.L3:
	mov	rax, QWORD PTR -136[rbp]
	mov	rdi, rax
	call	glfwWindowShouldClose@PLT
	test	eax, eax
	je	.L4
	mov	eax, 0
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L6
	call	__stack_chk_fail@PLT
.L6:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC4:
	.long	0
	.long	-1075838976
	.align 8
.LC5:
	.long	0
	.long	1072693248
	.align 8
.LC7:
	.long	2061584302
	.long	1071099412
	.align 8
.LC8:
	.long	0
	.long	1071644672
	.align 4
.LC9:
	.long	1065353216
	.align 4
.LC10:
	.long	1036831949
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04.1) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
