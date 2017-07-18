require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutObjects < Neo::Koan
  def test_everything_is_an_object
    # Like the name implies, everything in Ruby is an object!
    assert_equal true, 1.is_a?(Object)
    assert_equal true, 1.5.is_a?(Object)
    assert_equal true, "string".is_a?(Object)
    assert_equal true, nil.is_a?(Object)
    assert_equal true, Object.is_a?(Object)
  end

  def test_objects_can_be_converted_to_strings
    # Remember the .to_s method converts the object to a string to display
    assert_equal '123', 123.to_s

    # nil.to_s always returns the empty string
    assert_equal "", nil.to_s
  end

  def test_objects_can_be_inspected
    # The .inspect method returns the string representation of the object
    assert_equal "123", 123.inspect
    assert_equal 'nil', nil.inspect
  end

  def test_every_object_has_an_id
    obj = Object.new
    ##assert_equal __, obj.object_id.class
    assert_equal Fixnum, obj.object_id.class

    # obj.object_id.class returns the class of the object ID, and in Ruby, the class of objectID are called
    # 'Fixnum' since they hold fixed integer values
  end

  def test_every_object_has_different_id
    obj = Object.new
    another_obj = Object.new

    # Since every object has a different ID, two different objects can't have the same ID
    assert_equal true, obj.object_id != another_obj.object_id
  end

  def test_small_integers_have_fixed_ids
    assert_equal 1, 0.object_id
    assert_equal 3, 1.object_id
    assert_equal 5, 2.object_id
    assert_equal 201, 100.object_id

    # THINK ABOUT IT:
    # What pattern do the object IDs for small integers follow?

    # The pattern is every odd integers. Remember that odd integers follow the formula 2*n + 1
  end

  def test_clone_creates_a_different_object
    obj = Object.new
    copy = obj.clone

    assert_equal true, obj           != copy
    assert_equal true, obj.object_id != copy.object_id

    # The .clone method produces a shallow copy -- the instance variables of the original object are copied,
    # but not the objects they reference
  end
end
