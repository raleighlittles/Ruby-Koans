# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  # WRITE THIS CODE

  side_lengths = [a, b, c]
  # if the maximum and minimum of the array are the same, return equilateral
  if (side_lengths.max == side_lengths.min)
    return :equilateral
  end

  # if there are 2 unique values in the array, then its isoceles
  if (side_lengths.uniq.length == 2)
    return :isosceles
  end

  # if there is 3 unique values in the array, then its scalene
  if (side_lengths.uniq.length == 3)
    return :scalene
  end

end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
