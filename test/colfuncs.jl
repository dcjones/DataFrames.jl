module TestColfuncs
	using Base.Test
	using DataArrays
	using DataFrames

	m = [1 2 3; 3 4 6]
	df = DataFrame(m)
	@assert isequal(DataFrame([2.0 3.0 4.5;], names(df)), colmeans(df))
	@assert isequal(DataFrame([4 6 9;], names(df)), colsums(df))
end
