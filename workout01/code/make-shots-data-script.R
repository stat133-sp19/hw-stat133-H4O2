#• title: Workout01-make shots data script-code
#• description: the script is about manipulating data and output some summary statistics
#• input(s): csv files which contain the data for each players
#• output(s): summary on each player and the all five as well as a combined csv file

# names <- c('curry','durant','klay','andre','draymond')
# filename <- c("../data/stephen-curry.csv","../data/kevin-durant.csv","../data/klay-thompson.csv","../data/andre-iguodala.csv","../data/draymond-green.csv")


#Read in the five data sets, using relative file paths; the decision of the data types for each column is up to you.
curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
klay <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)
andre <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)
draymond <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)

#Add a column name to each imported data frame, that contains the name of the corresponding player:
curry$name <- 'Stephen Curry'
durant$name <- 'Kevin Durant'
klay$name <- 'Klay Thompson'
andre$name <- 'Andre Iguodala'
draymond$name <- 'Draymond Green'

#Change the original values of shot_made_flag to more descriptive values:
# replace "n" with "shot_no", and "y" with "shot_yes".

curry$shot_made_flag[curry$shot_made_flag=='y']  <- 'shot_yes'
curry$shot_made_flag[curry$shot_made_flag=='n']  <- 'shot_no'
klay$shot_made_flag[klay$shot_made_flag=='y']  <- 'shot_yes'
klay$shot_made_flag[klay$shot_made_flag=='n']  <- 'shot_no'
durant$shot_made_flag[durant$shot_made_flag=='n']  <- 'shot_no'
durant$shot_made_flag[durant$shot_made_flag=='y']  <- 'shot_yes'
andre$shot_made_flag[andre$shot_made_flag=='n']  <- 'shot_no'
andre$shot_made_flag[andre$shot_made_flag=='y']  <- 'shot_yes'
draymond$shot_made_flag[draymond$shot_made_flag=='n']  <- 'shot_no'
draymond$shot_made_flag[draymond$shot_made_flag=='y']  <- 'shot_yes'

#Add a column minute that contains the minute number where a shot occurred.
curry$minite <- curry$period*12 - curry$minutes_remaining
klay$minite <- klay$period*12 - klay$minutes_remaining
durant$minite <- durant$period*12 - durant$minutes_remaining
andre$minite <- andre$period*12 - andre$minutes_remaining
draymond$minite <- draymond$period*12 - draymond$minutes_remaining

#Use sink() to send the summary() output of each imported data frame into individuals text files
sink(file = '../output/stephen-curry-summary.txt')
summary(curry)
sink()
sink(file = '../output/kevin-durant-summary.txt')
summary(durant)
sink()
sink(file = '../output/klay-thompson-summary.txt')
summary(klay)
sink()
sink(file = '../output/andre-iguodala-summary.txt')
summary(andre)
sink()
sink(file = '../output/draymond-green-summary.txt')
summary(draymond)
sink()
#Use the row binding function rbind() to stack the tables into one single data frame.
shots.data <- rbind(curry,durant,klay,andre,draymond)
#Export (i.e. write) the assembled table as a CSV file shots-data.csv inside the folder data/. Use a relative path for this operation.
write.csv(shots.data, file = '../data/shots-data.csv')

c#Use sink() to send the summary() output of the assembled table.
#Send this output to a text file named shots-data-summary.txt inside the output/ folder. 
sink(file='../output/shots-data-summary.txt')
summary(shots.data)
sink()

