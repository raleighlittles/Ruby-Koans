require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrayAssignment < Neo::Koan
  def test_non_parallel_assignment
    names = ["John", "Smith"]
    ##assert_equal __, names
    assert_equal ["John", "Smith"], names
  end

  def test_parallel_assignments
    first_name, last_name = ["John", "Smith"]
    # This works similar to how tuples work in Python
    # Here you're saying essentially: Let first_name = John, last_name = Smith

    ## assert_equal __, first_name
    assert_equal "John", first_name

    ##assert_equal __, last_name
    assert_equal "Smith", last_name
  end

  def test_parallel_assignments_with_extra_values
    first_name, last_name = ["John", "Smith", "III"]
    # Here the only part that gets assigned a variable name is only John or Smith (first and last), since there is no
    # third variable, the "III" part doesn't get mapped to a variable

    ##assert_equal __, first_name
    assert_equal "John", first_name

    ##assert_equal __, last_name
    assert_equal "Smith", last_name
  end

  def test_parallel_assignments_with_splat_operator
    first_name, *last_name = ["John", "Smith", "III"]
    # The splat operator "*" here maps the rest of the items in the array to the second variable
    # So after the first gets mapped to first name, the last 2 (or really any other proceeding parts of the array) would
    # Get mapped to the second variable

    ##assert_equal __, first_name
    assert_equal "John", first_name

    ##assert_equal __, last_name
    assert_equal ["Smith", "III"], last_name
  end

  def test_parallel_assignments_with_too_few_variables
    first_name, last_name = ["Cher"]

    ##assert_equal __, first_name
    assert_equal "Cher", first_name

    ##assert_equal __, last_name
    assert_equal nil, last_name
    # This is where nil comes in. The last_name variable gets initialized but never set to anything so it is nil
  end

  def test_parallel_assignments_with_subarrays
    first_name, last_name = [["Willie", "Rae"], "Johnson"]
    # Here, first_name gets initialized as the first element in the outer array, which is actually a subarray
    # Last name gets initialized to the 2nd element in the outer array, which is a regular string

    ##assert_equal __, first_name

    assert_equal ["Willie", "Rae"], first_name

    ##assert_equal __, last_name
    assert_equal "Johnson", last_name
  end

  def test_parallel_assignment_with_one_variable
    first_name, = ["John", "Smith"]

    ##assert_equal __, first_name
    assert_equal "John", first_name
  end

  def test_swapping_with_parallel_assignment
    first_name = "Roy"
    last_name = "Rob"

    first_name, last_name = last_name, first_name
    # Variable swap

    ##assert_equal __, first_name
    assert_equal "Rob", first_name

    ##assert_equal __, last_name
    assert_equal "Roy", last_name
  end
end
