library(MODIS)


# Download Modis data
# 
MODISoptions(localArcPath = "./output/", quiet = FALSE)
# 
# # download data
hdf = getHdf("MOD13A1", collection = "006"
             , tileH = 25, tileV = 07
             ,begin = "2010.01.01", end = "2014.12.31")
