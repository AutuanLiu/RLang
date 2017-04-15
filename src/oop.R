# define a time series class
setClass("TimeSeries",
  representation(
    data  = "numeric",
    start = "POSIXct",
    end   = "POSIXct"
  )
)
# new mothed
setValidity("TimeSeries",
            function(object) {
              object@start <= object@end && 
                length(object@start) == 1 &&
                length(object@end)   == 1
            }
            )
# new object
my.TimeSeries <- new("TimeSeries",
                      data = 1:6,
                     start = as.POSIXct("07/01/2017 0:00:00", tz = "GMT", 
                                        format = "%m/%d/%Y %H:%M:%S"),
                     end   = as.POSIXct("07/01/2017 0:05:00", tz = "GMT", 
                                        format = "%m/%d/%Y %H:%M:%S")
                     )
my.TimeSeries
validObject(my.TimeSeries)
