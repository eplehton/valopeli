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
