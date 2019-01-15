class Array
  # Write a new `Array#merge_sort` method; it should not modify the
  # array it is called on, but create a new sorted array.
  def merge_sort(&prc)
    return clone if clone.length <= 1
    prc ||= Proc.new {|a,b| a <=> b}
    clone = self.dup
    mid = self.length / 2
    sorted_left = clone.take(mid).merge_sort(&prc)
    sorted_right = clone.drop(mid).merge_sort(&prc)
    Array.merge(sorted_left, sorted_right, &prc)
  end

  private
  def self.merge(left, right, &prc)
    prc ||= Proc.new {|a,b| a <=> b}
    res = []
    until left.empty? || right.empty?
      case prc.call(left.first, right.first)
      when 0
        res << left.shift
      when -1
        res << left.shift
      when 1
        res << right.shift
      end
    end
    res + left + right
  end
end

class Array
  # Write a new `Array#pair_sum(target)` method that finds all pairs of
  # positions where the elements at those positions sum to the target.

  # NB: ordering matters. I want each of the pairs to be sorted
  # smaller index before bigger index. I want the array of pairs to be
  # sorted "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def pair_sum(target)
    pairs = []
    i = 0
    while i < self.length - 1
      j = i + 1
      while j < self.length
        if self[i] + self[j] == target 
          pairs << [i, j]
        end
        j += 1
      end
      i += 1 
    end
    pairs
  end
end

class Array
  # Write a method that flattens an array to the specified level. If no level
  # is specified, it should entirely flatten nested arrays.

  # Examples:
  # Without an argument:
  # [["a"], "b", ["c", "d", ["e"]]].my_flatten = ["a", "b", "c", "d", "e"]

  # When given 1 as an argument:
  # (Flattens the first level of nested arrays but no deeper)
  # [["a"], "b", ["c", "d", ["e"]]].my_flatten(1) = ["a", "b", "c", "d", ["e"]]

  def my_flatten(level = nil)
    res = []
    if level
      return self if level <= 0
      self.each do |el|
        if el.is_a?(Array)
          res += el.my_flatten(level - 1)
        else
          res << el 
        end
      end
      res
    else
      return [] if self.empty?
      self.each do |el|
        if el.is_a?(Array)
          res += el.my_flatten(level)
        else
          res << el 
        end
      end
      res
    end
  end
end

class String
  # Write a `String#symmetric_substrings` method that returns all
  # substrings which are equal to their reverse image ("abba" ==
  # "abba"). We should only include substrings of length > 1.

  def symmetric_substrings
    res = []
    i = 0
    while i < self.length - 1
      j = i + 1
      while j < self.length
        if self[i..j] == self[i..j].reverse
          res << self[i..j]
        end
        j += 1
      end
      i += 1
    end
    res.uniq
  end
end

def is_prime?(n)
  return false if n == 1 || n == 0
  return true if n == 2
  (2...n).each do |div|
    return false if n % div == 0
  end
  true
end

#Write a method that returns the nth prime number
def nth_prime(n)
  arr = []
  i = 2
  while arr.length < n 
    arr << i if is_prime?(i)
    i += 1
  end
  arr.last
end

class Array
  # Write a method that calls a passed block for each element of the array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end
end

class Array
  # Write an array method that returns an array made up of the
  # elements in the array that return `true` from the given block
  def my_select(&prc)
    res = []
    self.each do |el|
      if prc.call(el)
        res << el
      end
    end
    res
  end
end

