#include <mips/regdef.h>
#include <sys/syscall.h>

#define FIND_TAG_SSIZE  (40)

#define FIND_TAG_FP     ((FIND_TAG_SSIZE) - 4 )
#define FIND_TAG_GP     ((FIND_TAG_SSIZE) - 8)
#define FIND_TAG_RA	((FIND_TAG_SSIZE) - 12)

#define FIND_TAG_A0     ((FIND_TAG_SSIZE) + 12)
#define FIND_TAG_A1     ((FIND_TAG_SSIZE) + 8)
#define FIND_TAG_A2     ((FIND_TAG_SSIZE) + 4)
#define FIND_TAG_A3     ((FIND_TAG_SSIZE) + 0)

#define FIND_TAG_T1     ((FIND_TAG_SSIZE)-24)

	.text
	.align 	2
	.globl	find_tag
	.ent	find_tag


//#######################################################################
// int find_tag(char* file, int* line, char* newtag, int newtag_length)#
//#######################################################################
find_tag:
		.frame  $fp, FIND_TAG_SSIZE, ra
                .set    noreorder
                .cpload t9
                .set    reorder
                subu    sp,sp,FIND_TAG_SSIZE

                .cprestore      FIND_TAG_GP
                sw      $fp,FIND_TAG_FP(sp)
                sw      gp,FIND_TAG_GP(sp)
		sw	ra,FIND_TAG_RA(sp) 
                move    $fp,sp

                sw      a0,FIND_TAG_A0($fp)     #build arg area char* fbuf
                sw      a1,FIND_TAG_A1($fp)     #int* line
                sw      a2,FIND_TAG_A2($fp)     #char* newtag
                sw      a3,FIND_TAG_A3($fp)     #int newtag_length

		move 	s0, a0			# $t0 = *file
		lw 	s1, 0(a1)		# $t1 = line
		move 	s2, a2			# $t2 = *tag
		move 	s3, a3			# $t3 = *length
		li	s5, 60			# t5 = <
		li	s6, 62			# t6 = >
		li	s7, 10			# t7 = \n


loop1:
		lb      s4,0(s0)                #t4 <- file[0]
//		la	t9, print_entro_loop1
//		jal	ra, t9
		beq 	s4, zero, return_1
		beq 	s4, s5, fin_loop1
		addi 	s0, s0, 1
		beq 	s4, s7, inc_line
		j 	loop1

inc_line:
		addi 	s1, s1, 1
		j 	loop1	

fin_loop1:
	
//		la	t9,print_enc_tag
//		jal	ra,t9
		addi 	s0, s0, 1
		move	s2, s0

loop2:
//		la	t9, print_entro_loop2
//		jal	ra,t9
		lb      s4, 0(s0)               #t4 <- file[0]
		beq 	s4, 0, return_1
		beq 	s4, s6, fin_loop2
		addi 	s3, s3, 1
		addi 	s0, s0, 1
		j 	loop2

fin_loop2:
//		la	t9, print_sale_loop
//		jal	ra,t9

//		move	a0, s2
//		move	a1, s3
//		la	t9, print
//		jal	ra, t9

		addi 	s0, s0, 1
		j 	return_0

return_0:
		li 	v0, 0
		j 	exit

return_1:
		li 	v0, 1
		j 	exit

exit:
                sw	s0, FIND_TAG_A0($fp)
		lw 	a1, FIND_TAG_A1($fp)
                sw      s1, 0(a1)
                sw      s2, FIND_TAG_A2($fp)
		sw	s3, FIND_TAG_A3($fp)
                
                move    sp,$fp
                lw      $fp,FIND_TAG_FP(sp)
                lw      gp,FIND_TAG_GP(sp)
		lw	ra,FIND_TAG_RA(sp)
                addu    sp,sp, FIND_TAG_SSIZE
                j       ra
                .end    find_tag

	
