require "byebug"
def range(start, end1)
    return [] if end1 <= start
    range(start, end1 - 1) << end1 - 1
end

# p range(1, 4)
# p range(6, 4)
# p range(1, 8)

def sum_of_array_iter(arr)
    sum = 0
    arr.each { |ele| sum += ele }
    sum
end

# p sum_of_array_iter([1, 2, 3])
# p sum_of_array_iter([])
# p sum_of_array_iter([1, 2, 3, 4, 5, 6, 7])

def sum_of_array_rec(arr)
    return 0 if arr.empty?
    arr[0] + sum_of_array_rec(arr[1..-1])
end

# p sum_of_array_rec([1, 2, 3])
# p sum_of_array_rec([])
# p sum_of_array_rec([1, 2, 3, 4, 5, 6, 7])

# Exponentiation
# Write two versions of exponent that use two different recursions:
# this is math, not Ruby methods.
def exponent_v1(b, power)
    return 1 if power == 0
    
    b * exponent_v1(b,power - 1)

end

# recursion 1

# p exponent_v1(1, 0) #= 1
# p exponent_v1(2, 2) #= b * exp(b, n - 1)
# p exponent_v1(3, 2)
# p exponent_v1(2, 3) 
# p exponent_v1(10, 0) 

def exponent_v2(b, power)
    return 1 if power == 0

    half = exponent_v2(b, power/2) 
    if power.even?
        half * half
    else 
        b * half * half
    end
end
# # recursion 2
# p exponent_v2(b, 0) = 1
# p exponent_v2(b, 1) = b
# p exponent_v2(b, n) = exp(b, n / 2) ** 2             #[for even n]
# # p exponent_v2(b, n) = b * (exp(b, (n - 1) / 2) ** 2) #[for odd n]

# p exponent_v2(1, 0) #= 1
# p exponent_v2(2, 2) #= b * exp(b, n - 1)
# p exponent_v2(3, 2)
# p exponent_v2(2, 3) 
# p exponent_v2(10, 0)

# Deep dup
# The #dup method doesn't make a deep copy:


class Array
    def deep_dup
        new_arr = []

        self.each do |ele|
            if ele.is_a?(Array)
                new_arr << ele.deep_dup
            else
                new_arr << ele
            end
        end
        new_arr
    end
end


def fibs_rec(n)
    return [] if n == 0
    return [0] if n == 1
    return [0, 1] if n == 2

    prev = fibs_rec(n - 1)
    next_num = prev[-1] + prev[-2]
    
    prev + [next_num]
end

# p fibs_rec(1)
# p fibs_rec(2)
# p fibs_rec(8)


def fibs_iter(n)
    return [] if n == 0
    return [0] if n == 1
    
    seq = [0, 1]
    #count number of elements
    while seq.count < n
        seq << seq[-2] + seq[-1]
    end
    return seq
end

# p fibs_iter(1)
# p fibs_iter(2)
# p fibs_iter(8)

def bsearch(array, target)
    return nil if array.empty?

     idx = array.length / 2
    #  target array[idx]
    #  left = array[0...idx]
    #  right = array[idx+1..-1]
     if target < array[idx]
        bsearch(array.take(idx), target)
     elsif target > array[idx]
        sub_arr = bsearch(array.drop(idx + 1), target)
        if sub_arr.nil?
            nil
        else
            (idx + 1) + sub_arr
        end
    # elsif sub_arr1.nil? && sub_arr2.nil?
     else 
        idx  
     end
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

class Array
    def merge_sort
        return self if self.length < 2
        mid = self.length / 2
        left = self.take(mid)
        right = self.drop(mid)

        left = self.take(mid)
        right = self.drop(mid)

        sorted_left = left.merge_sort
        sorted_right = right.merge_sort

        merge(sorted_left, sorted_right)
    end

    def merge(left, right)
        new_arr = []
        while !left.empty? && !right.empty?
            if (left[0] < right[0])
                new_arr << left.shift
            else
                new_arr << right.shift
            end
        end

        return new_arr + left + right
    end
end

# arr1 = [2, 4, 1, 12, 32, 8]
# arr2 = [2, 4, 1, 10, 32, 8, 12]
# p arr1.merge_sort
# p arr2.merge_sort
class Array
    def subsets
        return [[]] if empty?
        # debugger
        subsets1 = take(self.count - 1).subsets
        subsets1.concat(subsets1.map do |sub| 
            # debugger
            sub + [self.last] 
        end)
    end
end
# p [].subsets # => [[]]
# p [1].subsets # => [[], [1]]
# p [1, 2].subsets # => [[], [1], [2], [1, 2]]
# p [1, 2, 3].subsets
# # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]


def permutations(array)
    return [array] if array.length <= 1

    first_ele = array.shift

    new_arr = []

    permutations(array).each do |permutation|
        (0..permutation.length).each do |i|
            new_arr << permutation[0...i] + [first_ele] + permutation[i..-1]
        end
    end
    new_arr
end

# permutations([1, 2, 3]) # => [[1, 2, 3], [1, 3, 2],
#                         #     [2, 1, 3], [2, 3, 1],
#                         #     [3, 1, 2], [3, 2, 1]]

# p [1, 2, 3].permutation.to_a  # => [[1, 2, 3], [1, 3, 2],
#                             #     [2, 1, 3], [2, 3, 1],
                                # [3, 1, 2], [3, 2, 1]]


def make_better_change(target, coins = [25, 10, 5, 1])
    return [] if target == 0

    return nil if coins.none? {|coin| coin <= target}

    sorted_coins = coins.sort.reverse # descending order

    best_change = nil
    # debugger
    sorted_coins.each_with_index do |coin, idx|
        # debugger
        next if coin > target
            # debugger
            # change += make_change(amount, coins.drop(idx))
            remainder = target - coin
            best = make_better_change(remainder, coins.drop(idx))
        next if best.nil?
            # debugger
            change = [coin] + best
        if best_change.nil? || (change.count < best_change.count)
            # debugger
            best_change = change
        end
    end
    best_change
end

# def make_change(amount, coins = [25, 10, 5, 1])
#     return [] if amount == 0

#     best_change = nil
#     coins.each do |coin|
#         # debugger
#         next if coin > amount

#         change_for_rest = make_change(amount - coin, coins)
#         change = [coin] + change_for_rest
#         # debugger
#         if best_change.nil? || change.count < best_change.count
#             best_change = change
#         end
#     end

#     best_change
# end
p make_better_change(76, [25, 10, 5, 1])
# p make_change(76, [25, 10, 5, 1])   #[25,25,25,1]
# p make_better_change(76, [25, 10, 5, 1])
# p make_better_change(76, [25, 10, 5, 1])

# arr = [1, [2], [3, [4]]]
# robot_parts = [
#   ["nuts", "bolts", "washers"],
#   ["capacitors", "resistors", "inductors"]
# ]
# robot_parts2 = [
#   ["nuts", ["bolts"], "washers"],
#   ["capacitors", "resistors", "inductors"]
# ]

# p arr.deep_dup
# p robot_parts.deep_dup
# p robot_parts2.deep_dup

# robot_parts_copy = robot_parts.dup

# # shouldn't modify robot_parts
# robot_parts_copy[1] << "LEDs"
# # but it does
# robot_parts[1] # => ["capacitors", "resistors", "inductors", "LEDs"]

