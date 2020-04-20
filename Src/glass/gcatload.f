C///////////////////////////////////////////////////////////////////////
C/
C/ Copyright (C) 2020 The Koko Project Developers
C/
C/ See the file COPYRIGHT.md in the top-level directory of this
C/ distribution
C/
C/ This file is part of Koko.
C/
C/ Koko is free software: you can redistribute it and/or modify it
C/ under the terms of the GNU General Public License as published by
C/ the Free Software Foundation, either version 3 of the License, or
C/ (at your option) any later version.
C/
C/ Koko is distributed in the hope that it will be useful, but
C/ WITHOUT ANY WARRANTY; without even the implied warranty of
C/ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
C/ GNU General Public License for more details.
C/
C/ You should have received a copy of the GNU General Public License
C/ along with Koko; see the file COPYING.  If not, see
C/ <https://www.gnu.org/licenses/>.
C/
C///////////////////////////////////////////////////////////////////////

      SUBROUTINE GCATLOAD(CATLIST)
          IMPLICIT NONE
          INCLUDE 'datmai.inc'
          INCLUDE 'datlen.inc'
          INTEGER I,JJ,CATLIST,FIRSTJ,LASTJ
          CHARACTER LINE*132,TEMP27*27
          INPUT='OUT ED'
          CALL PROCES
          INPUT='GLASSP GLA'
          CALL PROCES
          INPUT='OUT TP'
          CALL PROCES
          CALL CLOSE_FILE(9,1)
          OPEN(UNIT=9,ACCESS='SEQUENTIAL',BLANK='NULL'
     1    ,FORM='FORMATTED',FILE=trim(HOME)//'EDITTEXT.DAT'
     2    ,STATUS='UNKNOWN')
          REWIND(9)
          I=1
 1        READ(9,25,ERR=90,END=90) LINE
          CATARRAY(I)=LINE(1:27)
          DO JJ=1,27
              IF(CATARRAY(I)(JJ:JJ).EQ.' ') THEN
                  FIRSTJ=JJ
                  GO TO 10
              END IF
          END DO
 10       CONTINUE
          DO JJ=FIRSTJ,27
              IF(CATARRAY(I)(JJ:JJ).NE.' ') THEN
                  LASTJ=JJ
                  GO TO 20
              END IF
          END DO
 20       CONTINUE

          TEMP27='                           '
          TEMP27=CATARRAY(I)(1:FIRSTJ)//CATARRAY(I)(LASTJ:27)
          CATARRAY(I)(1:27)=TEMP27

          I=I+1
          GO TO 1
 90       CONTINUE
          CALL CLOSE_FILE(9,0)
 25       FORMAT(A132)
          CATLIST=I-1
          RETURN
      END
