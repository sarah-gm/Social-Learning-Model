; The role of social learning on consumers’ willingness to engage in demand-side management: An agent-based modeling approach in NetLogo code, authored by Sara Golmaryami.


extensions [matrix] ; Adds the matrix extension to handle matrix data structures.

breed [people peoples] ; Defines a breed of agents called "people."

Globals ; Declares global variables used throughout the model.
[
  Counter            ; Counts the number of rows in the data file.
  Core               ; The main matrix to store data read from the file.
  Data-Column        ; Tracks the current column being processed in the data matrix.
  Data-Row           ; Tracks the current row being processed in the data matrix.
  Time-counter       ; Tracks the simulation time.
  Rural-Survey       ; Stores the count of rural participants.
  Urban-Survey       ; Stores the count of urban participants.
  Rural-DSM          ; Stores the count of rural participants who manage demand response.
  Urban-DSM          ; Stores the count of urban participants who manage demand response.
  Time.              ; Holds the total duration of the simulation.
]

People-own
[
   DateTime                          ; Stores the creation date and time for the person.
  Number                            ; An identifier for the person.
  Gender                            ; The gender of the person (e.g., 0 for male, 1 for female).
  Number-of-household               ; Number of people in the household.
  P1-report-meter                   ; Whether the person reports electricity usage.
  P2-changed-electricity-supplier   ; Whether the person changed their electricity supplier.
  P3-Know-about-tariffs             ; Awareness of electricity tariffs.
  P4-Device-to-Monitor              ; Ownership of a monitoring device for electricity.
  P5-Change-by-Recomment-Family     ; Influenced by family recommendations.
  Education                         ; Level of education.
  Job                               ; Employment status.
  Flag                              ; Tracks if the person has been processed in the simulation.
  City                              ; Indicates if the person lives in a rural (0) or urban (1) area.
  Age                               ; Age of the person.
  Total-Manage-Rates                ; Total score of the person's demand response management.
  Manage-rates-1 ;score of answer Number-of-household
  Manage-rates-2 ;score of answer P1-report-meter
  Manage-rates-3 ;score of answer P2-changed-electricity-supplier
  Manage-rates-4 ;score of answer P3-Know-about-tariffs
  Manage-rates-5 ;score of answer P4-Device-to-Monitorv
  Manage-rates-6 ;score of answer P5-Change-by-Recomment-Family
  xcor           ; to store the x-coordinate of the person's location
  ycor           ; to store the y-coordinate of the person's location

]

to Setup ; Initializes the model.
  clear-all ; Clears the world and resets all variables.

  ; Read the number of lines in the data file
  file-open "Data.txt"
  while [not file-at-end?] [
    let line file-read ; Reads each line from the file.
    set Counter Counter + 1 ; Increments the counter for each line read.
  ]
  file-close ; Closes the file.

  ; Create the core matrix and set up the people and data
  set Core matrix:make-constant Counter 16 0 ; Creates a matrix with Counter rows and 16 columns filled with 0.
  Setup-People ; Calls the procedure to initialize people.
  Setup-Core ; Loads data into the core matrix.
  Setup-Data-Base ; Sets up additional data for individuals.


  set Time. Simulation-Run-Days ; Sets the total simulation run time.
  ; Sets colors based on gender.
  ask turtles with [Gender = 0] [set color orange]
  ask turtles with [Gender = 1] [set color blue]
  reset-ticks ; Resets the simulation clock.
end



to Setup-People ; Creates and initializes the people agents.

  create-People Counter ; Creates a number of "people" equal to the Counter value.
  ask People [
    setxy (random-pxcor) (random-pycor) ; set turtle position randomly on the world
    set shape "person"

    set color red
    set heading random 360 ; set turtle heading randomly
    set DateTime date-and-time
    set Flag 0
  ]
  ; example movement code - move turtles randomly every 5 ticks
  every 5 [
    ask People [
      rt random 60 - 30 ; turn turtle randomly between -30 and 30 degrees
      fd 1 ; move turtle 1 unit forward
    ]
  ]
end


to Setup-Core ; Loads data from the file into the core matrix.


  file-open "Data.txt"
  while [not file-at-end?] [
    let line file-read ; Reads a line from the file.
    if Data-Column <= Counter [ ; Checks if the current column is within the counter range.
      ; Assigns values from the line to the respective columns in the matrix.

    matrix:set Core Data-Column 0 item 0 line
    matrix:set Core Data-Column 1 item 1 line
    matrix:set Core Data-Column 2 item 2 line
    matrix:set Core Data-Column 3 item 3 line
    matrix:set Core Data-Column 4 item 4 line
    matrix:set Core Data-Column 5 item 5 line
    matrix:set Core Data-Column 6 item 6 line
    matrix:set Core Data-Column 7 item 7 line
    matrix:set Core Data-Column 8 item 8 line
    matrix:set Core Data-Column 9 item 9 line
    matrix:set Core Data-Column 10 item 10 line
    matrix:set Core Data-Column 11 item 11 line


    ]
    set Data-Column Data-Column + 1
  ]
  file-close

end

to Setup-Data-Base ; Assigns data from the matrix to individual people.


  while [Data-Row < Counter] [



    ask turtle Data-Row [Set Number matrix:get core Data-Row 0 ]
    ask turtle Data-Row [Set Gender matrix:get core Data-Row 1 ]
    ask turtle Data-Row [Set Number-of-household matrix:get core Data-Row 2 ]
    ask turtle Data-Row [Set P1-report-meter matrix:get core Data-Row 3 ]
    ask turtle Data-Row [Set P2-changed-electricity-supplier matrix:get core Data-Row 4 ]
    ask turtle Data-Row [Set P3-Know-about-tariffs matrix:get core Data-Row 5 ]
    ask turtle Data-Row [Set P4-Device-to-Monitor matrix:get core Data-Row 6 ]
    ask turtle Data-Row [Set P5-Change-by-Recomment-Family matrix:get core Data-Row 7 ]
    ask turtle Data-Row [Set Education matrix:get core Data-Row 8 ]
    ask turtle Data-Row [Set Job matrix:get core Data-Row 9 ]
    ask turtle Data-Row [Set City matrix:get core Data-Row 10 ]
    ask turtle Data-Row [Set Age matrix:get core Data-Row 11 ]


    set Data-Row Data-Row + 1

  ]


end


to Go

  if Time-counter <= Time. [Level-1]
  if Time-counter = Time. [Stop]

  PLT

 tick
end


to Level-1


  if count turtles with [Flag = 0] > 0
 [
 ask one-of People with [Flag = 0]

  [

    Set Flag 1


    if Number-of-household <= 2 [set Manage-rates-1 0 ]
    if Number-of-household > 2 [set Manage-rates-1 0 ]

    if P1-report-meter = 1 [set Manage-rates-2 10]
    if P1-report-meter = 0 [set Manage-rates-2 0]

    if P2-changed-electricity-supplier = 1 [set Manage-rates-3 10]
    if P2-changed-electricity-supplier = 0 [set Manage-rates-3 0]

    if P3-Know-about-tariffs = 1 [set Manage-rates-4 10 ]
    if P3-Know-about-tariffs = 0 [set Manage-rates-4 0 ]

    if P4-Device-to-Monitor = 1 [set Manage-rates-5 10 ]
    if P4-Device-to-Monitor = 0 [set Manage-rates-5 0 ]

    if P5-Change-by-Recomment-Family = 4 [set Manage-rates-6 10 ]
    if P5-Change-by-Recomment-Family = 3 [set Manage-rates-6 8 ]
    if P5-Change-by-Recomment-Family = 5 [set Manage-rates-6 5 ]
    if P5-Change-by-Recomment-Family = 2 [set Manage-rates-6 3 ]
    if P5-Change-by-Recomment-Family = 1 [set Manage-rates-6 1 ]


    set Total-Manage-Rates
      Manage-rates-1
    + Manage-rates-2
    + Manage-rates-3
    + Manage-rates-4
    + Manage-rates-5
    + Manage-rates-6

      ; Check if the score is 10 and then set the patch color to green
      if Total-Manage-Rates = 30 [ ask patch-here [set pcolor green] ]

      if  count turtles with [Flag = 1] = Counter
      [set Time-counter Time-counter + 1
        ask people [set Flag 0 ]
        ask turtles with [Gender = 0 ][set color orange]
        ask turtles with [Gender = 1 ][set color blue]
        Level-2
      ]



  ]
  ]
end

to Level-2


    if random-float 1 < Social-learning-influence-Rate

  [


    if count people with [P1-report-meter = 0] >= 10 [
    ask n-of 10 People with[P1-report-meter = 0] [

      set P1-report-meter 1
  ]]

  if count people with [P2-changed-electricity-supplier = 0] >= 10 [
    ask n-of 10 People with[P2-changed-electricity-supplier = 0] [

      set P2-changed-electricity-supplier 1
  ]]

    if count people with [P3-Know-about-tariffs = 0] >= 10 [
    ask n-of 10 People with[P3-Know-about-tariffs = 0] [

      set P3-Know-about-tariffs 1
    ]]

    if count people with [P4-Device-to-Monitor = 0] >= 10 [
     ask n-of 10 People with[P4-Device-to-Monitor = 0] [

      set P4-Device-to-Monitor 1
    ]]

    if count people with [P5-Change-by-Recomment-Family = 1 or P5-Change-by-Recomment-Family = 0 or P5-Change-by-Recomment-Family = 5] >= 8.84 [
     ask n-of 10 People with[P5-Change-by-Recomment-Family = 1 or P5-Change-by-Recomment-Family = 0 or P5-Change-by-Recomment-Family = 5] [

      set P5-Change-by-Recomment-Family 4
    ]]



  if Total-Manage-Rates > Score-Threshold [
    ask patch-here [set pcolor green]
]

  ]

end



to PLT

set-current-plot "Participate in DR (Gender)"

  set-current-plot-pen "Female"
  plot count turtles with [(Total-Manage-Rates) > (Score-Threshold) and Gender = 1] / count people * 100


  set-current-plot-pen "Male"
  plot count turtles with [Total-Manage-Rates > (Score-Threshold) and Gender = 0] / count people * 100



  set-current-plot "Participate in DR (Education Level)"

  set-current-plot-pen "Basic Level"
  plot count turtles with [Total-Manage-Rates > (Score-Threshold) and Education = 1 ] / count people * 100

  set-current-plot-pen "School Level"
  plot count turtles with [Total-Manage-Rates > (Score-Threshold) and Education = 2 ] / count people * 100


  set-current-plot-pen "University Level"
  plot count turtles with [Total-Manage-Rates > (Score-Threshold) and Education = 3 ] / count people * 100

  set-current-plot "Participate in DR (Locality)"


  set-current-plot-pen "Rural"
  plot count turtles with [Total-Manage-Rates > (Score-Threshold) and City = 0 ] / count people * 100


  set-current-plot-pen "Urban"
  plot count turtles with [Total-Manage-Rates > (Score-Threshold) and City = 1 ] / count people * 100


 set-current-plot "Participate in DR (Profession Level)"


  set-current-plot-pen "Unemployed"
  plot count turtles with [Total-Manage-Rates > (Score-Threshold) and Job = 0 ] / count people * 100

  set-current-plot-pen "Retired"
  plot count turtles with [Total-Manage-Rates > (Score-Threshold) and Job = 1 ] / count people * 100

  set-current-plot-pen "Non-employed"
  plot count turtles with [Total-Manage-Rates > (Score-Threshold) and Job = 2 ] / count people * 100

  set-current-plot-pen "Employee"
  plot count turtles with [Total-Manage-Rates > (Score-Threshold) and Job = 3 ] / count people * 100

  set-current-plot-pen "Self-employed worker"
  plot count turtles with [Total-Manage-Rates > (Score-Threshold) and Job = 4 ] / count people * 100

  set-current-plot-pen "Student"
  plot count turtles with [Total-Manage-Rates > (Score-Threshold) and Job = 5 ] / count people * 100

  set-current-plot "Participate in DR (Age)"
  set-current-plot-pen "Above 65 years old"
  plot count turtles with [Total-Manage-Rates > (Score-Threshold) and Age = 65 ] / count people * 100

  set-current-plot-pen "45 ~ 64 years old"
  plot count turtles with [Total-Manage-Rates > (Score-Threshold) and Age = 55 ] / count people * 100

  set-current-plot-pen "25 ~ 44 years old"
  plot count turtles with [Total-Manage-Rates > (Score-Threshold) and Age = 35 ] / count people * 100

  set-current-plot-pen "18 ~ 24 years old"
  plot count turtles with [Total-Manage-Rates > (Score-Threshold) and Age = 21 ] / count people * 100



  set Rural-Survey count turtles with [city = 0]
  set Urban-Survey count turtles with [city = 1]




  set Rural-DSM count turtles with [city = 0 and Total-Manage-Rates >= Score-Threshold]
  set Urban-DSM count turtles with [city = 1 and Total-Manage-Rates >= Score-Threshold]





end




to-report random-in-range [low high]
  report low + random (high - low + 1)
end
@#$#@#$#@
GRAPHICS-WINDOW
4
10
349
356
-1
-1
10.212121212121213
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
366
454
534
490
NIL
Setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
555
454
722
490
NIL
Go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
355
10
801
214
Participate in DR (Gender)
Simulation run of Data
Gender  (%)
0.0
13500.0
0.0
1.0
true
true
"" ""
PENS
"Female" 1.0 0 -14070903 true "" ""
"Male" 1.0 0 -955883 true "" ""

SLIDER
555
498
723
531
Score-Threshold
Score-Threshold
0
50
30.0
10
1
NIL
HORIZONTAL

SLIDER
364
499
534
532
Simulation-Run-Days
Simulation-Run-Days
0
30
30.0
1
1
NIL
HORIZONTAL

SLIDER
527
375
715
408
Social-learning-influence
Social-learning-influence
0
1
0.0
0.01
1
NIL
HORIZONTAL

PLOT
813
222
1256
442
Participate in DR (Education Level)
Simulation run of Data
Education Level (%)
0.0
13500.0
0.0
10.0
true
true
"" ""
PENS
"Basic Level" 1.0 0 -16777216 true "" ""
"School Level" 1.0 0 -955883 true "" ""
"University Level" 1.0 0 -13345367 true "" ""

PLOT
805
10
1256
214
Participate in DR (Profession Level)
Simulation run of Data
Profession Level (%)
0.0
13500.0
0.0
10.0
true
true
"" ""
PENS
"Unemployed" 1.0 0 -16777216 true "" ""
"Retired" 1.0 0 -7500403 true "" ""
"Non-employed" 1.0 0 -13345367 true "" ""
"Employee" 1.0 0 -955883 true "" ""
"Self-employed worker" 1.0 0 -6459832 true "" ""
"Student" 1.0 0 -1184463 true "" ""

PLOT
354
223
802
443
Participate in DR (Age)
Simulation run of Data
Participation Age (%)
0.0
13500.0
0.0
10.0
true
true
"" ""
PENS
"Above 65 years old" 1.0 0 -16777216 true "" ""
"45 ~ 64 years old" 1.0 0 -7500403 true "" ""
"25 ~ 44 years old" 1.0 0 -2674135 true "" ""
"18 ~ 24 years old" 1.0 0 -955883 true "" ""

PLOT
3
367
350
570
Participate in DR (Locality)
Simulation run of Data
Area  (%)
0.0
13500.0
0.0
10.0
true
true
"" ""
PENS
"Rural" 1.0 0 -4699768 true "" ""
"Urban" 1.0 0 -14439633 true "" ""

SLIDER
437
533
652
566
Social-learning-influence-Rate
Social-learning-influence-Rate
0
1
0.7
0.01
1
NIL
HORIZONTAL

@#$#@#$#@
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

person construction
false
0
Rectangle -7500403 true true 123 76 176 95
Polygon -1 true false 105 90 60 195 90 210 115 162 184 163 210 210 240 195 195 90
Polygon -13345367 true false 180 195 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285
Circle -7500403 true true 110 5 80
Line -16777216 false 148 143 150 196
Rectangle -16777216 true false 116 186 182 198
Circle -1 true false 152 143 9
Circle -1 true false 152 166 9
Rectangle -16777216 true false 179 164 183 186
Polygon -955883 true false 180 90 195 90 195 165 195 195 150 195 150 120 180 90
Polygon -955883 true false 120 90 105 90 105 165 105 195 150 195 150 120 120 90
Rectangle -16777216 true false 135 114 150 120
Rectangle -16777216 true false 135 144 150 150
Rectangle -16777216 true false 135 174 150 180
Polygon -955883 true false 105 42 111 16 128 2 149 0 178 6 190 18 192 28 220 29 216 34 201 39 167 35
Polygon -6459832 true false 54 253 54 238 219 73 227 78
Polygon -16777216 true false 15 285 15 255 30 225 45 225 75 255 75 270 45 285

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.3.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="experiment" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="Social-learning">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="positive-answer">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Time">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Select-Data">
      <value value="&quot;Data-Base&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="On">
      <value value="&quot;All&quot;"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="Social-learning">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="positive-answer">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Time">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Select-Data">
      <value value="&quot;Data-Base&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="On">
      <value value="&quot;All&quot;"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="Social-learning">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="positive-answer">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Time">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Select-Data">
      <value value="&quot;Data-Base&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="On">
      <value value="&quot;All&quot;"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Test2" repetitions="20" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>(count turtles with [Total-Manage-Rates &gt; Score-Threshold]) / count turtles * 100</metric>
    <enumeratedValueSet variable="Social-learning-influence-Rate">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Score-Threshold">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Simulation-Run-Days">
      <value value="1"/>
      <value value="2"/>
      <value value="3"/>
      <value value="4"/>
      <value value="5"/>
      <value value="6"/>
      <value value="7"/>
      <value value="8"/>
      <value value="9"/>
      <value value="10"/>
      <value value="11"/>
      <value value="12"/>
      <value value="13"/>
      <value value="14"/>
      <value value="15"/>
      <value value="16"/>
      <value value="17"/>
      <value value="18"/>
      <value value="19"/>
      <value value="20"/>
      <value value="21"/>
      <value value="22"/>
      <value value="23"/>
      <value value="24"/>
      <value value="25"/>
      <value value="26"/>
      <value value="27"/>
      <value value="28"/>
      <value value="29"/>
      <value value="30"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
