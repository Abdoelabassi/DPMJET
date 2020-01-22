cc ------------ dpmjet3.4 - authors: S.Roesler, R.Engel, J.Ranft -------
cc -------- phojet1.12-40 - authors: S.Roesler, R.Engel, J.Ranft -------
cc                                                      - oct'13 -------
cc ----------- pythia-6.4 - authors: Torbjorn Sjostrand, Lund'10 -------
cc ---------------------------------------------------------------------
cc                                  converted for use with FLUKA -------
cc                                                      - oct'13 -------
 
C...PYANGL
C...Reconstructs an angle from given x and y coordinates.
 
      DOUBLE PRECISION FUNCTION PYANGL(X,Y)
 
C...Double precision and integer declarations.
      IMPLICIT DOUBLE PRECISION(A-H, O-Z)
      IMPLICIT INTEGER(I-N)

C...Commonblocks.
      include 'inc/pydat1'
 
      PYANGL=0D0
      R=SQRT(X**2+Y**2)
      IF(R.LT.1D-20) RETURN
      IF(ABS(X)/R.LT.0.8D0) THEN
        PYANGL=SIGN(ACOS(X/R),Y)
      ELSE
        PYANGL=ASIN(Y/R)
        IF(X.LT.0D0.AND.PYANGL.GE.0D0) THEN
          PYANGL=PARU(1)-PYANGL
        ELSEIF(X.LT.0D0) THEN
          PYANGL=-PARU(1)-PYANGL
        ENDIF
      ENDIF
 
      RETURN
      END
