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
!  File: shper.f90 - auto07p file for Swift-Hohenberg equation - steady
!  localized states
!----------------------------------------------------------------------
!----------------------------------------------------------------------

      SUBROUTINE FUNC(NDIM,U,ICP,PAR,IJAC,F,DFDU,DFDP) 
!     ---------- ---- 

      IMPLICIT NONE
      INTEGER, INTENT(IN) :: NDIM, IJAC, ICP(*)
      DOUBLE PRECISION, INTENT(IN) :: U(NDIM), PAR(*)
      DOUBLE PRECISION, INTENT(OUT) :: F(NDIM), DFDU(NDIM,*), DFDP(NDIM,*)
      DOUBLE PRECISION PHI,PHIX,PHIXX,PHIXXX,TPI,EPS,RR,PER,VV,GG,QQ,FPHI,PHI0,MU
       
      PHI0 = PAR(1)

      PHI  = PHI0+U(1) 
      PHIX  = U(2)
      PHIXX = U(3)
      PHIXXX = U(4)

      TPI = 8.0*ATAN(1.0)
      RR  = PAR(3)
      EPS = PAR(2)
      QQ  = PAR(4)
      PER = PAR(5)
      VV  = PAR(6)
      GG  = PAR(7)
      MU  = PAR(8)
      FPHI  = -VV*PHI**2 +GG*PHI**3


       F(1) = PER*(PHIX - EPS * (FPHI - 2.0*QQ**2.0*PHIXX))
       F(2) = PER*(PHIXX + EPS*(PHIX+PHIXXX))
       F(3) = PER*(PHIXXX + EPS*PHIXX)
       F(4) = PER*(-2.0*QQ**2*PHIXX + (RR-QQ**4)*PHI - FPHI + EPS*PHIXXX)

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
      DOUBLE PRECISION PHI,PHIX,PHIXX,PHIXXX,TPI,EPS,RR,PER,C1,ALP,VV,GG,QQ,FPHI,PHI0,MU
      DOUBLE PRECISION FPHIPHI0,AMPL,NN,FPHI0

       TPI=8.0*ATAN(1.0)
       PHI0 = 0.0 ! starting value of PHI
       EPS= 0.0
       RR = -0.01245   !! run 1-2 
!       RR = 0.05       !! run 3-5
       QQ = 0.5  ! wavenumber at onset, value as BuKn06
       VV = 0.41  ! prefactor of quadratic nonlinearity, value as BuKn06
       GG = 1.0  ! prefactor of cubic nonlinearity, value as BuKn06
       PER= 200.0   !!only run 1-2

       !!Different starting point for run 3-5
        !how many periods do you want to follow, nn=1:
        !one-bump solutions, nn=2: two-bump solutions, etc., useful to get
        !bifurcations to branches that break the discrete translational symmetry
        !for nn>1
       FPHI0=-VV*PHI0**2+GG*PHI0**3
       FPHIPHI0=-2.0*VV*PHI+3.0*GG*PHI**2
       MU= PHI0*(RR-QQ**4)-FPHI0

	!!for run 3-5
!       NN =1.0 
!       PER=NN*TPI/SQRT(QQ**2+SQRT(RR-FPHIPHI0)) !k+
!       PER=NN*TPI/SQRT(QQ**2-SQRT(RR-FPHIPHI0)) !k-
      
        PAR(1)= PHI0
        PAR(2) = EPS
        PAR(3) = RR
        PAR(4) = QQ
        PAR(5) = PER
        PAR(6) = VV
        PAR(7)=GG
        PAR(8) = MU
        PAR(11) = 1.0
!       small amplitude starting solution for run 3-5
!        AMPL=0.00000001
!        U(1)=AMPL*SIN(NN*TPI*T)
!        U(2)=AMPL*NN*TPI*COS(NN*TPI*T)
!        U(3)=-AMPL*NN*NN*TPI*TPI*SIN(NN*TPI*T)
!        U(4)=-AMPL*NN**3*TPI**3*COS(NN*TPI*T)
      END SUBROUTINE STPNT

      SUBROUTINE BCND(NDIM,PAR,ICP,NBC,U0,U1,FB,IJAC,DBC) 
!     ---------- ---- 

      IMPLICIT NONE
      INTEGER, INTENT(IN) :: NDIM, ICP(*), NBC, IJAC
      DOUBLE PRECISION, INTENT(IN) :: PAR(*), U0(NDIM), U1(NDIM)
      DOUBLE PRECISION, INTENT(OUT) :: FB(NBC)
      DOUBLE PRECISION, INTENT(INOUT) :: DBC(NBC,*)

      FB(1)=U0(1)-U1(1); 
      FB(2)=U0(2)-U1(2); 
      FB(3)=U0(3)-U1(3); 
      FB(4)=U0(4)-U1(4); 

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
 
! integral pinning condition to break Translationssym. of homogeneous substrate
       FI(1) = U(1)*UPOLD(1)

! fix mean thickness to H0, i.e. mean of U(1) is zero
      IF (NINT>1)  FI(2) = U(1) - 0.0
       END SUBROUTINE ICND


      SUBROUTINE PVLS(NDIM,U,PAR)
      END SUBROUTINE PVLS

      SUBROUTINE FOPT 
      END SUBROUTINE FOPT
