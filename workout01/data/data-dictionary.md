### Data dictionary
***
- **period**:(*data type: integer*) an NBA game is divided in *4* periods of *12* mins each. 
For example, a value for period = 1 refers to the first period (the first 12 mins of the game). 

- **minutes_remaining** and **seconds_remaining** (*data type: integer*) have to do with the amount of time in minutes and seconds, respectively, that remained to be played in a given period.
*shot_made_flag* indicates whether a shot was made (y) or missed (n).

- **action_type** (*data type: integer*) has to do with the basketball moves used by players, either to pass by defenders to gain access to the basket, or to get a clean pass to a teammate to score a two pointer or three pointer.

- **shot_type** (*data type: character*) indicates whether a shot is a 2-point field goal, or a 3-point field goal.

- **shot_distance**:(*data type: double*) distance to the basket (measured in feet).

- x and y (*data type: integer*) refer to the **court coordinates** (measured in inches) where a shot occurred .

- [Some useful information about the dimensions of an NBA basketball court ](https://sportsknowhow.com/basketball/dimensions/nba-basketball-court-dimensions.html)