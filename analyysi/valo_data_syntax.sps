* Encoding: windows-1252.


GET DATA  /TYPE=TXT
  /FILE="C:\Users\Erno\Gitit\valopeli\analyysi\data\datat.txt"
  /ENCODING='Locale'
  /DELCASE=LINE
  /DELIMITERS=","
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /IMPORTCASE=ALL
  /VARIABLES=
  subId A3
  roundId F2.0
  group F1.0
  isTestGame F1.0
  successInStatic F1.0
  gameNumber F3.0
  gameInterval A12
  previousIntervalChange A12
  pressesToSuccess F2.0
  duration F5.0.
CACHE.
EXECUTE.
DATASET NAME DataSet1 WINDOW=FRONT.

DATASET ACTIVATE DataSet1.
AGGREGATE
  /OUTFILE='C:\Users\Erno\Gitit\valopeli\analyysi\data\aggr.sav'
  /BREAK=subId roundId group isTestGame
  /successInStatic_mean=MEAN(successInStatic).

FLIP VARIABLES=subId roundId group successInStatic_mean.
DATASET NAME flipped WINDOW=FRONT.

GLM round1 round2 round3 round4 BY group
  /WSFACTOR=rounds 4 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(group*rounds rounds*group)
  /PRINT=DESCRIPTIVE ETASQ HOMOGENEITY 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=rounds 
  /DESIGN=group.
