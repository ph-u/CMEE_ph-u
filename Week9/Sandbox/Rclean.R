count.primes.C<-function(limit){
		.Call("count_primes_c_wrap", limit = as.integer(limit))
}
