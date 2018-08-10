# Portfolio-Construction-and-Tracking-Error

ACTIVITY 1 :
Download data for last 3 years for the DJIA (Dow Jones Industrial Average) and each of the 30 component
stocks. Download data from an appropriate financial website such as Google Finance, Yahoo Finance,
Quandl, CityFALCON, or another similar source. If you are using the R language, then there are videos in
the "Supplemental Videos in R" located in the "Supplemental Materials" at the bottom of the course ware
on how to import CSV files into your program.

ACTIVITY 2 :
Calculate Monthly returns of the DJIA index and the downloaded stocks over the period under study (for
three years)

ACTIVITY 3 :
Calculate mean and standard deviation of monthly returns for the DJIA index.

ACTIVITY 4 :
Choose an equal weighted portfolio consisting of any 5 random stocks from the DJIA, calculate the mean
monthly returns and its standard deviation.
Do the same for portfolios of 10,15, 20 and 25 random stocks from the DJIA universe.

ACTIVITY 5 :
Calculate tracking errors for each of the portfolios i.e. the margin by which the mean and standard
deviation of the portfolio returns diverge from those of DJIA.

ACTIVITY 6 :
Graphically represent the tracking error for returns and risk (standard deviation of returns used as a proxy
for risk) on y-axis against the sample size of portfolio on the x-axis.

ANALYSIS OF RESULTS
Based on the results of your findings, complete the following analysis:
1. What all factors account for the tracking error of the constructed portfolios?

ANALYSIS :
Several factors generally account for a portfolio's tracking error:
1. Number of stocks in portfolio and the DJIA index (benchmark). It’s different for different
portfolios.
2. Stocks component in portfolio i.e. portfolio with different companies gives different tracking error
3. In our case, weight is equal, else differences in the weighting of assets accounts for tracking
error.
4. The volatility of the portfolio and benchmark
5. The return of portfolio and the benchmark
6. Increase or decrease in portfolio size
2. What is the relationship between tracking error and portfolio sample size?

ANALYSIS :
To find relationship between tracking error and portfolio sample size, I have taken almost ten
observations for each samples of 5, 10, 15, 20 and 25 stocks portfolio(plot included in file 3). Shown
below graph of four such observations, which strongly indicate that as portfolio size increases, tracking
error for return goes up, i.e. increment in return over benchmark, and tracking error of risk(standard
deviation) goes down, i.e. portfolio risk reduces.
