#include <mips/regdef.h>
#include <sys/syscall.h>

#define PARSE_SSIZE  (56)

#define PARSE_RA     ((PARSE_SSIZE) - 8)
#define PARSE_FP     ((PARSE_SSIZE) - 12)
#define PARSE_GP     ((PARSE_SSIZE) - 16)

#define PARSE_A0     ((PARSE_SSIZE) + 0)
#define PARSE_A1     ((PARSE_SSIZE) + 4)
#define PARSE_A2     ((PARSE_SSIZE) + 8)
#define PARSE_A3     ((PARSE_SSIZE) + 12)
#define PARSE_A4     ((PARSE_SSIZE) + 16)

#define CHILD_A0     ((PARSE_SSIZE) - 56)
#define CHILD_A1     ((PARSE_SSIZE) - 52)
#define CHILD_A2     ((PARSE_SSIZE) - 48)
#define CHILD_A3     ((PARSE_SSIZE) - 44)
#define CHILD_A4     ((PARSE_SSIZE) - 40)
#define CHILD_A5     ((PARSE_SSIZE) - 36)

#define NEWTAG       ((PARSE_SSIZE)-28)
#define PARSE_T1     ((PARSE_SSIZE)-24)
#define NEWTAG_L     ((PARSE_SSIZE)-20)	
#define RETURN_VAL   ((PARSE_SSIZE)-32)

        .text
        .globl parse

        .align 2
        .ent parse

//#################################################################################
// int parse(char* file, int* line, char* oldtag, int oldtag_length, char* errmsg)#
//#################################################################################
parse:
                .frame  $fp, PARSE_SSIZE, ra
                .set    noreorder
                .cpload t9
                .set    reorder
                subu    sp,sp,PARSE_SSIZE

                .cprestore      PARSE_GP
                sw      $fp, PARSE_FP(sp)
                sw      gp, PARSE_GP(sp)
                sw      ra, PARSE_RA(sp)
                move    $fp, sp

                sw      a0, PARSE_A0($fp)     #build arg area char* fbuf
                sw      a1, PARSE_A1($fp)     #int* line
                sw      a2, PARSE_A2($fp)     #char* oldtag
                sw      a3, PARSE_A3($fp)     #int* oldtag_length
  
		
                move    t1, a0                   #t1 = file*
                sw      t1, PARSE_T1($fp)
		li	t7, 0			#newtag_length = 0
		sw	t7, NEWTAG_L($fp)	#t7 = newtag_length
                li	t6, 0			#*newtag = 0
		sw	t6, NEWTAG($fp)		#t6 = *newtag
                li      v0, 0
$while_parse:
  		lw	t1, PARSE_T1($fp)
                lb	t2, 0(t1)
		beqz    t2, $end_parse             #file[] != \0
                bne     v0, zero, $end_parse           #result != 1

		lw	t1, PARSE_T1($fp)
		move    a0, t1		 	#file**
                lw      a1, PARSE_A1($fp)	#line*
                lw	t6, NEWTAG($fp)
		move	a2, t6			#newtag**
                li      a3, 0      		 #new_tag_length*

                la      t9, find_tag	 
                jal     ra, t9

		bne	v0,zero,$is_eof		#return 
	
                lw      t1,CHILD_A0($fp)
                sw      t1,PARSE_T1($fp)
		
		lw	t6, CHILD_A2($fp)
		sw	t6, NEWTAG($fp)
		lw	t7, CHILD_A3($fp)
		sw	t7, NEWTAG_L($fp)
	
		lw	t1, PARSE_T1($fp)

//-------------------------------------------------------------------//
// aca deberia tener el new tag cargado
//-------------------------------------------------------------------//

		lw	a0, NEWTAG($fp)
		lw	a1, NEWTAG_L($fp)
		la	t9, is_begin_tag

		jal	ra,t9

		beq	v0, 0, $recursive
		
		lw	a0, PARSE_A2($fp)	#oldtag* 
		lw	a1, PARSE_A3($fp)	#oldtag_l
		lw	a2, NEWTAG($fp)		#newtag*
		lw	a3, NEWTAG_L($fp)	#newtag_l
		
		la	t9, compare_tags
		jal	ra, t9
		
		
		beq	v0, 0, $return_one 
		beq	v0, 1, $return_zero 

$is_eof:
		lw	a0, PARSE_A2($fp)
		lw	a1, PARSE_A3($fp)
		la	t9, is_begin_tag
		jal	ra, t9

		bne	v0, 0, $return_zero
		li	t0, 1
		move	a0, t0
		j	$build_message
		
$return_one: 

		li	t0, 2
		move	a0, t0

$build_message:		
		lw	t0, PARSE_A2($fp)
		move	a1, t0
		
		lw	t0, PARSE_A3($fp)
		move	a2, t0
		
		lw	t0, NEWTAG($fp)
		move	a3, t0

		lw	t0, NEWTAG_L($fp)
		sw	t0, CHILD_A4($fp)
		
		lw	t0, PARSE_A1($fp)
		sw	t0, CHILD_A5($fp)

		la	t9, create_message
		jal	ra, t9


		move	t1, v0
		li	v0, 1
		j	$end_parse

$return_zero:
		li	v0, 0
		li	t1, 0
		j	$end_parse

$recursive:
		lw	a0, PARSE_T1($fp)	#file*
		lw	a1, PARSE_A1($fp)	#line*
		lw	a2, NEWTAG($fp)		#newtag*
		lw	a3, NEWTAG_L($fp)	#newtag_length
		la	t9, parse
		jal	ra, t9

		move	t5, a0
		sw	t5, PARSE_T1($fp)
	
		lw	t1, CHILD_A4($fp)

		bne	v0, 0, $end_parse
		j	$while_parse
		
$end_parse:
                lw      a0, PARSE_T1($fp)
                lw      a1, PARSE_A1($fp)
                lw      a2, PARSE_A2($fp)
                lw      a3, PARSE_A3($fp)
		sw	t1, PARSE_A4($fp)


                move    sp, $fp
                lw      $fp, PARSE_FP(sp)
                lw      gp, PARSE_GP(sp)
                lw      ra, PARSE_RA(sp)
                addu    sp, sp, PARSE_SSIZE
                j       ra
                .end    parse

