! localized pulses of the quadratic-cubic Swift-Hohenberg equation
! 			0 = -(qc^2+Delta)^2 u - r u + nu u^2 -g u^3
!

!---------------------------------------------------------------------- 

      SUBROUTINE FUNC(NDIM,U,ICP,PAR,IJAC,F,DFDU,DFDP) 
!     ---------- ---- 
	IMPLICIT NONE
	INTEGER, INTENT(IN) :: NDIM, ICP(*), IJAC
	DOUBLE PRECISION, INTENT(IN) :: U(NDIM), PAR(*)
	DOUBLE PRECISION, INTENT(OUT) :: F(NDIM)
	DOUBLE PRECISION, INTENT(INOUT) :: DFDU(NDIM,NDIM), DFDP(NDIM,*)

	DOUBLE PRECISION u1,u2,u3,u4,r,nu,c,qc,g,eps,fu
	INTEGER j
	u1=U(1)
	u2=U(2)
	u3=U(3)
	u4=U(4)
	
	eps= PAR(2)
	r  = PAR(3)
	nu = PAR(4)
	qc = 0.5
	g  = 1.0
	
	fu= -nu*u1*u1+g*u1*u1*u1

	F(1)=u2-eps*(-nu*u1*u1+g*u1*u1*u1-2.0*qc*qc*u3)
	F(2)=u3+eps*(u2+u4)
	F(3)=u4+eps*u3
	F(4)=(r-qc*qc*qc*qc)*u1-(2.0)*qc*qc*u3 +nu*u1*u1-g*u1*u1*u1+PAR(5)*u2 +eps*u4

	do j=1,ndim
		F(j) = par(11)*F(j)
	end do


      END SUBROUTINE FUNC
!---------------------------------------------------------------------- 

      SUBROUTINE STPNT(NDIM,U,PAR,T) 
!     ---------- ----- 

      IMPLICIT NONE
      INTEGER, INTENT(IN) :: NDIM
      DOUBLE PRECISION, INTENT(INOUT) :: U(NDIM),PAR(*)
      DOUBLE PRECISION, INTENT(IN) :: T

	PAR(2)=0.001		!eps
	PAR(3)=0.4		!r
	PAR(4)=0.41		!nu
	PAR(5)=0.0		!c
!	PAR(6)=0.5		!qc
!	PAR(7)=1.0		!g
	PAR(11)=100.0	!6.2832*2 	!2*pi*	! period L=2*pi/qc 

	U(1)=0.
	U(2)=0.
	U(3)=0.
	U(4)=0.

      END SUBROUTINE STPNT
!---------------------------------------------------------------------- 

      SUBROUTINE BCND (NDIM,PAR,ICP,NBC,U0,U1,FB,IJAC,DBC)

	IMPLICIT NONE
	INTEGER, INTENT(IN) :: NDIM, ICP(*), NBC, IJAC
	DOUBLE PRECISION, INTENT(IN) :: PAR(*), U0(NDIM), U1(NDIM)
	DOUBLE PRECISION, INTENT(OUT) :: FB(NBC)
	DOUBLE PRECISION, INTENT(INOUT) :: DBC(NBC,*)
	! Periodic boundary conditions
!	FB(1) = (U0(1)-U1(1))*par(11)
!	FB(2) = (U0(2)-U1(2))*par(11)
!	FB(3) = (U0(3)-U1(3))*par(11)
!	FB(4) = (U0(4)-U1(4))*par(11)

      END SUBROUTINE BCND
!----------------------------------------------------------------------


     SUBROUTINE ICND(NDIM,PAR,ICP,NINT,U,UOLD,UDOT,UPOLD,FI,IJAC,DINT)
	IMPLICIT NONE
	INTEGER, INTENT(IN) :: NDIM, ICP(*), NINT, IJAC
	DOUBLE PRECISION, INTENT(IN) :: PAR(*)
	DOUBLE PRECISION, INTENT(IN) :: U(NDIM), UOLD(NDIM), UDOT(NDIM), UPOLD(NDIM)
	DOUBLE PRECISION, INTENT(OUT) :: FI(NINT)
	DOUBLE PRECISION, INTENT(INOUT) :: DINT(NINT,*)

!	FI(1)=UPOLD(1)*(U(1)-UOLD(1))	!PHASE CONDITION
!	FI(2)=U(1)*U(1)-PAR(6)		!L2-NORM
	
      END SUBROUTINE ICND

      SUBROUTINE FOPT 
      END SUBROUTINE FOPT

      SUBROUTINE PVLS
      END SUBROUTINE PVLS
