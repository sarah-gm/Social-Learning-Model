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


