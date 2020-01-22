cc ------------ dpmjet3.4 - authors: S.Roesler, R.Engel, J.Ranft -------
cc -------- phojet1.12-40 - authors: S.Roesler, R.Engel, J.Ranft -------
cc                                                      - oct'13 -------
cc ----------- pythia-6.4 - authors: Torbjorn Sjostrand, Lund'10 -------
cc ---------------------------------------------------------------------
cc                                  converted for use with FLUKA -------
cc                                                      - oct'13 -------
 
C...PYCSRT
C...Auxiliary to PYCMQR
C
C     (YR,YI) = COMPLEX SQRT(XR,XI)
C     BRANCH CHOSEN SO THAT YR .GE. 0.0 AND SIGN(YI) .EQ. SIGN(XI)
C
 
      SUBROUTINE PYCSRT(XR,XI,YR,YI)
 
      DOUBLE PRECISION XR,XI,YR,YI
      DOUBLE PRECISION S,TR,TI,PYTHAG
 
      TR = XR
      TI = XI
      S = SQRT(0.5D0*(PYTHAG(TR,TI) + ABS(TR)))
      IF (TR .GE. 0.0D0) YR = S
      IF (TI .LT. 0.0D0) S = -S
      IF (TR .LE. 0.0D0) YI = S
      IF (TR .LT. 0.0D0) YR = 0.5D0*(TI/YI)
      IF (TR .GT. 0.0D0) YI = 0.5D0*(TI/YR)
      RETURN
      END
