require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutHashes < Neo::Koan
  def test_creating_hashes
    empty_hash = Hash.new
    # Hashes are key-value pairs mapping, analogous to 'dictionaries' in Python

    ##assert_equal __, empty_hash.class
    assert_equal Hash, empty_hash.class
    # Since empty_hash was initialized with the new() method on the object Hash, Hash is the class of the object

    ##assert_equal(__, empty_hash)
    assert_equal ({}), empty_hash
    # An empty hash has a value of just "{}" which needs to be enclosed in a parenthesis for comparison

    ##assert_equal __, empty_hash.size
    assert_equal 0, empty_hash.size
    # Hashes have an initial size of 0
  end

  def test_hash_literals
    hash = { :one => "uno", :two => "dos" }

    ##assert_equal __, hash.size
    assert_equal 2, hash.size
  end

  def test_accessing_hashes
    hash = { :one => "uno", :two => "dos" }

    ##assert_equal __, hash[:one]
    assert_equal "uno", hash[:one]
    # Hashes are accessed by their key, just like regular dictionaries are

    ##assert_equal __, hash[:two]
    assert_equal "dos", hash[:two]

    ##assert_equal __, hash[:doesnt_exist]
    assert_equal nil, hash[:doesnt_exist]
    # If you try to access a key that doesn't exist in the Hash, you get nil

  end

  def test_accessing_hashes_with_fetch
    hash = { :one => "uno" }

    ## assert_equal __, hash.fetch(:one)
    assert_equal "uno", hash.fetch(:one)
    # hash.fetch() is a more advanced accessing method for hashes

    ##assert_raise(___) do
    assert_raise KeyError do
      # If you try to use hash.fetch() on a key that doesn't exist, rather than getting back nil, you get the expected
      # 'KeyError' exception
      hash.fetch(:doesnt_exist)
    end

    # THINK ABOUT IT:
    #
    # Why might you want to use #fetch instead of #[] when accessing hash keys?
    # ----
    # Ans: In the case that you want to check if a key is valid by checking a KeyError, or if you want to have a
    # default return value, then you should use hash.fetch

  end

  def test_changing_hashes
    hash = { :one => "uno", :two => "dos" }
    hash[:one] = "eins"
    # Hashes are immutable! So now the hash is:

    ##expected = { :one => __, :two => "dos" }
    expected = {:one => "eins", :two => "dos" }

    ## assert_equal __, hash
    assert_equal expected, hash

    # Bonus Question: Why was "expected" broken out into a variable
    # rather than used as a literal?

    # --- Ans --
    # For ease of syntax. Recall from earlier that you CANT do assert_equal <hash literal here>, my_hash. Storing the
    # hash (expected) as an intermediate variable and then checking against was easier so that you wouldn't have to do
    # assert_equal ( {:one => "eins", :two => "dos" } ), hash -- NOTE the parenthesis around the first argument
  end

  def test_hash_is_unordered
    hash1 = { :one => "uno", :two => "dos" }
    hash2 = { :two => "dos", :one => "uno" }

    ##assert_equal __, hash1 == hash2
    assert_equal true, hash1 == hash2
    # Since hashes are unordered, both of the above hashes are equal

  end

  def test_hash_keys
    hash = { :one => "uno", :two => "dos" }

    ##assert_equal __, hash.keys.size
    assert_equal 2, hash.keys.size
    # hash.keys returns an array of the keys for the hash, and here are the 2 elements in the hash so there are 2 keys

    ##assert_equal __, hash.keys.include?(:one)
    assert_equal true, hash.keys.include?(:one)
   # The .include? method checks if a certain item is in the corresponding array, and since :one IS one of the keys,
    # it returns true

    ##assert_equal __, hash.keys.include?(:two)
    assert_equal true, hash.keys.include?(:two)

    ##assert_equal __, hash.keys.class
    assert_equal Array, hash.keys.class
    # Remember that hash.keys returns an array
  end

  def test_hash_values
    hash = { :one => "uno", :two => "dos" }
    ##assert_equal __, hash.values.size
    assert_equal 2, hash.values.size

    ##assert_equal __, hash.values.include?("uno")
    assert_equal true, hash.values.include?("uno")

    ##assert_equal __, hash.values.include?("dos")
    assert_equal true, hash.values.include?("dos")

    ##assert_equal __, hash.values.class
    assert_equal Array, hash.values.class
  end

  def test_combining_hashes
    hash = { "jim" => 53, "amy" => 20, "dan" => 23 }
    new_hash = hash.merge({ "jim" => 54, "jenny" => 26 })

    ##assert_equal __, hash != new_hash
    assert_equal true, hash != new_hash

    ##expected = { "jim" => __, "amy" => 20, "dan" => 23, "jenny" => __ }
    expected = { "jim" => 54, "amy" => 20, "dan" => 23, "jenny" => 26 }


    ##assert_equal __, expected == new_hash
    assert_equal true, expected == new_hash
  end

  def test_default_value
    hash1 = Hash.new
    hash1[:one] = 1

    ##assert_equal __, hash1[:one]
    assert_equal 1, hash1[:one]

    ##assert_equal __, hash1[:two]
    assert_equal nil, hash1[:two]

    hash2 = Hash.new("dos")
    # By passing a parameter into the "new" argument on the Hash, you're setting the default
    # value

    hash2[:one] = 1

    ##assert_equal __, hash2[:one]
    assert_equal 1, hash2[:one]

    # Even though hash2 doesn't have a :one key, it returns the value "dos" because that is the
    # default value

    ##assert_equal __, hash2[:two]
    assert_equal "dos", hash2[:two]
  end

  def test_default_value_is_the_same_object
    hash = Hash.new([])

    hash[:one] << "uno"
    hash[:two] << "dos"

    ##assert_equal __, hash[:one]
    assert_equal ["uno", "dos"], hash[:one]

    ##assert_equal __, hash[:two]
    assert_equal ["uno", "dos"], hash[:two]

    ##assert_equal __, hash[:three]
    assert_equal ["uno", "dos"], hash[:three]

    ##assert_equal __, hash[:one].object_id == hash[:two].object_id
    assert_equal true, hash[:one].object_id == hash[:two].object_id
  end

  def test_default_value_with_block
    hash = Hash.new {|hash, key| hash[key] = [] }
    # Here the default value is set as an empty array

    hash[:one] << "uno"
    hash[:two] << "dos"

    ##assert_equal __, hash[:one]
    assert_equal ["uno"], hash[:one]

    ##assert_equal __, hash[:two]
    assert_equal ["dos"], hash[:two]

    ##assert_equal __, hash[:three]
    assert_equal [], hash[:three]
  end
end
