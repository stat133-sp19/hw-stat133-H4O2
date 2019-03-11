#• title: Workout01-make shots chart script-code
#• description: the script uses the data of players and plots several shoot chart.
#• input(s): csv files which contain the data for each players
#• output(s): plot shooting chart on each player 

library(ggplot2)
library(jpeg)
library(grid)
curry_scatterplot <- ggplot(data = curry) +
                      geom_point(aes(x = x, y = y, color = shot_made_flag))
klay_scatterplot <- ggplot(data = klay) + 
                      geom_point(aes(x = x, y = y, color = shot_made_flag))
# court image (to be used as background of plot)
court_file <- "../images/nba-court.jpg"
# create raste object
court_image <- rasterGrob( readJPEG(court_file), width = unit(1, "npc"), height = unit(1, "npc"))
# shot chart with court background
klay_shot_chart <- ggplot(data = klay) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') + 
  theme_minimal()
ggsave('../images/klay-thompson-shot-chart.pdf', plot = klay_shot_chart, device = "pdf", width = 6.5, height = 5)

curry_shot_chart <- ggplot(data = curry) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') + 
  theme_minimal()
ggsave('../images/stephen-curry-shot-chart.pdf', plot = curry_shot_chart, device = "pdf", width = 6.5, height = 5)

durant_shot_chart <- ggplot(data = durant) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') + 
  theme_minimal()
ggsave('../images/kevin-durant-shot-chart.pdf', plot = durant_shot_chart, device = "pdf", width = 6.5, height = 5)

andre_shot_chart <- ggplot(data = andre) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') + 
  theme_minimal()
ggsave('../images/andre-iguodala-shot-chart.pdf', plot = andre_shot_chart, device = "pdf", width = 6.5, height = 5)

draymond_shot_chart <- ggplot(data = draymond) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') + 
  theme_minimal()
ggsave('../images/draymond-green-shot-chart.pdf', plot = draymond_shot_chart, device = "pdf", width = 6.5, height = 5)

# Show all the shot charts in one image
GSW_shot_chart <- ggplot(data = shots.data) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: GSW shots chart (2016 season)') + 
  theme_minimal()
facet_GSW_shot_chart <- GSW_shot_chart + facet_wrap(name ~ ., ncol=3)
ggsave('../images/gsw-shot-charts.pdf', plot = facet_GSW_shot_chart, device = "pdf", width = 8, height = 7)
ggsave('../images/gsw-shot-charts.png', plot = facet_GSW_shot_chart, device = "png", width = 8, height = 7)


