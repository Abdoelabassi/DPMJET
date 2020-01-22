cc ------------ dpmjet3.4 - authors: S.Roesler, R.Engel, J.Ranft -------
cc -------- phojet1.12-40 - authors: S.Roesler, R.Engel, J.Ranft -------
cc                                                      - oct'13 -------
cc ----------- pythia-6.4 - authors: Torbjorn Sjostrand, Lund'10 -------
cc ---------------------------------------------------------------------
cc                                  converted for use with FLUKA -------
cc                                                      - oct'13 -------
 
C...PYCBAL
C...Auxiliary to PYEICG
C
C     THIS SUBROUTINE IS A TRANSLATION OF THE ALGOL PROCEDURE
C     CBALANCE, WHICH IS A COMPLEX VERSION OF BALANCE,
C     NUM. MATH. 13, 293-304(1969) BY PARLETT AND REINSCH.
C     HANDBOOK FOR AUTO. COMP., VOL.II-LINEAR ALGEBRA, 315-326(1971).
C
C     THIS SUBROUTINE BALANCES A COMPLEX MATRIX AND ISOLATES
C     EIGENVALUES WHENEVER POSSIBLE.
C
C     ON INPUT
C
C        NM MUST BE SET TO THE ROW DIMENSION OF TWO-DIMENSIONAL
C          ARRAY PARAMETERS AS DECLARED IN THE CALLING PROGRAM
C          DIMENSION STATEMENT.
C
C        N IS THE ORDER OF THE MATRIX.
C
C        AR AND AI CONTAIN THE REAL AND IMAGINARY PARTS,
C          RESPECTIVELY, OF THE COMPLEX MATRIX TO BE BALANCED.
C
C     ON OUTPUT
C
C        AR AND AI CONTAIN THE REAL AND IMAGINARY PARTS,
C          RESPECTIVELY, OF THE BALANCED MATRIX.
C
C        LOW AND IGH ARE TWO INTEGERS SUCH THAT AR(I,J) AND AI(I,J)
C          ARE EQUAL TO ZERO IF
C           (1) I IS GREATER THAN J AND
C           (2) J=1,...,LOW-1 OR I=IGH+1,...,N.
C
C        SCALE CONTAINS INFORMATION DETERMINING THE
C           PERMUTATIONS AND SCALING FACTORS USED.
C
C     SUPPOSE THAT THE PRINCIPAL SUBMATRIX IN ROWS LOW THROUGH IGH
C     HAS BEEN BALANCED, THAT P(J) DENOTES THE INDEX INTERCHANGED
C     WITH J DURING THE PERMUTATION STEP, AND THAT THE ELEMENTS
C     OF THE DIAGONAL MATRIX USED ARE DENOTED BY D(I,J).  THEN
C        SCALE(J) = P(J),    FOR J = 1,...,LOW-1
C                 = D(J,J)       J = LOW,...,IGH
C                 = P(J)         J = IGH+1,...,N.
C     THE ORDER IN WHICH THE INTERCHANGES ARE MADE IS N TO IGH+1,
C     THEN 1 TO LOW-1.
C
C     NOTE THAT 1 IS RETURNED FOR IGH IF IGH IS ZERO FORMALLY.
C
C     THE ALGOL PROCEDURE EXC CONTAINED IN CBALANCE APPEARS IN
C     CBAL  IN LINE.  (NOTE THAT THE ALGOL ROLES OF IDENTIFIERS
C     K,L HAVE BEEN REVERSED.)
C
C     ARITHMETIC IS REAL THROUGHOUT.
C
C     QUESTIONS AND COMMENTS SHOULD BE DIRECTED TO BURTON S. GARBOW,
C     MATHEMATICS AND COMPUTER SCIENCE DIV, ARGONNE NATIONAL LABORATORY
C
C     THIS VERSION DATED AUGUST 1983.
C
 
      SUBROUTINE PYCBAL(NM,N,AR,AI,LOW,IGH,SCALE)
 
      INTEGER I,J,K,L,M,N,JJ,NM,IGH,LOW,IEXC
      DOUBLE PRECISION AR(5,5),AI(5,5),SCALE(5)
      DOUBLE PRECISION C,F,G,R,S,B2,RADIX
      LOGICAL NOCONV
 
      RADIX = 16.0D0
C
      B2 = RADIX * RADIX
      K = 1
      L = N
      GOTO 150
C     .......... IN-LINE PROCEDURE FOR ROW AND
C                COLUMN EXCHANGE ..........
  100 SCALE(M) = J
      IF (J .EQ. M) GOTO 130
C
      DO 110 I = 1, L
         F = AR(I,J)
         AR(I,J) = AR(I,M)
         AR(I,M) = F
         F = AI(I,J)
         AI(I,J) = AI(I,M)
         AI(I,M) = F
  110 CONTINUE
C
      DO 120 I = K, N
         F = AR(J,I)
         AR(J,I) = AR(M,I)
         AR(M,I) = F
         F = AI(J,I)
         AI(J,I) = AI(M,I)
         AI(M,I) = F
  120 CONTINUE
C
  130 IF(IEXC.EQ.1) GOTO 140
      IF(IEXC.EQ.2) GOTO 180
C     .......... SEARCH FOR ROWS ISOLATING AN EIGENVALUE
C                AND PUSH THEM DOWN ..........
  140 IF (L .EQ. 1) GOTO 320
      L = L - 1
C     .......... FOR J=L STEP -1 UNTIL 1 DO -- ..........
  150 DO 170 JJ = 1, L
         J = L + 1 - JJ
C
         DO 160 I = 1, L
            IF (I .EQ. J) GOTO 160
            IF (AR(J,I) .NE. 0.0D0 .OR. AI(J,I) .NE. 0.0D0) GOTO 170
  160    CONTINUE
C
         M = L
         IEXC = 1
         GOTO 100
  170 CONTINUE
C
      GOTO 190
C     .......... SEARCH FOR COLUMNS ISOLATING AN EIGENVALUE
C                AND PUSH THEM LEFT ..........
  180 K = K + 1
C
  190 DO 210 J = K, L
C
         DO 200 I = K, L
            IF (I .EQ. J) GOTO 200
            IF (AR(I,J) .NE. 0.0D0 .OR. AI(I,J) .NE. 0.0D0) GOTO 210
  200    CONTINUE
C
         M = K
         IEXC = 2
         GOTO 100
  210 CONTINUE
C     .......... NOW BALANCE THE SUBMATRIX IN ROWS K TO L ..........
      DO 220 I = K, L
  220 SCALE(I) = 1.0D0
C     .......... ITERATIVE LOOP FOR NORM REDUCTION ..........
  230 NOCONV = .FALSE.
C
      DO 310 I = K, L
         C = 0.0D0
         R = 0.0D0
C
         DO 240 J = K, L
            IF (J .EQ. I) GOTO 240
            C = C + ABS(AR(J,I)) + ABS(AI(J,I))
            R = R + ABS(AR(I,J)) + ABS(AI(I,J))
  240    CONTINUE
C     .......... GUARD AGAINST ZERO C OR R DUE TO UNDERFLOW ..........
         IF (C .EQ. 0.0D0 .OR. R .EQ. 0.0D0) GOTO 310
         G = R / RADIX
         F = 1.0D0
         S = C + R
  250    IF (C .GE. G) GOTO 260
         F = F * RADIX
         C = C * B2
         GOTO 250
  260    G = R * RADIX
  270    IF (C .LT. G) GOTO 280
         F = F / RADIX
         C = C / B2
         GOTO 270
C     .......... NOW BALANCE ..........
  280    IF ((C + R) / F .GE. 0.95D0 * S) GOTO 310
         G = 1.0D0 / F
         SCALE(I) = SCALE(I) * F
         NOCONV = .TRUE.
C
         DO 290 J = K, N
            AR(I,J) = AR(I,J) * G
            AI(I,J) = AI(I,J) * G
  290    CONTINUE
C
         DO 300 J = 1, L
            AR(J,I) = AR(J,I) * F
            AI(J,I) = AI(J,I) * F
  300    CONTINUE
C
  310 CONTINUE
C
      IF (NOCONV) GOTO 230
C
  320 LOW = K
      IGH = L
      RETURN
      END
