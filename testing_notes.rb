def upcase(str)
    return str.upcase if str.length <= 1
    str[0].upcase + upcase(str[1..-1]) 
end

#"hello" => "H" + "EllO"


def iterative_upcase(str)
    str.chars.inject("") do |upcase_str, char|
        upcased_str << char.upcase
    end
end

def reverse_str(str)
    return str.reversed_str if str.length <= 1
    str[-1] + reverse(str[0..-2])
end

#"Hello" => "olleH"
#"Hell" => "o" + "lleH"
#"ello" => "olle" + "H"

def quick_sort(arr)
    return arr if arr.length <= 1
    pivot_arr = [arr.first]
    left_side = arr[1..-1].select {|ele| if ele < arr.first}
    right_side = arr[1..-1].select {|ele| if ele >= arr.length}
    quick_sort(left_side) + pivot_arr + quick_sort(right_side)
end

class Array
    # for convenience
    def quicksort
        #base case
        return self if self.length < 2 #checking if the array is [] or [num]

        #inductive step
        pivot = self.first #taking the first ele of the array

        less = self[1..-1].select{|num| num < pivot}
        greater = self[1..-1].select{|num| num >= pivot}

        less = less.quicksort
        greater = greater.quicksort

        less.quicksort + [pivot] + greater.quicksort
    end
end

class Array
    #iterative solution
    #writing .each method in your own way
    #.each iterrates elements and reutrns original array
    def my_each(&prc) #accepting a block
        self.length.times { |i| prc.call(self[i]) }
        self #always returns original array
    end
    #recursion
    def my_each_rec(&prc)
        return self if self.empty?  # not self.length <= 1
                                    
        #additional logic
        prc.call(self.first) #accept a block and call it on each element  of the array
        #array.each {|ele| do something}
                            # ^ this block with each element
        #...
        self[1..-1].my_each_rec(&prc)
        #prc is with a & since it needs a block
        self
    end
end