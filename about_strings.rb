require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutStrings < Neo::Koan
  def test_double_quoted_strings_are_strings
    string = "Hello, World"

      ##assert_equal __, string.is_a?(String)
    assert_equal true, string.is_a?(String)
  end

  def test_single_quoted_strings_are_also_strings
    string = 'Goodbye, World'
    ##assert_equal __, string.is_a?(String)

    assert_equal true, string.is_a?(String)
  end

  def test_use_single_quotes_to_create_string_with_double_quotes
    string = 'He said, "Go Away."'
    ##assert_equal __, string

    assert_equal "He said, \"Go Away.\"", string
    # You use a backslash to 'escape' the double quotes on the inside for your string
  end

  def test_use_double_quotes_to_create_strings_with_single_quotes
    string = "Don't"

    ##assert_equal __, string
    assert_equal 'Don\'t', string
  end

  def test_use_backslash_for_those_hard_cases
    a = "He said, \"Don't\""
    b = 'He said, "Don\'t"'

      ##assert_equal __, a == b
    assert_equal true, a == b
  end

  def test_use_flexible_quoting_to_handle_really_hard_cases
    a = %(flexible quotes can handle both ' and " characters)
    b = %!flexible quotes can handle both ' and " characters!
    c = %{flexible quotes can handle both ' and " characters}
    # The flexible quote operator allows you to define any long string by letting you choose (hence flexible!)
    # the quotes that will delimit it.

    ##assert_equal __, a == b
    assert_equal true, a == b

    ##assert_equal __, a == c
    assert_equal true, a == c

    # The 3 examples above are all equivalent, because you can use any character that follows immediately after
    # the "%" to delimit the string as long as its not a regular non-alphanumeric character.
  end

  def test_flexible_quotes_can_handle_multiple_lines
    long_string = %{
It was the best of times,
It was the worst of times.}

    ##assert_equal __, long_string.length
    assert_equal 53, long_string.length

    ##assert_equal __, long_string.lines.count
    assert_equal 3, long_string.lines.count

    ##assert_equal __, long_string[0,1]
    assert_equal "\n", long_string[0,1]
  end

  def test_here_documents_can_also_handle_multiple_lines
    long_string = <<EOS
It was the best of times,
It was the worst of times.
EOS
    # The 'EOS' word means the 'end of string', but any word can be used here

    ##assert_equal __, long_string.length
    assert_equal 53, long_string.length

    ##assert_equal __, long_string.lines.count
    assert_equal 2, long_string.lines.count

    ##assert_equal __, long_string[0,1]
    assert_equal "I", long_string[0,1]
  end

  def test_plus_will_concatenate_two_strings
    string = "Hello, " + "World"

    ##assert_equal __, string
    assert_equal "Hello, World", string
  end

  def test_plus_concatenation_will_leave_the_original_strings_unmodified
    hi = "Hello, "
    there = "World"

    string = hi + there

    ##assert_equal __, hi
    assert_equal "Hello, ", hi

    ##assert_equal __, there
    assert_equal "World", there
  end

  def test_plus_equals_will_concatenate_to_the_end_of_a_string
    hi = "Hello, "
    there = "World"
    hi += there

    ##assert_equal __, hi
    assert_equal "Hello, World", hi
  end

  def test_plus_equals_also_will_leave_the_original_string_unmodified
    original_string = "Hello, "
    hi = original_string
    there = "World"
    hi += there

    ##assert_equal __, original_string
    assert_equal "Hello, ", original_string
  end

  def test_the_shovel_operator_will_also_append_content_to_a_string
    hi = "Hello, "
    there = "World"
    hi << there

    ##assert_equal __, hi
    assert_equal "Hello, World", hi

    ##assert_equal __, there

  end

  def test_the_shovel_operator_modifies_the_original_string
    original_string = "Hello, "
    hi = original_string
    there = "World"
    hi << there

    ##assert_equal __, original_string
    assert_equal "Hello, World", original_string

    # THINK ABOUT IT:
    #
    # Ruby programmers tend to favor the shovel operator (<<) over the
    # plus equals operator (+=) when building up strings.  Why?
    # ---
    # ANS
    # Because << alters the original string rather than creating a new one, so it has better improvements in
    # regards to memory?
  end

  def test_double_quoted_string_interpret_escape_characters
    string = "\n"
    ##assert_equal __, string.size
    assert_equal 1, string.size
    # The "\n" is the interpreted as the newline character, which is only one character technically
  end

  def test_single_quoted_string_do_not_interpret_escape_characters
    string = '\n'
    ##assert_equal __, string.size

    assert_equal 2, string.size

    # Because single quoted strings don't interpret escape characters, '\n' gets parsed as 2 characters,
    # the backslash and the n
  end

  def test_single_quotes_sometimes_interpret_escape_characters
    string = '\\\''

    #assert_equal __, string.size
    assert_equal 2, string.size

    ##assert_equal __, string
    assert_equal "\\'", string
  end

  def test_double_quoted_strings_interpolate_variables
    value = 123
    string = "The value is #{value}"

    ##assert_equal __, string
    assert_equal "The value is 123", string
  end

  def test_single_quoted_strings_do_not_interpolate
    value = 123
    string = 'The value is #{value}'

    ##assert_equal __, string
    assert_equal 'The value is #{value}', string
  end

  def test_any_ruby_expression_may_be_interpolated
    string = "The square root of 5 is #{Math.sqrt(5)}"

    ##assert_equal __, string
    assert_equal "The square root of 5 is 2.23606797749979", string
    # Like the name of the function implies, ANY function in ruby may be interpolated into a string
  end

  def test_you_can_get_a_substring_from_a_string
    string = "Bacon, lettuce and tomato"

    ##assert_equal __, string[7,3]
    assert_equal "let", string[7,3]

    ##assert_equal __, string[7..9]
    assert_equal "let", string[7..9]
  end

  def test_you_can_get_a_single_character_from_a_string
    string = "Bacon, lettuce and tomato"

    ##assert_equal __, string[1]
    assert_equal "a", string[1]

    # Surprised?
  end

  in_ruby_version("1.8") do
    def test_in_older_ruby_single_characters_are_represented_by_integers
      ##assert_equal __, ?a

      assert_equal __, ?a == 97
      # 'a' in ASCII is the value 97

      assert_equal __, ?b == (?a + 1)
      # in ASCII letters are alphabetically ordered
    end
  end

  in_ruby_version("1.9", "2") do
    def test_in_modern_ruby_single_characters_are_represented_by_strings
      ##assert_equal __, ?a
      assert_equal "a", ?a

      ##assert_equal __, ?a == 97
      assert_equal false, ?a == 97
    end
  end

  def test_strings_can_be_split
    string = "Sausage Egg Cheese"
    words = string.split
    ##assert_equal [__, __, __], words
    assert_equal ["Sausage", "Egg", "Cheese"], words
  end

  def test_strings_can_be_split_with_different_patterns
    string = "the:rain:in:spain"
    words = string.split(/:/)

    ##assert_equal [__, __, __, __], words
    assert_equal ["the", "rain", "in", "spain"], words


    # NOTE: Patterns are formed from Regular Expressions.  Ruby has a
    # very powerful Regular Expression library.  We will become
    # enlightened about them soon.
  end

  def test_strings_can_be_joined
    words = ["Now", "is", "the", "time"]
    ##assert_equal __, words.join(" ")
    assert_equal "Now is the time", words.join(" ")


  end

  def test_strings_are_unique_objects
    a = "a string"
    b = "a string"

    ##assert_equal __, a           == b
    assert true, a == b

    ##assert_equal __, a.object_id == b.object_id
    assert_equal false, a.object_id == b.object_id
  end
end
