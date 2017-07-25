require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutSymbols < Neo::Koan
  def test_symbols_are_symbols
    symbol = :ruby

    ##assert_equal __, symbol.is_a?(Symbol)
    assert_equal true, symbol.is_a?(Symbol)

    # An object declared with a ":" is a symbol, and thus has type "Symbol"
  end

  def test_symbols_can_be_compared
    symbol1 = :a_symbol
    symbol2 = :a_symbol
    symbol3 = :something_else

    ##assert_equal __, symbol1 == symbol2
    assert_equal true, symbol1 == symbol2
    # symbol1 and symbol2 are the same

    ##assert_equal __, symbol1 == symbol3
    assert_equal false, symbol1 == symbol3
  end

  def test_identical_symbols_are_a_single_internal_object
    symbol1 = :a_symbol
    symbol2 = :a_symbol

    ##assert_equal __, symbol1           == symbol2
    assert_equal true, symbol1 == symbol2

    ##assert_equal __, symbol1.object_id == symbol2.object_id
    assert_equal true, symbol1.object_id == symbol2.object_id
    # Identical symbols ARE the same object and thus, have the same object id

  end

  def test_method_names_become_symbols
    symbols_as_strings = Symbol.all_symbols.map { |x| x.to_s }

    ##assert_equal __, symbols_as_strings.include?("test_method_names_become_symbols")
  end

  # THINK ABOUT IT:
  #
  # Why do we convert the list of symbols to strings and then compare
  # against the string value rather than against symbols?
  # -- ANS ---
  # Because symbols can only exist in one place at a time, you can't convert to a symbol first and then
  # compare with a string since that would 'clutter' up the symbol space and make it so that you could only have one
  # string for each symbol (i.e. a = "string", b = "string" doesn't mean that a.object_id = b.object id)

  in_ruby_version("mri") do
    RubyConstant = "What is the sound of one hand clapping?"
    def test_constants_become_symbols
      all_symbols_as_strings = Symbol.all_symbols.map { |x| x.to_s }

      ##assert_equal __, all_symbols_as_strings.include?(__)
      assert_equal false, all_symbols_as_strings.include?(:RubyConstant)
    end
  end

  def test_symbols_can_be_made_from_strings
    string = "catsAndDogs"
    ##assert_equal __, string.to_sym
    assert_equal :catsAndDogs, string.to_sym

    # The "to.sym" method takes a string content, and converts it to a symbol and returns that
  end

  def test_symbols_with_spaces_can_be_built
    symbol = :"cats and dogs"

    ##assert_equal __.to_sym, symbol
    assert_equal symbol.to_sym, symbol

    ##
  end

  def test_symbols_with_interpolation_can_be_built
    value = "and"
    symbol = :"cats #{value} dogs"

    ##assert_equal __.to_sym, symbol
    assert_equal symbol.to_sym, symbol
  end

  def test_to_s_is_called_on_interpolated_symbols
    symbol = :cats
    string = "It is raining #{symbol} and dogs."

    ##assert_equal __, string
    assert_equal "It is raining cats and dogs.", string
    # When you interpolate symbols in a string, the "to_s" method is called on them
  end

  def test_symbols_are_not_strings
    symbol = :ruby

    ##assert_equal __, symbol.is_a?(String)
    assert_equal false, symbol.is_a?(String)

    ##assert_equal __, symbol.eql?("ruby")
    assert_equal false, symbol.eql?("ruby")

    # The ".eql?" method only returns to if the two objects refer to the same hash key
  end

  def test_symbols_do_not_have_string_methods
    symbol = :not_a_string

    ##assert_equal __, symbol.respond_to?(:each_char)
    assert_equal false, symbol.respond_to?(:each_char)

    ##assert_equal __, symbol.respond_to?(:reverse)
    assert_equal false, symbol.respond_to?(:reverse)

    # Because symbols are NOT strings, they don't have the string methods defined on them, do respond.to? returns
    # false
  end

  # It's important to realize that symbols are not "immutable
  # strings", though they are immutable. None of the
  # interesting string operations are available on symbols.

  def test_symbols_cannot_be_concatenated
    # Exceptions will be pondered further down the path
    ##assert_raise(___) do
    assert_raise(NoMethodError) do
      :cats + :dogs
    end

    # Because you can't concatenate symbols, trying to use the "+" operator on them returns the NoSuchMethod exception
  end

  def test_symbols_can_be_dynamically_created
    ##assert_equal __, ("cats" + "dogs").to_sym
    assert_equal :catsdogs, ("cats" + "dogs").to_sym
  end

  # THINK ABOUT IT:
  #
  # Why is it not a good idea to dynamically create a lot of symbols?
  ## -- ANS --
  # Memory usage! They're not ever erased until the program ends so creating a lot of them takes up more memory.
end
