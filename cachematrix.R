## Matrix inversion is usually a costly computation and their is some benefit
## to caching the inverse of a matrix rather than compute it repeatedly. Following
## two functions will do just that. 

## This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
  ## variable i will store the inverse. Initialze it to null.
  i <- NULL
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) i <<- inverse
  getinverse <- function() i
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## This function computes the inverse of the special "matrix" returned by 
## makeCacheMatrix above. If the inverse has already been calculated (and
## the matrix has not changed), then the cachesolve retrieves the inverse 
## from the cache.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  i <- x$getinverse()
  
  ## if store inverse is not null then return the cached value
  ## without computing it again, saving some time.
  if(!is.null(i)) {
    message("getting cached data")
    return(i)
  }
  
  ## if cached inverse is null then lets get the inverse using R's 
  ## solve() method. 
  data <- x$get()
  i <- solve(data, ...)
  
  ## before returning the inverse, lets cache it to it can be reused 
  x$setinverse(i)
  i
}
