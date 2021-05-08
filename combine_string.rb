# Example:
# num1 = "2345"
# num2 = "567"
# solution = Solution.new
# solution.add_string(num1, num2)

class InvalidException < StandardError; end

class Solution
  def add_string(num1, num2)
    return InvalidException if num1.to_i.negative? || num2.to_i.negative?
    return InvalidException if num1.to_i > 5100 || num2.to_i > 5100

    ans = []
    carry_num = 0

    arr1 = num1.split('').map(&:to_i)
    arr2 = num2.split('').map(&:to_i)

    arr = arr1.size > arr2.size ? arr1 : arr2
    arr.each_with_index do |digit, index|
      val = arr1.reverse[index].to_i + arr2.reverse[index].to_i if arr1.reverse[index].to_i + arr2.reverse[index].to_i
      val = val.to_s.split('')
      if val.size > 1
        num = if carry_num > 0
          carry_num + val.pop.to_i
        else
          val.pop.to_i
        end

        ans << num
        carry_num = val.pop.to_i
      else
        num = (val.pop.to_i + carry_num).to_s.split('')
        num = if num.size > 1
          ans << num.pop.to_i
          carry_num = num.pop.to_i
        else
          ans << num.pop.to_i
          carry_num = 0
        end
      end
    end

    return ans.reverse.join.to_i
  end

  def add_string_ez(num1, num2)
    return InvalidException if num1.to_i.negative? || num2.to_i.negative?
    return InvalidException if num1.to_i > 5100 || num2.to_i > 5100

    return num1.to_i + num2.to_i
  end
end
