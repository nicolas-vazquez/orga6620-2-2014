#include <mips/regdef.h>
#include <sys/syscall.h>

#define FIND_TAG_SSIZE  (8)

#define FIND_TAG_FP     ((FIND_TAG_SSIZE) - 4 )
#define FIND_TAG_GP     ((FIND_TAG_SSIZE) - 8)


#define FIND_TAG_A0     ((FIND_TAG_SSIZE) + 12)
#define FIND_TAG_A1     ((FIND_TAG_SSIZE) + 8)
#define FIND_TAG_A2     ((FIND_TAG_SSIZE) + 4)
#define FIND_TAG_A3     ((FIND_TAG_SSIZE) + 0)


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
                move    $fp,sp

                sw      a0,FIND_TAG_A0($fp)     #build arg area char* fbuf
                sw      a1,FIND_TAG_A1($fp)     #int* line
                sw      a2,FIND_TAG_A2($fp)     #char* newtag
                sw      a3,FIND_TAG_A3($fp)     #int newtag_length

		move 	t0, a0			# $t0 = *file
		lw 	t1, 0(a1)		# $t1 = line
		move 	t2, a2			# $t2 = *tag
		move 	t3, a3			# $t3 = *length
		li	t5, 60			# t5 = <
		li	t6, 62			# t6 = >
		li	t7, 10			# t7 = \n


loop1:
		lb      t4,0(t0)                #t4 <- file[t0]

		beq 	t4, zero, return_1
		beq 	t4, t5, fin_loop1
		addi 	t0, t0, 1
		beq 	t4, t7, inc_line
		j 	loop1

inc_line:
		addi 	t1, t1, 1
		j 	loop1	

fin_loop1:
	
		addi 	t0, t0, 1
		move	t2, t0

loop2:


		lb      t4, 0(t0)               #t4 <- file[t0]
		beq 	t4, 0, return_1
		beq 	t4, t6, fin_loop2
		addi 	t3, t3, 1
		addi 	t0, t0, 1
		j 	loop2

fin_loop2:
		addi 	t0, t0, 1
		j 	return_0

return_0:
		li 	v0, 0
		j 	exit

return_1:
		li 	v0, 1
		j 	exit

exit:
                sw	t0, FIND_TAG_A0($fp)
		lw 	a1, FIND_TAG_A1($fp)
                sw      t1, 0(a1)
                sw      t2, FIND_TAG_A2($fp)
		sw	t3, FIND_TAG_A3($fp)
                
                move    sp,$fp
                lw      $fp,FIND_TAG_FP(sp)
                lw      gp,FIND_TAG_GP(sp)
		lw	ra,FIND_TAG_RA(sp)
                addu    sp,sp, FIND_TAG_SSIZE
                j       ra
                .end    find_tag

	
