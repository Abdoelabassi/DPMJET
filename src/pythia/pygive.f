cc ------------ dpmjet3.4 - authors: S.Roesler, R.Engel, J.Ranft -------
cc -------- phojet1.12-40 - authors: S.Roesler, R.Engel, J.Ranft -------
cc                                                      - oct'13 -------
cc ----------- pythia-6.4 - authors: Torbjorn Sjostrand, Lund'10 -------
cc ---------------------------------------------------------------------
cc                                  converted for use with FLUKA -------
cc                                                      - oct'13 -------
 
C...PYGIVE
C...Sets values of commonblock variables.
 
      SUBROUTINE PYGIVE(CHIN)
 
C...Double precision and integer declarations.
      IMPLICIT DOUBLE PRECISION(A-H, O-Z)
      IMPLICIT INTEGER(I-N)
      INTEGER PYCOMP

C...Commonblocks.
      include 'inc/pyjets'
      include 'inc/pydat1'
      include 'inc/pydat2'
      include 'inc/pydat3'
      include 'inc/pydat4'
      include 'inc/pydatr'
      include 'inc/pysubs'
      include 'inc/pypars'
      include 'inc/pyint1'
      include 'inc/pyint2'
      include 'inc/pyint3'
      include 'inc/pyint4'
      include 'inc/pyint5'
      include 'inc/pyint6'
      include 'inc/pyint7'
      include 'inc/pyint8'
      include 'inc/pymssm'
      include 'inc/pymsrv'
      include 'inc/pytcsm'
      include 'inc/pypued'

C...Local arrays and character variables.
      CHARACTER CHIN*(*),CHFIX*104,CHBIT*104,CHOLD*8,CHNEW*8,CHOLD2*28,
     &CHNEW2*28,CHNAM*6,CHVAR(56)*6,CHALP(2)*26,CHIND*8,CHINI*10,
     &CHINR*16,CHDIG*10
      DIMENSION MSVAR(56,8)
 
C...For each variable to be translated give: name,
C...integer/real/character, no. of indices, lower&upper index bounds.
      DATA CHVAR/'N','K','P','V','MSTU','PARU','MSTJ','PARJ','KCHG',
     &'PMAS','PARF','VCKM','MDCY','MDME','BRAT','KFDP','CHAF','MRPY',
     &'RRPY','MSEL','MSUB','KFIN','CKIN','MSTP','PARP','MSTI','PARI',
     &'MINT','VINT','ISET','KFPR','COEF','ICOL','XSFX','ISIG','SIGH',
     &'MWID','WIDS','NGEN','XSEC','PROC','SIGT','XPVMD','XPANL',
     &'XPANH','XPBEH','XPDIR','IMSS','RMSS','RVLAM','RVLAMP','RVLAMB',
     &'ITCM','RTCM','IUED','RUED'/
      DATA ((MSVAR(I,J),J=1,8),I=1,56)/ 1,7*0,  1,2,1,4000,1,5,2*0,
     &2,2,1,4000,1,5,2*0,  2,2,1,4000,1,5,2*0,  1,1,1,200,4*0,
     &2,1,1,200,4*0,  1,1,1,200,4*0,  2,1,1,200,4*0,
     &1,2,1,500,1,4,2*0,  2,2,1,500,1,4,2*0,  2,1,1,2000,4*0,
     &2,2,1,4,1,4,2*0,  1,2,1,500,1,3,2*0,  1,2,1,8000,1,2,2*0,
     &2,1,1,8000,4*0,  1,2,1,8000,1,5,2*0,  3,2,1,500,1,2,2*0,
     &1,1,1,6,4*0,  2,1,1,100,4*0,
     &1,7*0,  1,1,1,500,4*0,  1,2,1,2,-40,40,2*0,  2,1,1,200,4*0,
     &1,1,1,200,4*0,  2,1,1,200,4*0,  1,1,1,200,4*0,  2,1,1,200,4*0,
     &1,1,1,400,4*0,  2,1,1,400,4*0,  1,1,1,500,4*0,
     &1,2,1,500,1,2,2*0,  2,2,1,500,1,20,2*0,  1,3,1,40,1,4,1,2,
     &2,2,1,2,-40,40,2*0,  1,2,1,1000,1,3,2*0,  2,1,1,1000,4*0,
     &1,1,1,500,4*0,   2,2,1,500,1,5,2*0,   1,2,0,500,1,3,2*0,
     &2,2,0,500,1,3,2*0,   4,1,0,500,4*0,   2,3,0,6,0,6,0,5,
     &2,1,-6,6,4*0,     2,1,-6,6,4*0,    2,1,-6,6,4*0,
     &2,1,-6,6,4*0,  2,1,-6,6,4*0,  1,1,0,99,4*0,  2,1,0,99,4*0,
     &2,3,1,3,1,3,1,3,   2,3,1,3,1,3,1,3,   2,3,1,3,1,3,1,3,
     &1,1,0,99,4*0,  2,1,0,99,4*0,  1,1,0,99,4*0,  2,1,0,99,4*0/
      DATA CHALP/'abcdefghijklmnopqrstuvwxyz',
     &'ABCDEFGHIJKLMNOPQRSTUVWXYZ'/, CHDIG/'1234567890'/
 
C...Length of character variable. Subdivide it into instructions.
      IF(MSTU(12).NE.12345.AND.CHIN.NE.'mstu(12)=12345'.AND.
     &CHIN.NE.'MSTU(12)=12345') CALL PYLIST(0)
      CHBIT=CHIN//' '
      LBIT=101
  100 LBIT=LBIT-1
      IF(CHBIT(LBIT:LBIT).EQ.' ') GOTO 100
      LTOT=0
      DO 110 LCOM=1,LBIT
        IF(CHBIT(LCOM:LCOM).EQ.' ') GOTO 110
        LTOT=LTOT+1
        CHFIX(LTOT:LTOT)=CHBIT(LCOM:LCOM)
  110 CONTINUE
      LLOW=0
  120 LHIG=LLOW+1
  130 LHIG=LHIG+1
      IF(LHIG.LE.LTOT.AND.CHFIX(LHIG:LHIG).NE.';') GOTO 130
      LBIT=LHIG-LLOW-1
      CHBIT(1:LBIT)=CHFIX(LLOW+1:LHIG-1)

C...Send off decay-mode on/off commands to PYONOF.
      IONOF=0
      DO 135 LDIG=1,10
        IF(CHBIT(1:1).EQ.CHDIG(LDIG:LDIG)) IONOF=1
  135 CONTINUE
      IF(IONOF.EQ.1) THEN
        CALL PYONOF(CHIN)
        RETURN
      ENDIF   
 
C...Peel off any text following exclamation mark.
      LHIG2=LBIT
      DO 140 LLOW2=LHIG2,1,-1
        IF(CHBIT(LLOW2:LLOW2).EQ.'!') LBIT=LLOW2-1
  140 CONTINUE
      IF(LBIT.EQ.0) RETURN
 
C...Identify commonblock variable.
      LNAM=1
  150 LNAM=LNAM+1
      IF(CHBIT(LNAM:LNAM).NE.'('.AND.CHBIT(LNAM:LNAM).NE.'='.AND.
     &LNAM.LE.6) GOTO 150
      CHNAM=CHBIT(1:LNAM-1)//' '
      DO 170 LCOM=1,LNAM-1
        DO 160 LALP=1,26
          IF(CHNAM(LCOM:LCOM).EQ.CHALP(1)(LALP:LALP)) CHNAM(LCOM:LCOM)=
     &    CHALP(2)(LALP:LALP)
  160   CONTINUE
  170 CONTINUE
      IVAR=0
      DO 180 IV=1,56
        IF(CHNAM.EQ.CHVAR(IV)) IVAR=IV
  180 CONTINUE
      IF(IVAR.EQ.0) THEN
        CALL PYERRM(18,'(PYGIVE:) do not recognize variable '//CHNAM)
        LLOW=LHIG
        IF(LLOW.LT.LTOT) GOTO 120
        RETURN
      ENDIF
 
C...Identify any indices.
      I1=0
      I2=0
      I3=0
      NINDX=0
      IF(CHBIT(LNAM:LNAM).EQ.'(') THEN
        LIND=LNAM
  190   LIND=LIND+1
        IF(CHBIT(LIND:LIND).NE.')'.AND.CHBIT(LIND:LIND).NE.',') GOTO 190
        CHIND=' '
        IF((CHBIT(LNAM+1:LNAM+1).EQ.'C'.OR.CHBIT(LNAM+1:LNAM+1).EQ.'c')
     &  .AND.(IVAR.EQ.9.OR.IVAR.EQ.10.OR.IVAR.EQ.13.OR.IVAR.EQ.17.OR.
     &  IVAR.EQ.37)) THEN
          CHIND(LNAM-LIND+11:8)=CHBIT(LNAM+2:LIND-1)
          READ(CHIND,'(I8)') KF
          I1=PYCOMP(KF)
        ELSEIF(CHBIT(LNAM+1:LNAM+1).EQ.'C'.OR.CHBIT(LNAM+1:LNAM+1).EQ.
     &    'c') THEN
          CALL PYERRM(18,'(PYGIVE:) not allowed to use C index for '//
     &    CHNAM)
          LLOW=LHIG
          IF(LLOW.LT.LTOT) GOTO 120
          RETURN
        ELSE
          CHIND(LNAM-LIND+10:8)=CHBIT(LNAM+1:LIND-1)
          READ(CHIND,'(I8)') I1
        ENDIF
        LNAM=LIND
        IF(CHBIT(LNAM:LNAM).EQ.')') LNAM=LNAM+1
        NINDX=1
      ENDIF
      IF(CHBIT(LNAM:LNAM).EQ.',') THEN
        LIND=LNAM
  200   LIND=LIND+1
        IF(CHBIT(LIND:LIND).NE.')'.AND.CHBIT(LIND:LIND).NE.',') GOTO 200
        CHIND=' '
        CHIND(LNAM-LIND+10:8)=CHBIT(LNAM+1:LIND-1)
        READ(CHIND,'(I8)') I2
        LNAM=LIND
        IF(CHBIT(LNAM:LNAM).EQ.')') LNAM=LNAM+1
        NINDX=2
      ENDIF
      IF(CHBIT(LNAM:LNAM).EQ.',') THEN
        LIND=LNAM
  210   LIND=LIND+1
        IF(CHBIT(LIND:LIND).NE.')'.AND.CHBIT(LIND:LIND).NE.',') GOTO 210
        CHIND=' '
        CHIND(LNAM-LIND+10:8)=CHBIT(LNAM+1:LIND-1)
        READ(CHIND,'(I8)') I3
        LNAM=LIND+1
        NINDX=3
      ENDIF
 
C...Check that indices allowed.
      IERR=0
      IF(NINDX.NE.MSVAR(IVAR,2)) IERR=1
      IF(NINDX.GE.1.AND.(I1.LT.MSVAR(IVAR,3).OR.I1.GT.MSVAR(IVAR,4)))
     &IERR=2
      IF(NINDX.GE.2.AND.(I2.LT.MSVAR(IVAR,5).OR.I2.GT.MSVAR(IVAR,6)))
     &IERR=3
      IF(NINDX.EQ.3.AND.(I3.LT.MSVAR(IVAR,7).OR.I3.GT.MSVAR(IVAR,8)))
     &IERR=4
      IF(CHBIT(LNAM:LNAM).NE.'=') IERR=5
      IF(IERR.GE.1) THEN
        CALL PYERRM(18,'(PYGIVE:) unallowed indices for '//
     &  CHBIT(1:LNAM-1))
        LLOW=LHIG
        IF(LLOW.LT.LTOT) GOTO 120
        RETURN
      ENDIF
 
C...Save old value of variable.
      IF(IVAR.EQ.1) THEN
        IOLD=N
      ELSEIF(IVAR.EQ.2) THEN
        IOLD=K(I1,I2)
      ELSEIF(IVAR.EQ.3) THEN
        ROLD=P(I1,I2)
      ELSEIF(IVAR.EQ.4) THEN
        ROLD=V(I1,I2)
      ELSEIF(IVAR.EQ.5) THEN
        IOLD=MSTU(I1)
      ELSEIF(IVAR.EQ.6) THEN
        ROLD=PARU(I1)
      ELSEIF(IVAR.EQ.7) THEN
        IOLD=MSTJ(I1)
      ELSEIF(IVAR.EQ.8) THEN
        ROLD=PARJ(I1)
      ELSEIF(IVAR.EQ.9) THEN
        IOLD=KCHG(I1,I2)
      ELSEIF(IVAR.EQ.10) THEN
        ROLD=PMAS(I1,I2)
      ELSEIF(IVAR.EQ.11) THEN
        ROLD=PARF(I1)
      ELSEIF(IVAR.EQ.12) THEN
        ROLD=VCKM(I1,I2)
      ELSEIF(IVAR.EQ.13) THEN
        IOLD=MDCY(I1,I2)
      ELSEIF(IVAR.EQ.14) THEN
        IOLD=MDME(I1,I2)
      ELSEIF(IVAR.EQ.15) THEN
        ROLD=BRAT(I1)
      ELSEIF(IVAR.EQ.16) THEN
        IOLD=KFDP(I1,I2)
      ELSEIF(IVAR.EQ.17) THEN
        CHOLD=CHAF(I1,I2)(1:8)
      ELSEIF(IVAR.EQ.18) THEN
        IOLD=MRPY(I1)
      ELSEIF(IVAR.EQ.19) THEN
        ROLD=RRPY(I1)
      ELSEIF(IVAR.EQ.20) THEN
        IOLD=MSEL
      ELSEIF(IVAR.EQ.21) THEN
        IOLD=MSUB(I1)
      ELSEIF(IVAR.EQ.22) THEN
        IOLD=KFIN(I1,I2)
      ELSEIF(IVAR.EQ.23) THEN
        ROLD=CKIN(I1)
      ELSEIF(IVAR.EQ.24) THEN
        IOLD=MSTP(I1)
      ELSEIF(IVAR.EQ.25) THEN
        ROLD=PARP(I1)
      ELSEIF(IVAR.EQ.26) THEN
        IOLD=MSTI(I1)
      ELSEIF(IVAR.EQ.27) THEN
        ROLD=PARI(I1)
      ELSEIF(IVAR.EQ.28) THEN
        IOLD=MINT(I1)
      ELSEIF(IVAR.EQ.29) THEN
        ROLD=VINT(I1)
      ELSEIF(IVAR.EQ.30) THEN
        IOLD=ISET(I1)
      ELSEIF(IVAR.EQ.31) THEN
        IOLD=KFPR(I1,I2)
      ELSEIF(IVAR.EQ.32) THEN
        ROLD=COEF(I1,I2)
      ELSEIF(IVAR.EQ.33) THEN
        IOLD=ICOL(I1,I2,I3)
      ELSEIF(IVAR.EQ.34) THEN
        ROLD=XSFX(I1,I2)
      ELSEIF(IVAR.EQ.35) THEN
        IOLD=ISIG(I1,I2)
      ELSEIF(IVAR.EQ.36) THEN
        ROLD=SIGH(I1)
      ELSEIF(IVAR.EQ.37) THEN
        IOLD=MWID(I1)
      ELSEIF(IVAR.EQ.38) THEN
        ROLD=WIDS(I1,I2)
      ELSEIF(IVAR.EQ.39) THEN
        IOLD=NGEN(I1,I2)
      ELSEIF(IVAR.EQ.40) THEN
        ROLD=XSEC(I1,I2)
      ELSEIF(IVAR.EQ.41) THEN
        CHOLD2=PROC(I1)
      ELSEIF(IVAR.EQ.42) THEN
        ROLD=SIGT(I1,I2,I3)
      ELSEIF(IVAR.EQ.43) THEN
        ROLD=XPVMD(I1)
      ELSEIF(IVAR.EQ.44) THEN
        ROLD=XPANL(I1)
      ELSEIF(IVAR.EQ.45) THEN
        ROLD=XPANH(I1)
      ELSEIF(IVAR.EQ.46) THEN
        ROLD=XPBEH(I1)
      ELSEIF(IVAR.EQ.47) THEN
        ROLD=XPDIR(I1)
      ELSEIF(IVAR.EQ.48) THEN
        IOLD=IMSS(I1)
      ELSEIF(IVAR.EQ.49) THEN
        ROLD=RMSS(I1)
      ELSEIF(IVAR.EQ.50) THEN
        ROLD=RVLAM(I1,I2,I3)
      ELSEIF(IVAR.EQ.51) THEN
        ROLD=RVLAMP(I1,I2,I3)
      ELSEIF(IVAR.EQ.52) THEN
        ROLD=RVLAMB(I1,I2,I3)
      ELSEIF(IVAR.EQ.53) THEN
        IOLD=ITCM(I1)
      ELSEIF(IVAR.EQ.54) THEN
        ROLD=RTCM(I1)
      ELSEIF(IVAR.EQ.55) THEN
        IOLD=IUED(I1)
      ELSEIF(IVAR.EQ.56) THEN
        ROLD=RUED(I1)
      ENDIF
 
C...Print current value of variable. Loop back.
      IF(LNAM.GE.LBIT) THEN
        CHBIT(LNAM:14)=' '
        CHBIT(15:60)=' has the value                                '
        IF(MSVAR(IVAR,1).EQ.1) THEN
          WRITE(CHBIT(51:60),'(I10)') IOLD
        ELSEIF(MSVAR(IVAR,1).EQ.2) THEN
          WRITE(CHBIT(47:60),'(F14.5)') ROLD
        ELSEIF(MSVAR(IVAR,1).EQ.3) THEN
          CHBIT(53:60)=CHOLD
        ELSE
          CHBIT(33:60)=CHOLD
        ENDIF
        IF(MSTU(13).GE.1) WRITE(MSTU(11),5000) CHBIT(1:60)
        LLOW=LHIG
        IF(LLOW.LT.LTOT) GOTO 120
        RETURN
      ENDIF
 
C...Read in new variable value.
      IF(MSVAR(IVAR,1).EQ.1) THEN
        CHINI=' '
        CHINI(LNAM-LBIT+11:10)=CHBIT(LNAM+1:LBIT)
        READ(CHINI,'(I10)') INEW
      ELSEIF(MSVAR(IVAR,1).EQ.2) THEN
        CHINR=' '
        CHINR(LNAM-LBIT+17:16)=CHBIT(LNAM+1:LBIT)
        READ(CHINR,*) RNEW
      ELSEIF(MSVAR(IVAR,1).EQ.3) THEN
        CHNEW=CHBIT(LNAM+1:LBIT)//' '
      ELSE
        CHNEW2=CHBIT(LNAM+1:LBIT)//' '
      ENDIF
 
C...Store new variable value.
      IF(IVAR.EQ.1) THEN
        N=INEW
      ELSEIF(IVAR.EQ.2) THEN
        K(I1,I2)=INEW
      ELSEIF(IVAR.EQ.3) THEN
        P(I1,I2)=RNEW
      ELSEIF(IVAR.EQ.4) THEN
        V(I1,I2)=RNEW
      ELSEIF(IVAR.EQ.5) THEN
        MSTU(I1)=INEW
      ELSEIF(IVAR.EQ.6) THEN
        PARU(I1)=RNEW
      ELSEIF(IVAR.EQ.7) THEN
        MSTJ(I1)=INEW
      ELSEIF(IVAR.EQ.8) THEN
        PARJ(I1)=RNEW
      ELSEIF(IVAR.EQ.9) THEN
        KCHG(I1,I2)=INEW
      ELSEIF(IVAR.EQ.10) THEN
        PMAS(I1,I2)=RNEW
      ELSEIF(IVAR.EQ.11) THEN
        PARF(I1)=RNEW
      ELSEIF(IVAR.EQ.12) THEN
        VCKM(I1,I2)=RNEW
      ELSEIF(IVAR.EQ.13) THEN
        MDCY(I1,I2)=INEW
      ELSEIF(IVAR.EQ.14) THEN
        MDME(I1,I2)=INEW
      ELSEIF(IVAR.EQ.15) THEN
        BRAT(I1)=RNEW
      ELSEIF(IVAR.EQ.16) THEN
        KFDP(I1,I2)=INEW
      ELSEIF(IVAR.EQ.17) THEN
        CHAF(I1,I2)=CHNEW
      ELSEIF(IVAR.EQ.18) THEN
        MRPY(I1)=INEW
      ELSEIF(IVAR.EQ.19) THEN
        RRPY(I1)=RNEW
      ELSEIF(IVAR.EQ.20) THEN
        MSEL=INEW
      ELSEIF(IVAR.EQ.21) THEN
        MSUB(I1)=INEW
      ELSEIF(IVAR.EQ.22) THEN
        KFIN(I1,I2)=INEW
      ELSEIF(IVAR.EQ.23) THEN
        CKIN(I1)=RNEW
      ELSEIF(IVAR.EQ.24) THEN
        MSTP(I1)=INEW
      ELSEIF(IVAR.EQ.25) THEN
        PARP(I1)=RNEW
      ELSEIF(IVAR.EQ.26) THEN
        MSTI(I1)=INEW
      ELSEIF(IVAR.EQ.27) THEN
        PARI(I1)=RNEW
      ELSEIF(IVAR.EQ.28) THEN
        MINT(I1)=INEW
      ELSEIF(IVAR.EQ.29) THEN
        VINT(I1)=RNEW
      ELSEIF(IVAR.EQ.30) THEN
        ISET(I1)=INEW
      ELSEIF(IVAR.EQ.31) THEN
        KFPR(I1,I2)=INEW
      ELSEIF(IVAR.EQ.32) THEN
        COEF(I1,I2)=RNEW
      ELSEIF(IVAR.EQ.33) THEN
        ICOL(I1,I2,I3)=INEW
      ELSEIF(IVAR.EQ.34) THEN
        XSFX(I1,I2)=RNEW
      ELSEIF(IVAR.EQ.35) THEN
        ISIG(I1,I2)=INEW
      ELSEIF(IVAR.EQ.36) THEN
        SIGH(I1)=RNEW
      ELSEIF(IVAR.EQ.37) THEN
        MWID(I1)=INEW
      ELSEIF(IVAR.EQ.38) THEN
        WIDS(I1,I2)=RNEW
      ELSEIF(IVAR.EQ.39) THEN
        NGEN(I1,I2)=INEW
      ELSEIF(IVAR.EQ.40) THEN
        XSEC(I1,I2)=RNEW
      ELSEIF(IVAR.EQ.41) THEN
        PROC(I1)=CHNEW2
      ELSEIF(IVAR.EQ.42) THEN
        SIGT(I1,I2,I3)=RNEW
      ELSEIF(IVAR.EQ.43) THEN
        XPVMD(I1)=RNEW
      ELSEIF(IVAR.EQ.44) THEN
        XPANL(I1)=RNEW
      ELSEIF(IVAR.EQ.45) THEN
        XPANH(I1)=RNEW
      ELSEIF(IVAR.EQ.46) THEN
        XPBEH(I1)=RNEW
      ELSEIF(IVAR.EQ.47) THEN
        XPDIR(I1)=RNEW
      ELSEIF(IVAR.EQ.48) THEN
        IMSS(I1)=INEW
      ELSEIF(IVAR.EQ.49) THEN
        RMSS(I1)=RNEW
      ELSEIF(IVAR.EQ.50) THEN
        RVLAM(I1,I2,I3)=RNEW
      ELSEIF(IVAR.EQ.51) THEN
        RVLAMP(I1,I2,I3)=RNEW
      ELSEIF(IVAR.EQ.52) THEN
        RVLAMB(I1,I2,I3)=RNEW
      ELSEIF(IVAR.EQ.53) THEN
        ITCM(I1)=INEW
      ELSEIF(IVAR.EQ.54) THEN
        RTCM(I1)=RNEW
      ELSEIF(IVAR.EQ.55) THEN
        IUED(I1)=INEW
      ELSEIF(IVAR.EQ.56) THEN
        RUED(I1)=RNEW
      ENDIF
 
C...Write old and new value. Loop back.
      CHBIT(LNAM:14)=' '
      CHBIT(15:60)=' changed from                to               '
      IF(MSVAR(IVAR,1).EQ.1) THEN
        WRITE(CHBIT(33:42),'(I10)') IOLD
        WRITE(CHBIT(51:60),'(I10)') INEW
        IF(MSTU(13).GE.1) WRITE(MSTU(11),5000) CHBIT(1:60)
      ELSEIF(MSVAR(IVAR,1).EQ.2) THEN
        WRITE(CHBIT(29:42),'(F14.5)') ROLD
        WRITE(CHBIT(47:60),'(F14.5)') RNEW
        IF(MSTU(13).GE.1) WRITE(MSTU(11),5000) CHBIT(1:60)
      ELSEIF(MSVAR(IVAR,1).EQ.3) THEN
        CHBIT(35:42)=CHOLD
        CHBIT(53:60)=CHNEW
        IF(MSTU(13).GE.1) WRITE(MSTU(11),5000) CHBIT(1:60)
      ELSE
        CHBIT(15:88)=' changed from '//CHOLD2//' to '//CHNEW2
        IF(MSTU(13).GE.1) WRITE(MSTU(11),5100) CHBIT(1:88)
      ENDIF
      LLOW=LHIG
      IF(LLOW.LT.LTOT) GOTO 120
 
C...Format statement for output on unit MSTU(11) (by default 6).
 5000 FORMAT(5X,A60)
 5100 FORMAT(5X,A88)
 
      RETURN
      END
