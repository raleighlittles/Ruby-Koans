# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutRegularExpressions < Neo::Koan
  def test_a_pattern_is_a_regular_expression
    ##assert_equal __, /pattern/.class
    assert_equal Regexp, /pattern/.class

    # 'Regexp' is the class name for regul;ar expressions
  end

  def test_a_regexp_can_search_a_string_for_matching_content
    ##assert_equal __, "some matching content"[/match/]
    assert_equal "match", "some matching content"[/match/]
  end

  def test_a_failed_match_returns_nil
    ##assert_equal __, "some matching content"[/missing/]
    assert_equal nil, "some matching content"[/missing/]
  end

  # ------------------------------------------------------------------

  def test_question_mark_means_optional
    ##assert_equal __, "abbcccddddeeeee"[/ab?/]
    assert_equal "ab", "abbcccddddeeeee"[/ab?/]
    # The "?" on the right of the 'b' means that the 'b' search was optional

    ##assert_equal __, "abbcccddddeeeee"[/az?/]
    assert_equal "a", "abbcccddddeeeee"[/az?/]
    # The "?" on the right of the 'z' meant that z was optional, since it wasn't found, the next closest thing
    # (just regular 'a') was returned
  end

  def test_plus_means_one_or_more

    ##assert_equal __, "abbcccddddeeeee"[/bc+/]
    assert_equal "bccc", "abbcccddddeeeee"[/bc+/]

    # The "+" sign on the "c" meant to search for one or more occurences of the 'c' in the given string, here 'c'
    # appeared 3 times so we match all 3 occurences
  end

  def test_asterisk_means_zero_or_more

    ##assert_equal __, "abbcccddddeeeee"[/ab*/]
    assert_equal "abb", "abbcccddddeeeee"[/ab*/]

    ##assert_equal __, "abbcccddddeeeee"[/az*/]
    assert_equal "a", "abbcccddddeeeee"[/az*/]

    ##assert_equal __, "abbcccddddeeeee"[/z*/]
    assert_equal "", "abbcccddddeeeee"[/z*/]
    # Rather than returning nil, we return an empty string since our earlier search parameter 'z' was at 0 or more

    # THINK ABOUT IT:
    #
    # When would * fail to match?
    ## -- Ans ---
    # Technically never, since it would always return an empty string

  end

  # THINK ABOUT IT:
  #
  # We say that the repetition operators above are "greedy."
  #
  # Why?
  # -- Ans --
  # They're considered greedy because they have to check the entire string to return a result? (Hence like a normal
  # Greedy algorithm would)

  # ------------------------------------------------------------------

  def test_the_left_most_match_wins
    ## assert_equal __, "abbccc az"[/az*/]
    assert_equal "a", "abbccc az"[/az*/]

    # The regex matches starting from left to right
  end

  # ------------------------------------------------------------------

  def test_character_classes_give_options_for_a_character
    animals = ["cat", "bat", "rat", "zat"]

    ##assert_equal __, animals.select { |a| a[/[cbr]at/] }
    assert_equal ["cat", "bat", "rat"], animals.select{ |a| a[/[cbr]at/] }

    # The regex matches for any string starting with either c,b, or 'r' and ending in 'at'
  end

  def test_slash_d_is_a_shortcut_for_a_digit_character_class

    ##assert_equal __, "the number is 42"[/[0123456789]+/]
    assert_equal "42", "the number is 42"[/[0123456789]+/]

    ##assert_equal __, "the number is 42"[/\d+/]
    assert_equal "42", "the number is 42"[/\d+/]
  end

  def test_character_classes_can_include_ranges
    ##assert_equal __, "the number is 42"[/[0-9]+/]
    assert_equal "42", "the number is 42"[/[0-9]+/]
  end

  def test_slash_s_is_a_shortcut_for_a_whitespace_character_class
    ##assert_equal __, "space: \t\n"[/\s+/]
    assert_equal " \t\n", "space: \t\n"[/\s+/]
  end

  def test_slash_w_is_a_shortcut_for_a_word_character_class
    # NOTE:  This is more like how a programmer might define a word.
    ## assert_equal __, "variable_1 = 42"[/[a-zA-Z0-9_]+/]
    assert_equal "variable_1", "variable_1 = 42"[/[a-zA-Z0-9_]+/]

    ##assert_equal __, "variable_1 = 42"[/\w+/]
    assert_equal "variable_1", "variable_1 = 42"[/\w+/]

    # 'variable_1' is the first word technically since it doesn't have any spaces between it
  end

  def test_period_is_a_shortcut_for_any_non_newline_character
    ##assert_equal __, "abc\n123"[/a.+/]
    assert_equal "abc", "abc\n123"[/a.+/]

    # any non-newline character regex here would return everyting up to "\n"
  end

  def test_a_character_class_can_be_negated
    ##assert_equal __, "the number is 42"[/[^0-9]+/]
    assert_equal "the number is ", "the number is 42"[/[^0-9]+/]
  end

  def test_shortcut_character_classes_are_negated_with_capitals
    ##assert_equal __, "the number is 42"[/\D+/]
    assert_equal "the number is ", "the number is 42"[/\D+/]

    ##assert_equal __, "space: \t\n"[/\S+/]
    assert_equal "space:", "space: \t\n"[/\S+/]
    # ... a programmer would most likely do

    ##assert_equal __, "variable_1 = 42"[/[^a-zA-Z0-9_]+/]
    assert_equal " = ", "variable_1 = 42"[/[^a-zA-Z0-9_]+/]

    ##assert_equal __, "variable_1 = 42"[/\W+/]
    assert_equal " = ", "variable_1 = 42"[/\W+/]
  end

  # ------------------------------------------------------------------

  def test_slash_a_anchors_to_the_start_of_the_string

    ##assert_equal __, "start end"[/\Astart/]
    assert_equal "start", "start end"[/\Astart/]

    ##assert_equal __, "start end"[/\Aend/]
    assert_equal nil, "start end"[/\Aend/]
  end

  def test_slash_z_anchors_to_the_end_of_the_string

    ##assert_equal __, "start end"[/end\z/]
    assert_equal "end", "start end"[/end\z/]

    ##assert_equal __, "start end"[/start\z/]
    assert_equal nil, "start end"[/start\z/]
  end

  def test_caret_anchors_to_the_start_of_lines

    ##assert_equal __, "num 42\n2 lines"[/^\d+/]
    assert_equal "2", "num 42\n2 lines"[/^\d+/]
  end

  def test_dollar_sign_anchors_to_the_end_of_lines

    ##assert_equal __, "2 lines\nnum 42"[/\d+$/]
    assert_equal "42", "2 lines\nnum 42"[/\d+$/]
  end

  def test_slash_b_anchors_to_a_word_boundary

    ##assert_equal __, "bovine vines"[/\bvine./]
    assert_equal "vines", "bovine vines"[/\bvine./]
  end

  # ------------------------------------------------------------------

  def test_parentheses_group_contents
    ##assert_equal __, "ahahaha"[/(ha)+/]
    assert_equal "hahaha", "ahahaha"[/(ha)+/]
  end

  # ------------------------------------------------------------------

  def test_parentheses_also_capture_matched_content_by_number
    ##assert_equal __, "Gray, James"[/(\w+), (\w+)/, 1]
    assert_equal "Gray", "Gray, James"[/(\w+), (\w+)/, 1]

    ##assert_equal __, "Gray, James"[/(\w+), (\w+)/, 2]
    assert_equal "James", "Gray, James"[/(\w+), (\w+)/, 2]
  end

  def test_variables_can_also_be_used_to_access_captures
    ##assert_equal __, "Name:  Gray, James"[/(\w+), (\w+)/]
    assert_equal "Gray, James", "Name:  Gray, James"[/(\w+), (\w+)/]

    ##assert_equal __, $1
    assert_equal "Gray", $1

    ##assert_equal __, $2
    assert_equal "James", $2
  end

  # ------------------------------------------------------------------

  def test_a_vertical_pipe_means_or
    grays = /(James|Dana|Summer) Gray/
    ##assert_equal __, "James Gray"[grays]
    assert_equal ("James Gray"), "James Gray"[grays]

    ##assert_equal __, "Summer Gray"[grays, 1]
    assert_equal ("Summer"), "Summer Gray"[grays, 1]

    ##assert_equal __, "Jim Gray"[grays, 1]
    assert_equal nil, "Jim Gray"[grays, 1]
    # Jim doesn't show up anywhere in grays
  end

  # THINK ABOUT IT:
  #
  # Explain the difference between a character class ([...]) and alternation (|).

  # ------------------------------------------------------------------

  # ANSWER

  # Character classes matching is quicker than alternations?

  def test_scan_is_like_find_all
    ##assert_equal __, "one two-three".scan(/\w+/)
    assert_equal ["one", "two", "three"], "one two-three".scan(/\w+/)
  end

  def test_sub_is_like_find_and_replace
    ## assert_equal __, "one two-three".sub(/(t\w*)/) { $1[0, 1] }
    assert_equal "one t-three", "one two-three".sub(/(t\w*)/) { $1[0, 1] }

    # Here you're replacing the "wo" with the
  end

  def test_gsub_is_like_find_and_replace_all
    ##assert_equal __, "one two-three".gsub(/(t\w*)/) { $1[0, 1] }
    assert_equal "one t-t", "one two-three".gsub(/(t\w*)/) { $1[0, 1] }

    # Here you're replacing both 'words' that start with the letter t

  end
end
