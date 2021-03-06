# Processing Streaming Data

In modern data analysis settings, we often need to work with streaming data
sources. This is particularly important when:

* Data sets are too large to store in RAM
* Data sets are being generated in real time

Julia is well-suited to both. The DataFrames package handles streaming
data by construcing an `AbstractDataStream` object, which is an iterable
object that allows programmers to work with a sequence of small
`DataFrame` objects rather than one large `DataFrame` object.

Conventionally, these small `DataFrame` objects are called minibatches. By
default, Julia generates minibatches that contain **exactly**  one row
of data, but this can be easily changed. To see how an `AbstractDataStream`
works, we'll loop over the rows of a dataset we use for benchmarking
DataFrames.

    using DataFrames

    path = Pkg.dir("DataFrames",
                   "test",
                   "data",
                   "scaling",
                   "10000rows.csv")

    ds = readstream(path)

    for df in ds
    	print(df)
    end

As the input makes clear, every `df` object generated by this for-loop
is a single row of the input data set. To work with larger minibatches,
we use the `nrows` keyword argument:

    ds = readstream(path, nrows = 1_000)

    for df in ds
    	print(df)
    end

**Note that the `df` objects generated during this for-loop are not
separate objects**: the memory used by `df` is rewritten during each
iteration of the loop to make it easier to work with large data sets.
If you need to get a separate object for each minibatch, you need to
call `copy(df)` on each `df` object generated during the loop.
