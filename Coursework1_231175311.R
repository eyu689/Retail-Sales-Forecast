install.packages("prophet")
library(prophet)

data_retailsales <- read.csv("data/RSAFS.csv")
head(data_retailsales)

prophet_data_retailsales <- data.frame(
  ds = as.Date(data_retailsales$observation_date),
  y = as.numeric(data_retailsales$RSAFS)
)

head(prophet_data_retailsales)

plot(prophet_data_retailsales$ds, prophet_data_retailsales$y, type = "l",
     main = "Retail Sales Time Series",
     xlab = "Date", ylab = "Retail Sales")

model_retailsales <- prophet(prophet_data_retailsales)

future_retailsales <- make_future_dataframe(
  model_retailsales,
  periods = 12,
  freq = "month"
)

forecast_retailsales <- predict(model_retailsales, future_retailsales)

plot(model_retailsales, forecast_retailsales)
prophet_plot_components(model_retailsales, forecast_retailsales)

