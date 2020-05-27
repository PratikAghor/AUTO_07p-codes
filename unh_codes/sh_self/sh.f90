!---------------------------------------------------------------------- 
!---------------------------------------------------------------------- 
!  Muensteranian Torturials on Nonlinear Science
!  edited by Uwe Thiele, Oliver Kamps, Svetlana Gurevich
!  (Center for Nonlinear Science, Universitaet Muenster)
!----------------------------------------------------------------------
!  Section: Continuation with auto07p
!  Tutorial: SH and SHPER: Steady states of the Swift-Hohenberg equation
!  by Uwe Thiele (www.uwethiele.de), supported by Frank Lengers
!  Version 1, October 2015
!  for complete set of files and up to date version see
!  www.uni-muenster.de/CeNoS/Lehre/Tutorials
!----------------------------------------------------------------------
!  File: sh.f90 - auto07p file for Swift-Hohenberg equation - steady
!  homogeneous and periodic states
!----------------------------------------------------------------------
!----------------------------------------------------------------------

      SUBROUTINE FUNC(NDIM,U,ICP,PAR,IJAC,F,DFDU,DFDP) 
!     ---------- ---- 

      IMPLICIT NONE
      INTEGER, INTENT(IN) :: NDIM, IJAC, ICP(*)
      REAL*8, INTENT(IN) :: U(NDIM), PAR(*)
      REAL*8, INTENT(OUT) :: F(NDIM), DFDU(NDIM,*), DFDP(NDIM,*)
      REAL*8 :: PHI,PHIX,PHIXX,PHIXXX,TPI,EPS,RR,PER,C1,ALP,VV,GG,QQ,FPHI

      PHI  = U(1)
      PHIX  = U(2)
      PHIXX = U(3)
      PHIXXX = U(4)

      TPI = 8.0*ATAN(1.0d0)
      EPS = PAR(2)
      RR  = PAR(3)
      QQ  = PAR(4)
      VV  = PAR(6)
      GG  = PAR(7)
      
      FPHI  = -VV*PHI**2.0d0 +GG*PHI**3.d0

      F(1) = (PHIX - EPS * (FPHI - 2.0d0*QQ**2.0d0*PHIXX))
      F(2) = (PHIXX + EPS*(PHIX+PHIXXX))
      F(3) = (PHIXXX + EPS*PHIXX)
      F(4) = (-2.0d0*QQ**2*PHIXX + (RR-QQ**4.d0)*PHI - FPHI + EPS*PHIXXX)

!!$     eps terms make system pseudo dissipative allowing for non-degenerate 
!!$       solution families that AUTO can follow, eps is used as continuation param. 
!!$       but automatically kept as zero -> CHECK, especially for 
!!$       bifurcated branches 

      END SUBROUTINE FUNC

      SUBROUTINE STPNT(NDIM,U,PAR,T) 
!     ---------- ----- 

      IMPLICIT NONE
      INTEGER, INTENT(IN) :: NDIM
      DOUBLE PRECISION, INTENT(INOUT) :: U(NDIM), PAR(*)
      DOUBLE PRECISION, INTENT(IN) :: T
      DOUBLE PRECISION PHI,PHIX,PHIXX,PHIXXX,TPI,EPS,RR,PER,C1,ALP,VV,GG,QQ,FPHI
      DOUBLE PRECISION FPHIPHI0,AMPL,NN

       TPI = 8.0*ATAN(1.0)
       EPS= 0.0d0
       RR = 0.4d0
       QQ = 0.5d0  ! wavenumber at onset, value as BuKn2006pre
       VV = 0.41d0  ! prefactor of quadratic nonlinearity, value as BuKn06
       GG = 1.0d0  ! prefactor of cubic nonlinearity, value as BuKn06

       PAR(2) = EPS                 
       PAR(3) = RR                
       PAR(4) = QQ
       PAR(6) = VV
       PAR(7) = GG
!       PAR(9) = 0.0  	            ! energy
!       PAR(10) = GG0 -GPHI0*PHI0  	            ! grand potential equivalent to pressure
       PAR(11) = 1.0d0  ! INTERNAL PERIOD (NOT USED OR CHANGED)

       U(1) = 0.0d0
       U(2) = 0.0d0
       U(3) = 0.0d0
       U(4) = 0.0d0

      END SUBROUTINE STPNT

      SUBROUTINE BCND(NDIM,PAR,ICP,NBC,U0,U1,FB,IJAC,DBC) 
!     ---------- ---- 

      IMPLICIT NONE
      INTEGER, INTENT(IN) :: NDIM, ICP(*), NBC, IJAC
      DOUBLE PRECISION, INTENT(IN) :: PAR(*), U0(NDIM), U1(NDIM)
      DOUBLE PRECISION, INTENT(OUT) :: FB(NBC)
      DOUBLE PRECISION, INTENT(INOUT) :: DBC(NBC,*)

!      FB(1)=U0(1)-U1(1); 
!      FB(2)=U0(2)-U1(2); 
!      FB(3)=U0(3)-U1(3); 
!      FB(4)=U0(4)-U1(4); 

      END SUBROUTINE BCND

       SUBROUTINE ICND(NDIM,PAR,ICP,NINT,U,UOLD,UDOT,UPOLD,FI,IJAC,DINT)
!      ---------- ----

       IMPLICIT NONE
       INTEGER, INTENT(IN) :: NDIM, ICP(*), NINT, IJAC
       DOUBLE PRECISION, INTENT(IN) :: PAR(*)
       DOUBLE PRECISION, INTENT(IN) :: U(NDIM), UOLD(NDIM), UDOT(NDIM), UPOLD(NDIM)
       DOUBLE PRECISION, INTENT(OUT) :: FI(NINT)
       DOUBLE PRECISION, INTENT(INOUT) :: DINT(NINT,*)
       DOUBLE PRECISION PHI0,GG,GG0,PHI,PHIX,PHIXX,RR,QQ,C1
       
!      PHI  = U(1)
!      PHIX  = U(2)
!      PHIXX = U(3)

! integral pinning condition to break Translationssym. of homogeneous substrate
!       FI(1) = U(1)*UPOLD(1)
! fix mean thickness to H0, i.e. mean of U(1) is zero
!       IF (NINT>1)  FI(2) = U(1) - 0.0
!    energy defined as PAR(9)
!!$       RR  = PAR(3)
!!$       QQ  = PAR(4)
!!$       C1  = PAR(6)
!!$       GG  = (QQ**(4.0) + RR)*PHI**2.0/2.0 + PHI**4.0/4.0
!!$       GG0  = (QQ**(4.0) + RR)*PHI0**2.0/2.0 + PHI0**4.0/4.0
!!$
!!$       IF (NINT>2)  FI(3) = GG - GG0 + QQ**2.0*PHI*PHIXX + PHIXX*PHIXX/2. - PAR(9)
!!$       IF (NINT>3)  FI(4) = GG + QQ**2.0*PHI*PHIXX + PHIXX*PHIXX/2. + C1*PHI - PAR(10)

       ! other options for integral pinning condition
       !       FI(2)=UOLD(1)*U(2) 
       !       FI(2)=U(2)*UPOLD(2) 
       !       FI(2)=U(1)*UOLD(2) 
       !       FI(2)=U(2)*UOLD(3) 
       END SUBROUTINE ICND

      DOUBLE PRECISION FUNCTION GETU2(U,NDX,NTST,NCOL)
!     ------ --------- -------- -----
      INTEGER, INTENT(IN) :: NDX,NCOL,NTST
      DOUBLE PRECISION, INTENT(IN) :: U(NDX,0:NCOL*NTST)

        GETU2 = U(2,0)

      END FUNCTION GETU2

      SUBROUTINE PVLS(NDIM,U,PAR)
!     ---------- ----

      IMPLICIT NONE
      INTEGER, INTENT(IN) :: NDIM
      DOUBLE PRECISION, INTENT(IN) :: U(NDIM)
      DOUBLE PRECISION, INTENT(INOUT) :: PAR(*)

      DOUBLE PRECISION, EXTERNAL :: GETP,GETU2
      INTEGER NDX,NCOL,NTST
!---------------------------------------------------------------------- 
! NOTE : 
! Parameters set in this subroutine should be considered as ``solution 
! measures'' and be used for output purposes only.
! 
! They should never be used as `true'' continuation parameters. 
!
! They may, however, be added as ``over-specified parameters'' in the 
! parameter list associated with the AUTO-Constant NICP, in order to 
! print their values on the screen and in the ``p.xxx file.
!
! They may also appear in the list associated with AUTO-constant NUZR.
!
!---------------------------------------------------------------------- 
! For algebraic problems the argument U is, as usual, the state vector.
! For differential equations the argument U represents the approximate 
! solution on the entire interval [0,1]. In this case its values can
! be accessed indirectly by calls to GETP, as illustrated below, or
! by obtaining NDIM, NCOL, NTST via GETP and then dimensioning U as
! U(NDIM,0:NCOL*NTST) in a seperate subroutine that is called by PVLS.
!---------------------------------------------------------------------- 

! Set PAR(40) equal to the Amplitude of U(0)
!       PAR(40) = getp("MAX", 1, U)-getp("MIN", 1, U)

! Set PAR(41) equal to the Integral of U(0)
!       PAR(41) = getp("INT", 1,U)

! Set PAR(46) equal to the maximal slope of profile
!       PAR(46) = getp("MIN", 2,U)
!       PAR(47) = getp("MAX", 2,U)

! Set PAR(48) equal to the value of U(2) at the left boundary using
! another method
!       NDX = NINT(GETP('NDX',0,U))
!       NTST = NINT(GETP('NTST',0,U))
!       NCOL = NINT(GETP('NCOL',0,U))
!       PAR(5) = GETU2(U,NDX,NTST,NCOL)
!---------------------------------------------------------------------- 
! The first argument of GETP may be one of the following:
!        'NRM' (L2-norm),     'MAX' (maximum),
!        'INT' (integral),    'BV0 (left boundary value),
!        'MIN' (minimum),     'BV1' (right boundary value).
!        'MNT' (t value for minimum)
!        'MXT' (t value for maximum)
!        'NDIM', 'NDX' (effective (active) number of dimensions)
!        'NTST' (NTST from constant file)
!        'NCOL' (NCOL from constant file)
!        'NBC'  (active NBC)
!        'NINT' (active NINT)
!        'DTM'  (delta t for all t values, I=1...NTST)
!        'WINT' (integration weights used for interpolation, I=0...NCOL)
!
! Also available are
!   'STP' (Pseudo-arclength step size used).
!   'FLD' (`Fold function', which vanishes at folds).
!   'BIF' (`Bifurcation function', which vanishes at singular points).
!   'HBF' (`Hopf function'; which vanishes at Hopf points).
!   'SPB' ( Function which vanishes at secondary periodic bifurcations).
!   'EIG' ( Eigenvalues/multipliers, I=1...2*NDIM, alternates real/imag parts).
!   'STA' ( Number of stable eigenvalues/multipliers).
!---------------------------------------------------------------------- 

      END SUBROUTINE PVLS

      SUBROUTINE FOPT 
      END SUBROUTINE FOPT
