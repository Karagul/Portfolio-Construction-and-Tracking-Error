#******************************************************************************************************************************************************************************
# Developer : Kumari Anjali
# Case Study: Sample Size and Portfolio Construction
#******************************************************************************************************************************************************************************

# NOTE : 
# All relevant Standard Packages are mentioned below. If its not installed on your system, please install on prompt by this program
# Platform : This code has been developed on R 3.4.3 GUI 1.70 El Capitan build (7463), Normal R version 3.4.3 for MAC OS El Capitan
# Disclaimer : I have developed and tested these codes on MacBook Pro, MAC OS - El Capitan,where its running fine. 
# There may be some error on other OS platform


# Installing Library Function, if required

if (!require(quantmod)) install.packages('quantmod')
if (!require(xts)) install.packages('xts')
if (!require(zoo)) install.packages('zoo')
if (!require(BatchGetSymbols)) install.packages('BatchGetSymbols') 
if (!require(ggplot2)) install.packages('ggplot2')
if (!require(graphics)) install.packages('graphics')
if (!require(PerformanceAnalytics)) install.packages('PerformanceAnalytics')
if (!require(readr)) install.packages('readr')
if (!require(tidyverse)) install.packages('tidyverse')
if (!require(stringr)) install.packages('stringr')
if (!require(data.table)) install.packages('data.table')
if (!require(Matrix)) install.packages('Matrix')
if (!require(sde)) install.packages('sde')
if (!require(portfolio)) install.packages('portfolio')
if (!require(base)) install.packages('base')


# Loading Library Function

library(quantmod)
library(xts)
library(zoo)
library(BatchGetSymbols) 
library(ggplot2)
library(graphics)
library(PerformanceAnalytics)
library(readr)
library(tidyverse)
library(stringr)
library(data.table)
library(Matrix)
library(sde)
library(portfolio)
library(base)

###########################################################################################################################
#  Download data for last 3 years for the DJIA (Dow Jones Industrial Average) and each of the 30 component stocks. 
#  Data has been download from a financial website known as Yahoo Finance
###########################################################################################################################

# Note : Since all analysis are based on monthly data, hence data has been downloaded on monthly frequency

# ---------------------------------------------------------
# Download data for last 3 years for the DJIA  
# ---------------------------------------------------------

#Assign dates to set range for stock quotes
sDate <- as.Date("2015-03-24")
eDate <- as.Date("2018-03-24")

DJIA  <-  getSymbols("^DJI", auto.assign = FALSE,  src='yahoo', from=sDate, to=eDate)
DJIA_Adj_price <- (DJIA[ ,6])    # Showing only Date and Adjusted Closing Price of DJIA.
colnames(DJIA_Adj_price) <- "DJIA"
# Downloaded last three year data for  the DJIA, but showing only first five due to better visibility
head (DJIA_Adj_price)


# -------------------------------------------------------------------------------------------------------
# Download data for last 3 years for the DJIA : 30 separate component stocks
# ------------------------------------------------------------------------------------------------------

library(quantmod)

sDate <- as.Date("2015-03-24")
eDate <- as.Date("2018-03-24")

# Ticker of all 30 stocks has been assigned in Vector data type

stocks <- c("JPM", "JNJ", "INTC", "HD", "MRK", "UTX", "CSCO", "BA", "PFE", "AXP", "WMT", "TRV", "IBM", "KO", "MCD", "DIS", "GS", "NKE", "MSFT", "MMM", "VZ", "CAT", "V", "XOM", "DWDP", "PG", "UNH", "GE", "CVX", "AAPL")

# Download daily price for 30 stocks using getSymbols() function of Quantmod Package.
# PLEASE Wait !!! It takes 2 -3 minutes to download all 30 stock data from internet.
getSymbols(stocks, auto.assign = TRUE,  src='yahoo', from=sDate, to=eDate)

# Generate time series of Adjusted Closing Prices of 30 stocks
prices <- do.call(merge, lapply(stocks, function(x) Ad(get(x))))      # R Code to generate Time Series of Price on the basis of Adjusted Close Price
colnames(prices) <- stocks
 # Downloaded  daily data for last three years, which are too big to show, hence showing only first five Adjusted Closing Price for 30 DJIA component stocks.
head(prices)        


###########################################################################################################################
# Calculate Monthly returns of the DJIA index and the downloaded stocks over the period under study (for three years)
###########################################################################################################################

# Monthly Return for DJIA on the basis of adjusted closing price
#-------------------------------------------------------------------------------------

DJIA_MReturn<-monthlyReturn(DJIA_Adj_price, subset=NULL, type="arithmetic", leading=TRUE)
colnames(DJIA_MReturn) <- "DJIA_return"
head(DJIA_MReturn)

# Monthly Return for 30 DJIA component stocks on the basis of adjusted closing price
#-----------------------------------------------------------------------------------------------------------------

# Monthly return of 30 DJIA component stocks
Monthly_Return <- setNames(do.call(cbind, lapply(prices, monthlyReturn)), stocks)
# setNames allows us to update the column names without having to write another replacement function on another line, 

head(Monthly_Return) 

###########################################################################################################################
# Calculate mean and standard deviation of monthly returns for the DJIA index.
###########################################################################################################################

# Mean and Standard Deviation of monthly returns for the DJIA index
#------------------------------------------------------------------------------------------

# Mean of monthly return of DJIA index
Mean_DJIA_Index <- mean(DJIA_MReturn)
print (Mean_DJIA_Index)        	


# Standard Deviation of monthly return of DJIA index
StDev_DJIA_Index <- sd(DJIA_MReturn)
print (StDev_DJIA_Index)			


# Calculation of Mean and Standard Deviation of monthly returns for 30 DJIA component stocks 
#-----------------------------------------------------------------------------------------------------------

library(PerformanceAnalytics)

DJIA_Stocks_Mean <- colMeans(Monthly_Return)
# Mean of monthly return of 30 DJIA component stocks
DJIA_Stocks_Mean    

       
StDev_DJIA_Stocks <- StdDev(Monthly_Return)    # StdDev()  is part of R-Package known as PerformanceAnalytics
# Standard Deviation of monthly return of DJIA index
StDev_DJIA_Stocks


###########################################################################################################################
# Choose an equal weighted portfolio consisting of any 5 random stocks from the DJIA, 
# Calculate the mean monthly returns and its standard deviation. 
# Do the same for portfolios of 10,15, 20 and 25 random stocks from the DJIA universe
###########################################################################################################################	  

# Using sample() library function, we can choose any random sample stocks from the DJIA
# Below Code makes a portfolio of 5 stocks using random sample from 30 DJIA componenst
# To use sample(), we need "base" package for "Random Samples and Permutations"
# sample() takes a sample of the specified size from the elements of x using either with or without replacement.
#--------------------------------------------------------------------------------------------------------------------------------------------------------
library(base)

#***********************************************************************************************************************************************************************
# Code to make a portfolio of 5 random stocks, monthly return and its standard deviation
# sample() is much simpler to create one random portfolio than Combination {combn()} function for lower time latency and memory management
#***********************************************************************************************************************************************************************

# Cration of random sample of 5 Stocks Portfolio from DJIA
#-------------------------------------------------------------------------------
P5 <- sample(stocks, 5)							
print(P5)


# Monthly Return of 5 Stocks Portfolio
#--------------------------------------------------------------------------
P5_MReturn <- Monthly_Return[ , P5]  
head(P5_MReturn)

# Mean Monthly Return of 5 Stocks Portfolio
#--------------------------------------------------------------------------

P5_stocks_mean <- colMeans(P5_MReturn)     		
P5_stocks_mean	

# Overall return of five equally weighted stocks in portfolio
# Expected return is calculated as the weighted average of the likely profits of the assets in the portfolio.
# Since Sum of all equal weight is 1, Hence "Expected Return from Portfolio of 5 equally weighted Stocks is as :

P5_Return <- mean(P5_stocks_mean)									
P5_Return								

# Standard Deviation Calculation of 5 Stocks Portfolio
#----------------------------------------------------------------------
# P5_stocks_StDev <- StDev_DJIA_Stocks[1, P5]

P5_stocks_StDev <- StdDev(P5_MReturn)
P5_stocks_StDev

# Code to get weights of equally weighted portfolio
#------------------------------------------------------------------
p5_ew = rep(1,5)/5
p5_ew

# Variance, Covariance and Correlation matrix of Portfolio with 5 stocks
#-----------------------------------------------------------------------------------------------

covariance_matrix <-  cov(P5_MReturn)
covariance_matrix

correlation_matrix <-  cor(P5_MReturn)
correlation_matrix


#-----------------------------------------------------------------------------------------------
## Defining  function to calcualte portfolio variance
# ----------------------------------------------------------------------------------------------
Portfolio_variance <- function(x, weights, na.rm = TRUE) {
  if (missing(weights)) {
    weights <- rep(1, ncol(x))
  }

  covmat <- var(x = x, na.rm = na.rm)
  utc <- upper.tri(covmat)
  wt.var <- sum(diag(covmat) * weights^2)
  wt.cov <- sum(weights[row(covmat)[utc]] *
                weights[col(covmat)[utc]] *
                covmat[utc])
  variance <- wt.var + 2 * wt.cov
  return(variance)
}

# Variance & Standard Deviation of Portfolio with 5 stocks
#--------------------------------------------------------------------------------------------
P5_Variance <- Portfolio_variance(x = P5_MReturn, weights = p5_ew)
# Variance of Portfolio five stocks
P5_Variance

P5_Standard_Deviation =  sqrt(P5_Variance)
# Standard Deviation of Portfolio five stocks
P5_Standard_Deviation

#***************************************************************************************************
# Code to make a portfolio of 10 random stocks, monthly return and its standard deviation
#***************************************************************************************************

# Cration of random sample of 10 Stocks Portfolio from DJIA
#-------------------------------------------------------------------------------
P10 <- sample(stocks, 10)					
print(P10)


# Monthly Return of 10 Stocks Portfolio
#--------------------------------------------------------------------------
P10_MReturn <- Monthly_Return[ , P10]  
head(P10_MReturn)

# Mean Monthly Return of 10 Stocks Portfolio
#--------------------------------------------------------------------------

P10_stocks_mean <- colMeans(P10_MReturn)     		
P10_stocks_mean	

# Overall return of 10 equally weighted stocks in portfolio

P10_Return <- mean(P10_stocks_mean)									
P10_Return								

# Standard Deviation Calculation of 10 Stocks Portfolio
#----------------------------------------------------------------------

P10_stocks_StDev <- StdDev(P10_MReturn)
P10_stocks_StDev

# Code to get weights of equally weighted portfolio
#------------------------------------------------------------------
p10_ew = rep(1,10)/10
p10_ew

# Variance & Standard Deviation of Portfolio with 10 stocks
#--------------------------------------------------------------------------------------------
P10_Variance <- Portfolio_variance(x = P10_MReturn, weights = p10_ew)
# Variance of Portfolio 10 stocks
P10_Variance

P10_Standard_Deviation =  sqrt(P10_Variance)
# Standard Deviation of Portfolio 10 stocks
P10_Standard_Deviation


#***************************************************************************************************
# Code to make a portfolio of 15 random stocks, monthly return and its standard deviation
#***************************************************************************************************

# Cration of random sample of 15 Stocks Portfolio from DJIA
#-------------------------------------------------------------------------------
P15 <- sample(stocks, 15)					
print(P15)


# Monthly Return of 15 Stocks Portfolio
#--------------------------------------------------------------------------
P15_MReturn <- Monthly_Return[ , P15]  
head(P15_MReturn)

# Mean Monthly Return of 15 Stocks Portfolio
#--------------------------------------------------------------------------

P15_stocks_mean <- colMeans(P15_MReturn)     		
P15_stocks_mean	

# Overall return of Portfolio with 15 equally weighted stocks

P15_Return <- mean(P15_stocks_mean)									
P15_Return								

# Standard Deviation Calculation of 15 Stocks Portfolio
#----------------------------------------------------------------------

P15_stocks_StDev <- StdDev(P15_MReturn)
P15_stocks_StDev

# Code to get weights of equally weighted portfolio
#------------------------------------------------------------------
p15_ew = rep(1,15)/15
p15_ew

# Variance & Standard Deviation of Portfolio with 15 stocks
#--------------------------------------------------------------------------------------------
P15_Variance <- Portfolio_variance(x = P15_MReturn, weights = p15_ew)
# Variance of Portfolio 15 stocks
P15_Variance

P15_Standard_Deviation =  sqrt(P15_Variance)
# Standard Deviation of Portfolio 15 stocks
P15_Standard_Deviation



#***************************************************************************************************
# Code to make a portfolio of 20 random stocks, monthly return and its standard deviation
#***************************************************************************************************

# Cration of random sample of 20 Stocks Portfolio from DJIA
#-------------------------------------------------------------------------------
P20 <- sample(stocks, 20)					
print(P20)


# Monthly Return of 20 Stocks Portfolio
#--------------------------------------------------------------------------
P20_MReturn <- Monthly_Return[ , P20]  
head(P20_MReturn)

# Mean Monthly Return of 20 Stocks Portfolio
#--------------------------------------------------------------------------

P20_stocks_mean <- colMeans(P20_MReturn)     		
P20_stocks_mean	

# Overall return of 20 equally weighted stocks in portfolio
P20_Return <- mean(P20_stocks_mean)									
P20_Return								

# Standard Deviation Calculation of 20 Stocks Portfolio
#----------------------------------------------------------------------

P20_stocks_StDev <- StdDev(P20_MReturn)
P20_stocks_StDev

# Code to get weights of equally weighted portfolio
#------------------------------------------------------------------
p20_ew = rep(1,20)/20
p20_ew

# Variance & Standard Deviation of Portfolio with 20 stocks
#--------------------------------------------------------------------------------------------
P20_Variance <- Portfolio_variance(x = P20_MReturn, weights = p20_ew)
# Variance of Portfolio 20 stocks
P20_Variance

P20_Standard_Deviation =  sqrt(P20_Variance)
# Standard Deviation of Portfolio 20 stocks
P20_Standard_Deviation



#***************************************************************************************************
# Code to make a portfolio of 25 random stocks, monthly return and its standard deviation
#***************************************************************************************************

# Cration of random sample of 25 Stocks Portfolio from DJIA
#-------------------------------------------------------------------------------
P25 <- sample(stocks, 25)					
print(P25)


# Monthly Return of 25 Stocks Portfolio
#--------------------------------------------------------------------------
P25_MReturn <- Monthly_Return[ , P25]  
head(P25_MReturn)

# Mean of Monthly Return of 25 Stocks Portfolio
#--------------------------------------------------------------------------

P25_stocks_mean <- colMeans(P25_MReturn)     		
P25_stocks_mean	

# Overall return of 25 equally weighted stocks in portfolio
#--------------------------------------------------------------------------
P25_Return <- mean(P25_stocks_mean)									
P25_Return								

# Standard Deviation Calculation of 25 Stocks Portfolio
#----------------------------------------------------------------------

P25_stocks_StDev <- StdDev(P25_MReturn)
P25_stocks_StDev


# Code to get weights of equally weighted portfolio
#------------------------------------------------------------------
p25_ew = rep(1,25)/25
p25_ew

# Variance & Standard Deviation of Portfolio with 25 stocks
#------------------------------------------------------------------------------
P25_Variance <- Portfolio_variance(x = P25_MReturn, weights = p25_ew)
# Variance of Portfolio 25 stocks
P25_Variance

P25_Standard_Deviation =  sqrt(P25_Variance)
# Standard Deviation of Portfolio 25 stocks
P25_Standard_Deviation


###########################################################################################################################

# Calculate tracking errors for each of the portfolios i.e.  the margin by which the mean and standard deviation of the portfolio returns diverge from those of DJIA. 
###########################################################################################################################

# TrackingError() function is part of package called : PerformanceAnalytics, used to calculate Tracking Error of returns against a benchmark 
# A measure of the unexplained portion of performance relative to a benchmark. 
# Function format : TrackingError(Ra, Rb, scale = NA) 
# Where, Arguments Ra is an xts, vector, matrix, data frame, timeSeries or zoo object of asset returns 
# Rb is return vector of the benchmark asset scale number of periods in a year (daily scale = 252, monthly scale = 12, quarterly scale = 4)

library(PerformanceAnalytics)


# Tracking Error for Portfolio 1 of 5 stocks using PerformanceAnalytics Package
TrackingError(P5_MReturn, DJIA_MReturn, scale = NA) 
TrackingError(P10_MReturn, DJIA_MReturn, scale = NA) 
TrackingError(P15_MReturn, DJIA_MReturn, scale = NA) 
TrackingError(P20_MReturn, DJIA_MReturn, scale = NA) 
TrackingError(P25_MReturn, DJIA_MReturn, scale = NA) 


# Tracking error of returns = mean return of the portfolio - mean return of the DJIA (Total five  - one for each portfolio)
#---------------------------------------------------------------------------------------------------------------------------------------
TE5_return   <- (P5_Return  -  Mean_DJIA_Index)
TE10_return <- (P10_Return - Mean_DJIA_Index)
TE15_return <- (P15_Return - Mean_DJIA_Index)
TE20_return <- (P20_Return - Mean_DJIA_Index)
TE25_return <- (P25_Return - Mean_DJIA_Index)

TE <- c(TE5_return,TE10_return,TE15_return,TE20_return,TE25_return)
PN <-  c("Portfolio 5", "Portfolio 10","Portfolio 15","Portfolio 20","Portfolio 25")
Tracking_Error_Return <- setNames(TE, PN)
Tracking_Error_Return

# Tracking error of risk = standard deviation of the portfolio - the standard deviation of the DJIA (you should have five of these - one for each portfolio)
#---------------------------------------------------------------------------------------------------------------------------------------
TE5_risk <-   P5_Standard_Deviation - StDev_DJIA_Index
TE10_risk <- P10_Standard_Deviation - StDev_DJIA_Index
TE15_risk <- P15_Standard_Deviation - StDev_DJIA_Index
TE20_risk <- P20_Standard_Deviation - StDev_DJIA_Index
TE25_risk <- P25_Standard_Deviation - StDev_DJIA_Index

TER <- c(TE5_risk,TE10_risk,TE15_risk,TE20_risk,TE25_risk)
PN <-  c("Portfolio 5", "Portfolio 10","Portfolio 15","Portfolio 20","Portfolio 25")
Tracking_Error_Risk <- setNames(TER, PN)
Tracking_Error_Risk

###########################################################################################################################
# Graphically represent the tracking error for returns and risk (standard deviation of returns used as a proxy for risk)  on y-axis against the sample size of portfolio on the x-axis.
###########################################################################################################################

# Plot for tracking error for returns and risk
plot(Tracking_Error_Return,	type = "l",
				col = "red", 
				xlim= c(1, 5), 
				ylim = c(-0.004, 0.012), 
				xlab = "Portfolio : Randomly picked equally weighted stocks from DJIA", 
				ylab = " Tracking Error : Portfolio wrt DJIA",
				lwd = 2, 
   				main = "Tracking Error for Returns and Risk : Portfolio wrt. DJIA")

lines(Tracking_Error_Risk, type = "l", lwd = 2, col = "blue")
axis(1,  at = 1:5, labels = PN, col.axis = "red", padj = 1.5)

# location of legend within plot area
legend(x = "bottom", bty = "n", horiz = TRUE,  
		xjust = 0, yjust =0, "(x,y)", pch = 1, x.intersp = 0.5, cex = 0.75,
 		c("Tracking Error of Return","Tracking Error of Risk"), 
 		col = c("red", "blue"),
 		lwd = c(2, 2))
 		

#**********************************************************************************************************************************
# The End
#**********************************************************************************************************************************
