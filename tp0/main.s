	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.rdata
	.align	2
$LC0:
	.ascii	"%d%s%c\000"
	.text
	.align	2
	.globl	write_line
	.ent	write_line
write_line:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 16, extra= 8
	.mask	0x90000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,32
	.cprestore 16
	sw	$31,28($sp)
	sw	$28,24($sp)
	.set	noreorder
	.set	nomacro
	beq	$7,$0,$L2
	move	$2,$5
	.set	macro
	.set	reorder

	lb	$7,0($6)
	la	$4,$LC0
	lw	$5,4($5)
	lw	$6,0($2)
	la	$25,printf
	jal	$31,$25
	b	$L1
$L2:
	lb	$4,0($6)
	la	$25,putchar
	jal	$31,$25
$L1:
	lw	$31,28($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	write_line
	.size	write_line, .-write_line
	.rdata
	.align	2
$LC1:
	.ascii	"USAGE:\000"
	.align	2
$LC2:
	.ascii	"tp0 [OPTION]...[FILE]...\000"
	.align	2
$LC3:
	.ascii	"Write each FILE to standard output, with line numbers ad"
	.ascii	"ded. \000"
	.align	2
$LC4:
	.ascii	"With no FILE, or when FILE is -, read standard input\n\000"
	.align	2
$LC5:
	.ascii	"OPTIONS:\000"
	.align	2
$LC6:
	.ascii	"-h, --help Print this message and quit\000"
	.align	2
$LC7:
	.ascii	"-s, --number-separator (mandatory argument)\000"
	.align	2
$LC8:
	.ascii	"-v, --starting-line-number (mandatory argument)\000"
	.align	2
$LC9:
	.ascii	"-i, --line-increment (mandatory argument)\000"
	.align	2
$LC10:
	.ascii	"-l, --join-blank-lines (mandatory argument)\000"
	.align	2
$LC11:
	.ascii	"-t, --non-blank\000"
	.text
	.align	2
	.globl	show_help
	.ent	show_help
show_help:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 16, extra= 8
	.mask	0x90000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,32
	.cprestore 16
	sw	$31,28($sp)
	sw	$28,24($sp)
	la	$4,$LC1
	la	$25,puts
	jal	$31,$25
	la	$4,$LC2
	la	$25,puts
	jal	$31,$25
	la	$4,$LC3
	la	$25,printf
	jal	$31,$25
	la	$4,$LC4
	la	$25,puts
	jal	$31,$25
	la	$4,$LC5
	la	$25,puts
	jal	$31,$25
	la	$4,$LC6
	la	$25,puts
	jal	$31,$25
	la	$4,$LC7
	la	$25,puts
	jal	$31,$25
	la	$4,$LC8
	la	$25,puts
	jal	$31,$25
	la	$4,$LC9
	la	$25,puts
	jal	$31,$25
	la	$4,$LC10
	la	$25,puts
	jal	$31,$25
	la	$4,$LC11
	la	$25,puts
	jal	$31,$25
	lw	$31,28($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	show_help
	.size	show_help, .-show_help
	.rdata
	.align	2
$LC12:
	.ascii	"%c\000"
	.text
	.align	2
	.globl	skip_blanks
	.ent	skip_blanks
skip_blanks:
	.frame	$sp,56,$31		# vars= 0, regs= 7/0, args= 16, extra= 8
	.mask	0x901f0000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$31,48($sp)
	sw	$28,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	move	$17,$4
	move	$18,$5
	move	$19,$6
	lb	$3,0($7)
	li	$2,10			# 0xa
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L6
	move	$16,$7
	.set	macro
	.set	reorder

	lw	$2,16($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	move	$4,$17
	.set	macro
	.set	reorder

	li	$19,10			# 0xa
$L22:
	move	$5,$18
	move	$6,$16
	move	$7,$0
	la	$25,write_line
	jal	$31,$25
	move	$4,$17
	la	$5,$LC12
	move	$6,$16
	la	$25,fscanf
	jal	$31,$25
	lb	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$19,$L22
	move	$4,$17
	.set	macro
	.set	reorder

	b	$L5
$L6:
	lb	$3,0($16)
	li	$2,10			# 0xa
	bne	$3,$2,$L5
	lw	$2,12($18)
	#nop
	blez	$2,$L5
	lw	$2,0($19)
	#nop
	addu	$2,$2,1
	sw	$2,0($19)
	lw	$3,12($18)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L5
	li	$20,10			# 0xa
	.set	macro
	.set	reorder

	move	$4,$17
$L23:
	la	$5,$LC12
	move	$6,$16
	la	$25,fscanf
	jal	$31,$25
	lb	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$20,$L5
	move	$4,$17
	.set	macro
	.set	reorder

	move	$5,$18
	move	$6,$16
	move	$7,$0
	la	$25,write_line
	jal	$31,$25
	lw	$2,0($19)
	#nop
	addu	$2,$2,1
	sw	$2,0($19)
	lw	$3,12($18)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L23
	move	$4,$17
	.set	macro
	.set	reorder

$L5:
	lw	$31,48($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	skip_blanks
	.size	skip_blanks, .-skip_blanks
	.align	2
	.globl	increment
	.ent	increment
increment:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	lw	$2,8($4)
	#nop
	bne	$2,$0,$L25
	lw	$2,4($4)
	.set	noreorder
	.set	nomacro
	b	$L27
	addu	$2,$2,1
	.set	macro
	.set	reorder

$L25:
	lw	$2,4($4)
	lw	$3,8($4)
	#nop
	addu	$2,$2,$3
$L27:
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,4($4)
	.set	macro
	.set	reorder

	.end	increment
	.size	increment, .-increment
	.rdata
	.align	2
$LC13:
	.ascii	"\n\000"
	.text
	.align	2
	.globl	parse_line
	.ent	parse_line
parse_line:
	.frame	$sp,48,$31		# vars= 0, regs= 6/0, args= 16, extra= 8
	.mask	0x900f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$31,44($sp)
	sw	$28,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	move	$17,$4
	move	$19,$5
	move	$16,$6
	li	$7,1			# 0x1
	la	$25,write_line
	jal	$31,$25
	lb	$2,0($16)
	li	$18,10			# 0xa
	.set	noreorder
	.set	nomacro
	beq	$2,$18,$L28
	move	$4,$17
	.set	macro
	.set	reorder

	la	$5,$LC12
	move	$6,$16
	la	$25,fscanf
	jal	$31,$25
	lb	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$18,$L36
	move	$4,$17
	.set	macro
	.set	reorder

$L37:
	move	$5,$19
	move	$6,$16
	move	$7,$0
	la	$25,write_line
	jal	$31,$25
	move	$4,$17
	la	$5,$LC12
	move	$6,$16
	la	$25,fscanf
	jal	$31,$25
	lb	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$18,$L37
	move	$4,$17
	.set	macro
	.set	reorder

$L36:
	move	$5,$19
	la	$6,$LC13
	move	$7,$0
	la	$25,write_line
	jal	$31,$25
$L28:
	lw	$31,44($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	parse_line
	.size	parse_line, .-parse_line
	.align	2
	.globl	nl_v1
	.ent	nl_v1
nl_v1:
	.frame	$sp,56,$31		# vars= 8, regs= 5/0, args= 16, extra= 8
	.mask	0x90070000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$31,48($sp)
	sw	$28,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	move	$17,$4
	move	$16,$5
	sw	$0,28($sp)
	.set	noreorder
	.set	nomacro
	b	$L39
	li	$18,-1			# 0xffffffffffffffff
	.set	macro
	.set	reorder

$L42:
	move	$5,$16
	addu	$6,$sp,28
	addu	$7,$sp,24
	la	$25,skip_blanks
	jal	$31,$25
	move	$4,$17
	move	$5,$16
	addu	$6,$sp,24
	la	$25,parse_line
	jal	$31,$25
	move	$4,$16
	la	$25,increment
	jal	$31,$25
$L39:
	move	$4,$17
	la	$25,fgetc
	jal	$31,$25
	sb	$2,24($sp)
	sll	$2,$2,24
	sra	$2,$2,24
	.set	noreorder
	.set	nomacro
	bne	$2,$18,$L42
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$31,48($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	nl_v1
	.size	nl_v1, .-nl_v1
	.rdata
	.align	2
$LC14:
	.ascii	"%d%s%s\n\000"
	.text
	.align	2
	.globl	write_line_v2
	.ent	write_line_v2
write_line_v2:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 16, extra= 8
	.mask	0x90000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,32
	.cprestore 16
	sw	$31,28($sp)
	sw	$28,24($sp)
	move	$8,$4
	li	$2,1			# 0x1
	.set	noreorder
	.set	nomacro
	bne	$7,$2,$L44
	move	$3,$5
	.set	macro
	.set	reorder

	la	$4,$LC14
	lw	$5,4($5)
	lw	$6,0($3)
	move	$7,$8
	la	$25,printf
	jal	$31,$25
	b	$L43
$L44:
	lb	$4,0($6)
	la	$25,putchar
	jal	$31,$25
$L43:
	lw	$31,28($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	write_line_v2
	.size	write_line_v2, .-write_line_v2
	.align	2
	.globl	skip_blanks_v2
	.ent	skip_blanks_v2
skip_blanks_v2:
	.frame	$sp,56,$31		# vars= 0, regs= 8/0, args= 16, extra= 8
	.mask	0x903f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$31,52($sp)
	sw	$28,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	move	$18,$4
	move	$19,$5
	move	$16,$6
	lw	$17,72($sp)
	lb	$3,0($6)
	li	$2,10			# 0xa
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L47
	move	$20,$7
	.set	macro
	.set	reorder

	lw	$2,16($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L47
	move	$4,$0
	.set	macro
	.set	reorder

	li	$19,10			# 0xa
$L63:
	move	$5,$18
	move	$6,$16
	move	$7,$0
	la	$25,write_line_v2
	jal	$31,$25
	lw	$2,0($17)
	#nop
	addu	$3,$20,$2
	lbu	$3,0($3)
	#nop
	sb	$3,0($16)
	addu	$2,$2,1
	sw	$2,0($17)
	lb	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$19,$L63
	move	$4,$0
	.set	macro
	.set	reorder

	b	$L46
$L47:
	lb	$3,0($16)
	li	$2,10			# 0xa
	bne	$3,$2,$L46
	lw	$2,12($18)
	#nop
	blez	$2,$L46
	lw	$2,0($19)
	#nop
	addu	$2,$2,1
	sw	$2,0($19)
	lw	$3,12($18)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L46
	li	$21,10			# 0xa
	.set	macro
	.set	reorder

$L59:
	lw	$2,0($17)
	#nop
	addu	$3,$20,$2
	lbu	$3,0($3)
	#nop
	sb	$3,0($16)
	addu	$2,$2,1
	sll	$3,$3,24
	sra	$3,$3,24
	.set	noreorder
	.set	nomacro
	bne	$3,$21,$L46
	sw	$2,0($17)
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$18
	move	$6,$16
	move	$7,$0
	la	$25,write_line_v2
	jal	$31,$25
	lw	$2,0($19)
	#nop
	addu	$2,$2,1
	sw	$2,0($19)
	lw	$3,12($18)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L59
$L46:
	lw	$31,52($sp)
	lw	$21,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	skip_blanks_v2
	.size	skip_blanks_v2, .-skip_blanks_v2
	.align	2
	.globl	parse_line_v2
	.ent	parse_line_v2
parse_line_v2:
	.frame	$sp,48,$31		# vars= 0, regs= 6/0, args= 16, extra= 8
	.mask	0x900f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$31,44($sp)
	sw	$28,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	move	$18,$6
	lw	$19,64($sp)
	lw	$17,68($sp)
	lbu	$4,0($5)
	lb	$3,0($5)
	li	$2,10			# 0xa
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L64
	move	$16,$7
	.set	macro
	.set	reorder

	lw	$2,0($6)
	#nop
	addu	$2,$19,$2
	sb	$4,0($2)
	lw	$4,0($7)
	#nop
	addu	$4,$17,$4
	li	$5,10			# 0xa
	la	$25,strchr
	jal	$31,$25
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L66
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$4,0($16)
	#nop
	addu	$4,$17,$4
	la	$25,strchr
	jal	$31,$25
$L66:
	lw	$6,0($16)
	#nop
	addu	$6,$17,$6
	subu	$6,$2,$6
	addu	$6,$6,1
	sw	$6,0($18)
	addu	$4,$19,1
	lw	$5,0($16)
	#nop
	addu	$5,$17,$5
	la	$25,strncpy
	jal	$31,$25
	lw	$2,0($16)
	lw	$3,0($18)
	#nop
	addu	$2,$2,$3
	sw	$2,0($16)
$L64:
	lw	$31,44($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	parse_line_v2
	.size	parse_line_v2, .-parse_line_v2
	.align	2
	.globl	read_file
	.ent	read_file
read_file:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 16, extra= 8
	.mask	0x90070000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$31,40($sp)
	sw	$28,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	move	$16,$4
	move	$17,$5
	move	$18,$6
	move	$5,$0
	move	$6,$0
	la	$25,fseek
	jal	$31,$25
	move	$4,$17
	li	$5,1			# 0x1
	move	$6,$18
	move	$7,$16
	la	$25,fread
	jal	$31,$25
	addu	$17,$17,$18
	sb	$0,-1($17)
	lw	$31,40($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	read_file
	.size	read_file, .-read_file
	.align	2
	.globl	nl_v2
	.ent	nl_v2
nl_v2:
	.frame	$sp,88,$31		# vars= 16, regs= 7/0, args= 32, extra= 8
	.mask	0x901f0000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,88
	.cprestore 32
	sw	$31,80($sp)
	sw	$28,76($sp)
	sw	$20,72($sp)
	sw	$19,68($sp)
	sw	$18,64($sp)
	sw	$17,60($sp)
	sw	$16,56($sp)
	move	$16,$4
	move	$19,$5
	sw	$0,48($sp)
	sw	$0,52($sp)
	sw	$0,44($sp)
	move	$5,$0
	li	$6,2			# 0x2
	la	$25,fseek
	jal	$31,$25
	move	$4,$16
	la	$25,ftell
	jal	$31,$25
	move	$20,$2
	move	$4,$2
	la	$25,malloc
	jal	$31,$25
	move	$17,$2
	li	$4,1024			# 0x400
	la	$25,malloc
	jal	$31,$25
	move	$18,$2
	move	$4,$16
	move	$5,$17
	move	$6,$20
	la	$25,read_file
	jal	$31,$25
	addu	$4,$sp,44
	lw	$2,44($sp)
	#nop
	addu	$3,$17,$2
	lbu	$3,0($3)
	#nop
	sb	$3,40($sp)
	addu	$2,$2,1
	sll	$3,$3,24
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L74
	sw	$2,44($sp)
	.set	macro
	.set	reorder

$L72:
	sw	$4,16($sp)
	move	$4,$19
	addu	$5,$sp,48
	addu	$6,$sp,40
	move	$7,$17
	la	$25,skip_blanks_v2
	jal	$31,$25
	sw	$18,16($sp)
	sw	$17,20($sp)
	sw	$20,24($sp)
	move	$4,$19
	addu	$5,$sp,40
	addu	$6,$sp,52
	addu	$7,$sp,44
	la	$25,parse_line_v2
	jal	$31,$25
	lw	$2,52($sp)
	#nop
	addu	$3,$18,$2
	sb	$0,0($3)
	addu	$2,$2,1
	sw	$2,52($sp)
	move	$4,$18
	move	$5,$19
	addu	$6,$sp,40
	li	$7,1			# 0x1
	la	$25,write_line_v2
	jal	$31,$25
	sw	$0,52($sp)
	move	$4,$19
	la	$25,increment
	jal	$31,$25
	addu	$4,$sp,44
	lw	$2,44($sp)
	#nop
	addu	$3,$17,$2
	lbu	$3,0($3)
	#nop
	sb	$3,40($sp)
	addu	$2,$2,1
	sll	$3,$3,24
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L72
	sw	$2,44($sp)
	.set	macro
	.set	reorder

$L74:
	move	$4,$17
	la	$25,free
	jal	$31,$25
	move	$4,$18
	la	$25,free
	jal	$31,$25
	lw	$31,80($sp)
	lw	$20,72($sp)
	lw	$19,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	nl_v2
	.size	nl_v2, .-nl_v2
	.rdata
	.align	2
$LC15:
	.ascii	"help\000"
	.align	2
$LC16:
	.ascii	"number-separator\000"
	.align	2
$LC17:
	.ascii	"starting-line-number\000"
	.align	2
$LC18:
	.ascii	"line-increment\000"
	.align	2
$LC19:
	.ascii	"join-blank-lines\000"
	.align	2
$LC20:
	.ascii	"non-blank\000"
	.data
	.align	2
$LC21:
	.word	$LC15
	.word	0
	.word	0
	.word	104
	.word	$LC16
	.word	1
	.word	0
	.word	115
	.word	$LC17
	.word	1
	.word	0
	.word	118
	.word	$LC18
	.word	1
	.word	0
	.word	105
	.word	$LC19
	.word	1
	.word	0
	.word	108
	.word	$LC20
	.word	0
	.word	0
	.word	116
	.word	0
	.word	0
	.word	0
	.word	0
	.rdata
	.align	2
$LC22:
	.ascii	" \000"
	.align	2
$LC23:
	.ascii	"hs:v:i:l:t\000"
	.text
	.align	2
	.globl	parse_args
	.ent	parse_args
parse_args:
	.frame	$sp,176,$31		# vars= 120, regs= 5/0, args= 24, extra= 8
	.mask	0x90070000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,176
	.cprestore 24
	sw	$31,168($sp)
	sw	$28,164($sp)
	sw	$18,160($sp)
	sw	$17,156($sp)
	sw	$16,152($sp)
	move	$16,$4
	move	$18,$5
	move	$17,$6
	sw	$0,144($sp)
	addu	$3,$sp,32
	la	$2,$LC21
	addu	$4,$2,112
$L76:
	lw	$5,0($2)
	lw	$6,4($2)
	lw	$7,8($2)
	lw	$8,12($2)
	sw	$5,0($3)
	sw	$6,4($3)
	sw	$7,8($3)
	sw	$8,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L76
	addu	$3,$3,16
	.set	macro
	.set	reorder

	la	$2,$LC22
	sw	$2,0($16)
	li	$2,1			# 0x1
	sw	$2,4($16)
	sw	$0,8($16)
	sw	$0,12($16)
	sw	$0,16($16)
$L91:
	addu	$2,$sp,144
$L92:
	sw	$2,16($sp)
	move	$4,$18
	move	$5,$17
	la	$6,$LC23
	addu	$7,$sp,32
	la	$25,getopt_long
	jal	$31,$25
	move	$3,$2
	li	$2,-1			# 0xffffffffffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L78
	addu	$3,$3,-104
	.set	macro
	.set	reorder

	sltu	$2,$3,15
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L92
	addu	$2,$sp,144
	.set	macro
	.set	reorder

	sll	$2,$3,2
	lw	$2,$L89($2)
	#nop
	.cpadd	$2
	j	$2
	.rdata
	.align	2
$L89:
	.gpword	$L82
	.gpword	$L85
	.gpword	$L91
	.gpword	$L91
	.gpword	$L86
	.gpword	$L91
	.gpword	$L91
	.gpword	$L91
	.gpword	$L91
	.gpword	$L91
	.gpword	$L91
	.gpword	$L83
	.gpword	$L87
	.gpword	$L91
	.gpword	$L84
	.text
$L82:
	la	$25,show_help
	jal	$31,$25
	move	$4,$0
	la	$25,exit
	jal	$31,$25
$L83:
	lw	$2,optarg
	.set	noreorder
	.set	nomacro
	b	$L91
	sw	$2,0($16)
	.set	macro
	.set	reorder

$L84:
	lw	$4,optarg
	la	$25,atoi
	jal	$31,$25
	.set	noreorder
	.set	nomacro
	b	$L91
	sw	$2,4($16)
	.set	macro
	.set	reorder

$L85:
	lw	$4,optarg
	la	$25,atoi
	jal	$31,$25
	.set	noreorder
	.set	nomacro
	b	$L91
	sw	$2,8($16)
	.set	macro
	.set	reorder

$L86:
	lw	$4,optarg
	la	$25,atoi
	jal	$31,$25
	.set	noreorder
	.set	nomacro
	b	$L91
	sw	$2,12($16)
	.set	macro
	.set	reorder

$L87:
	li	$2,1			# 0x1
	.set	noreorder
	.set	nomacro
	b	$L91
	sw	$2,16($16)
	.set	macro
	.set	reorder

$L78:
	lw	$31,168($sp)
	lw	$18,160($sp)
	lw	$17,156($sp)
	lw	$16,152($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,176
	.set	macro
	.set	reorder

	.end	parse_args
	.size	parse_args, .-parse_args
	.rdata
	.align	2
$LC24:
	.ascii	"r\000"
	.align	2
$LC25:
	.ascii	"Error opening file %s\n\000"
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$sp,72,$31		# vars= 24, regs= 6/0, args= 16, extra= 8
	.mask	0x900f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,72
	.cprestore 16
	sw	$31,68($sp)
	sw	$28,64($sp)
	sw	$19,60($sp)
	sw	$18,56($sp)
	sw	$17,52($sp)
	sw	$16,48($sp)
	move	$18,$4
	move	$16,$5
	addu	$4,$sp,24
	move	$5,$18
	move	$6,$16
	la	$25,parse_args
	jal	$31,$25
	lw	$3,optind
	#nop
	slt	$2,$3,$18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L94
	sll	$2,$3,2
	.set	macro
	.set	reorder

	addu	$19,$16,$2
	subu	$2,$18,$3
	.set	noreorder
	.set	nomacro
	blez	$2,$L102
	move	$17,$0
	.set	macro
	.set	reorder

$L101:
	sll	$2,$17,2
	addu	$2,$2,$19
	lw	$4,0($2)
	la	$5,$LC24
	la	$25,fopen
	jal	$31,$25
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L99
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$5,$sp,24
	la	$25,nl_v1
	jal	$31,$25
	move	$4,$16
	la	$25,fclose
	jal	$31,$25
	.set	noreorder
	.set	nomacro
	b	$L105
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L99:
	sll	$2,$17,2
	addu	$2,$2,$19
	la	$4,__sF+176
	la	$5,$LC25
	lw	$6,0($2)
	la	$25,fprintf
	jal	$31,$25
	addu	$17,$17,1
$L105:
	lw	$2,optind
	#nop
	subu	$2,$18,$2
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L101
	move	$2,$0
	.set	macro
	.set	reorder

	b	$L106
$L94:
	la	$4,__sF
	addu	$5,$sp,24
	la	$25,nl_v1
	jal	$31,$25
$L102:
	move	$2,$0
$L106:
	lw	$31,68($sp)
	lw	$19,60($sp)
	lw	$18,56($sp)
	lw	$17,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
