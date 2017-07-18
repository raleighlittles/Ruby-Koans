require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrays < Neo::Koan
  def test_creating_arrays
    empty_array = Array.new

    ##  assert_equal __, empty_array.class
    assert_equal Array, empty_array.class

    # Because we initialized our empty_array with the new operator on Array, our object has class of 'Array'

    assert_equal 0, empty_array.size
  end

  def test_array_literals
    array = Array.new
    assert_equal [], array

    array[0] = 1
    assert_equal [1], array

    array[1] = 2
    ## assert_equal [1, __], array
    assert_equal [1,2], array
    # The second element (position 1) in array was initialized as 2

    array << 333

    ## assert_equal __, array
    assert_equal [1,2,333], array
    # For arrays and strings, the '<<' operator means 'append'
  end

  def test_accessing_array_elements
    array = [:peanut, :butter, :and, :jelly]
    # The ':' operator is called a 'symbol'. Symbols can be thought of as string objects with all the string methods
    # removed. Basically you're initializing a variable name with a string. If you have two objects with the same symbol,
    # they map to the same location in memory bewcause they're the same variable

    ## assert_equal __, array[0]
    assert_equal :peanut, array[0]

    ## assert_equal __, array.first
    assert_equal :peanut, array.first
    # The .first method on arrays returns the first element of the array

    ## assert_equal __, array[3]
    assert_equal :jelly, array[3]

    ## assert_equal __, array.last
    assert_equal :jelly, array.last
    # The .last method returns the last entry in the array

    ## assert_equal __, array[-1]
    assert_equal :jelly, array[-1]
    # The negative array access syntax works the same as in python
    # with -1 being the last, -2 being the second to last, -3 being the third to last, etc..

    ## assert_equal __, array[-3]
    assert_equal :butter, array[-3]
  end

  def test_slicing_arrays
    array = [:peanut, :butter, :and, :jelly]
    # The syntax for array slicing in Ruby is array[s, n] where s is the starting point and
    # n is the length of slice to take. Note that array slices always return an array.

    ## assert_equal __, array[0,1]
    assert_equal [:peanut], array[0,1]

    ##assert_equal __, array[0,2]
    assert_equal [:peanut, :butter], array[0,2]

    ##assert_equal __, array[2,2]
    assert_equal [:and, :jelly], array[2,2]

    ##assert_equal __, array[2,20]
    assert_equal [:and, :jelly], array[2,20]

    ##assert_equal __, array[4,0]
    assert_equal [], array[4,0]
    # There is no element in position #4 so any slice returned starting from here is empty,
    # (regardless of how long the slice is), since array slicing doesn't loop around to the
    # beginning like it would in python

    ##assert_equal __, array[4,100]
    assert_equal [], array[4,100]

    ##assert_equal __, array[5,0]
    assert_equal nil, array[5,0]
    # Any array slice with length 0 is nil
  end

  def test_arrays_and_ranges
    ##assert_equal __, (1..5).class
    assert_equal Range, (1..5).class

    assert_not_equal [1,2,3,4,5], (1..5)
    # Arrays (left) are Different from Ranges (right)

    ##assert_equal __, (1..5).to_a
    assert_equal [1,2,3,4,5], (1..5).to_a

    # Declaring a Range with 2 periods ('..') means go from starting value to (and including)
    # the ending value

    ##assert_equal __, (1...5).to_a
    assert_equal [1,2,3,4], (1...5).to_a

    # Declaring a Range with 3 periods ('...'), means go from starting value to ending value BUT
    # don't include the ending value
  end

  def test_slicing_with_ranges
    array = [:peanut, :butter, :and, :jelly]

    ##assert_equal __, array[0..2]
    assert_equal [:peanut, :butter, :and], array[0..2]

    ##assert_equal __, array[0...2]
    assert_equal [:peanut, :butter], array[0...2]

    ##assert_equal __, array[2..-1]
    assert_equal [:and, :jelly], array[2..-1]
  end

  def test_pushing_and_popping_arrays
    array = [1,2]
    array.push(:last)

    # The array.push command appends an object, in this case the ":last" symbol to the
    # END of the array, sort of like Python's append()

    ##assert_equal __, array
    assert_equal [1,2,:last], array

    popped_value = array.pop

    ##assert_equal __, popped_value
    assert_equal :last, popped_value
    # Array.pop returns the value at the end of the array

    ##assert_equal __, array
    assert_equal [1,2], array
  end

  def test_shifting_arrays
    array = [1,2]
    array.unshift(:first)
    # The array.first function 'prepends' the array with the certain value

    ##assert_equal __, array
    assert_equal [:first, 1, 2], array

    shifted_value = array.shift
    # The array.shift command returns the first entry in a given a, and shifts all subsequent
    # entries to the left 1 spot to account for the newfound vacancy

    ##assert_equal __, shifted_value
    assert_equal :first, shifted_value

      ##assert_equal __, array
      assert_equal [1,2], array
  end

end
