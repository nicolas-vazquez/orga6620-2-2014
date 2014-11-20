#include <mips/regdef.h>
#include <sys/syscall.h>        

#define VALIDATE_SSIZE	(56)

#define VALIDATE_RA	((VALIDATE_SSIZE) - 8)
#define	VALIDATE_FP	((VALIDATE_SSIZE) - 12)
#define VALIDATE_GP	((VALIDATE_SSIZE) - 16)

#define VALIDATE_A0	((VALIDATE_SSIZE) + 0)
#define VALIDATE_A1	((VALIDATE_SSIZE) + 4)
#define VALIDATE_A2	((VALIDATE_SSIZE) + 8)
#define VALIDATE_A3	((VALIDATE_SSIZE) + 12)

#define VALIDATE_FILE	((VALIDATE_SSIZE) - 24)
#define VALIDATE_LINE	((VALIDATE_SSIZE) - 20)

#define VALIDATE_OLDTAG ((VALIDATE_SSIZE) - 28)
#define VALIDATE_OLDTAG_L ((VALIDATE_SSIZE) - 32)

#define CHILD_A0	((VALIDATE_SSIZE) - 56)
#define CHILD_A1	((VALIDATE_SSIZE) - 52)
#define CHILD_A2	((VALIDATE_SSIZE) - 48)
#define CHILD_A3	((VALIDATE_SSIZE) - 44)
#define CHILD_A4	((VALIDATE_SSIZE) - 40)
#define CHILD_A5	((VALIDATE_SSIZE) - 36)

	.text
        .globl validate 

	.align 2
	.ent validate

//###################################################################
//		int validate(char* fbuf, char** error)		    #
//###################################################################
validate: 
        	.frame	$fp, VALIDATE_SSIZE, ra
		.set	noreorder
		.cpload	t9
		.set	reorder
		subu    sp,sp,VALIDATE_SSIZE

		.cprestore	VALIDATE_GP
		sw	$fp,VALIDATE_FP(sp)
		sw	gp,VALIDATE_GP(sp)
		sw	ra,VALIDATE_RA(sp)
		move	$fp,sp

		sw	a0,VALIDATE_A0($fp)	#build arg area char* fbuf
		sw	a1,VALIDATE_A1($fp)	#char** error
		sw	a2,VALIDATE_A2($fp)
		sw	a3,VALIDATE_A3($fp)
		
		li 	t0,0			#line = 0
		move	t1,a0			#t1 = file*	
		sw	t0,VALIDATE_LINE($fp)
		sw	t1,VALIDATE_FILE($fp)
		
		lb	t2,0(t1)		#t2 <- file[0]
		li	v0,0
$while_val:	

		beqz	t2,$end_val		#file[] != \0
		bne	v0,zero,$end_val	#result != 1

		lw	a0, VALIDATE_FILE($fp)
		la	a1, VALIDATE_LINE($fp)
		li	a2, 0
		li	a3, 0

		la	t9, find_tag
		jal	ra, t9

		bne	v0, zero, $end_val

		lw	t1, CHILD_A0($fp)
		sw	t1, VALIDATE_FILE($fp)

		lw	t3, CHILD_A2($fp)
		lw	t4, CHILD_A3($fp)

		sw	t3, VALIDATE_OLDTAG($fp)
		sw	t4, VALIDATE_OLDTAG_L($fp)
	
		lw	a0, VALIDATE_OLDTAG($fp)
		lw	a1, VALIDATE_OLDTAG_L($fp)
		la	t9, is_begin_tag
		jal	ra, t9

		bne	v0, 0, $build_message_val
		
		lw	a0,VALIDATE_FILE($fp)		#file*
		la	a1,VALIDATE_LINE($fp)		#line*
		lw	a2,VALIDATE_OLDTAG($fp)		#oldtag
		lw	a3,VALIDATE_OLDTAG_L($fp)	#oldtag_length
		
		la	t9, parse
		jal	ra, t9

		bne	v0, 0, $show_err
	
		move	t1, a0
		
		sw	t1,VALIDATE_FILE($fp)
		lb	t2,0(t1)	
		j	$while_val	

$build_message_val:
		li	a0, 0
		lw	a1, VALIDATE_OLDTAG($fp)
		lw	a2, VALIDATE_OLDTAG_L($fp)
		lw	a3, VALIDATE_OLDTAG($fp)
		sw	a2, CHILD_A4($fp)
		la	t0, VALIDATE_LINE($fp)
		sw	t0, CHILD_A5($fp)

		la	t9, create_message
		jal	ra, t9

		sw	v0, CHILD_A4($fp)
		li 	v0, 1

$show_err:
		lw	a0, VALIDATE_A0($fp)
		lw	t1, CHILD_A4($fp)
		lw	t2, VALIDATE_A1($fp)
		sw	t1, 0(t2)
		lw	a1, VALIDATE_A1($fp)
		j	$end_err

$end_val:		
		li	v0, 0 
		lw	a0, VALIDATE_A0($fp)
		lw	a1, VALIDATE_A1($fp)
$end_err:	
		lw	a2, VALIDATE_A2($fp)
		lw	a3, VALIDATE_A3($fp)	
 
		move	sp,$fp
		lw	$fp,VALIDATE_FP(sp)
		lw      gp,VALIDATE_GP(sp)
		lw	ra,VALIDATE_RA(sp)
		addu	sp,sp, VALIDATE_SSIZE
		j	ra
		.end 	validate
		
