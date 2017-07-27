require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutControlStatements < Neo::Koan

  def test_if_then_else_statements
    if true
      result = :true_value
    else
      result = :false_value
    end
    ##assert_equal __, result
    assert_equal :true_value, result
  end

  def test_if_then_statements
    result = :default_value
    if true
      result = :true_value
    end
    ##assert_equal __, result
    assert_equal :true_value, result
  end

  def test_if_statements_return_values
    value = if true
              :true_value
            else
              :false_value
            end
    ##assert_equal __, value
    assert_equal :true_value, value

    value = if false
              :true_value
            else
              :false_value
            end
    ##assert_equal __, value
    assert_equal :false_value, value

    # NOTE: Actually, EVERY statement in Ruby will return a value, not
    # just if statements.
  end

  def test_if_statements_with_no_else_with_false_condition_return_value
    value = if false
              :true_value
            end
    ##assert_equal __, value
    assert_equal nil, value
  end

  def test_condition_operators
    ##assert_equal __, (true ? :true_value : :false_value)
    assert_equal :true_value, (true ? :true_value : :false_value)

    # Works the same as the ternary operator in C++

    ##assert_equal __, (false ? :true_value : :false_value)
    assert_equal :false_value, (false ? :true_value : :false_value)
  end

  def test_if_statement_modifiers
    result = :default_value
    result = :true_value if true

    ##assert_equal __, result
    assert_equal :true_value, result
  end

  def test_unless_statement
    result = :default_value
    unless false    # same as saying 'if !false', which evaluates as 'if true'
      result = :false_value
    end
    ##assert_equal __, result
    assert_equal :false_value, result
  end

  def test_unless_statement_evaluate_true
    result = :default_value
    unless true    # same as saying 'if !true', which evaluates as 'if false'
      result = :true_value
    end
    ##assert_equal __, result
    assert_equal :default_value, result
  end

  def test_unless_statement_modifier
    result = :default_value
    result = :false_value unless false

    ##assert_equal __, result
    assert_equal :false_value, result
  end

  def test_while_statement
    i = 1
    result = 1
    while i <= 10
      result = result * i
      i += 1
    end
    ##assert_equal __, result
    assert_equal 1*2*3*4*5*6*7*8*9*10, result
    # Evaluates to 3628800
  end

  def test_break_statement
    i = 1
    result = 1
    while true
      break unless i <= 10
      result = result * i
      i += 1
    end
    ##assert_equal __, result
    assert_equal 3628800, result
    # While loop 'breaks' when i > 10, which is the same condition as the function above, so the answer is the same
  end

  def test_break_statement_returns_values
    i = 1
    result = while i <= 10
      break i if i % 2 == 0
      i += 1
    end

    ## assert_equal __, result
    assert_equal 2, result

    # The while loop returns the value of i once i % 2 == 0, the first number for which this is true is 2 itself
  end

  def test_next_statement
    i = 0
    result = []
    while i < 10
      i += 1
      next if (i % 2) == 0
      result << i
    end
    ##assert_equal __, result
    assert_equal [1,3,5,7,9], result

    # The 'next if' statement here tells the program to go on to the next iteration of the loop if the condition after
    # the next statement is true (is i even?), which is why only the odd values of i get stored in the array
  end

  def test_for_statement
    array = ["fish", "and", "chips"]
    result = []
    for item in array
      result << item.upcase
    end
    ##assert_equal [__, __, __], result
    assert_equal ["FISH", "AND", "CHIPS"], result
    # The upcase method on the string converts to uppercase
  end

  def test_times_statement
    sum = 0
    10.times do
      sum += 1
    end
    ##assert_equal __, sum
    assert_equal 10, sum
  end

end
