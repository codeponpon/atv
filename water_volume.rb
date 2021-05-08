# Example:
# height = [0,1,0,2,1,0,1,3,2,1,2,1]
# so = Solution.new
# so.water_volumn(height)

class InvalidException < StandardError; end

class Solution
  attr_reader :volumn, :height_arr, :height_left, :height_right

  def initialize(height_arr = [])
    @height_arr = height_arr
    @volumn = 0
    @height_left = []
    @height_right = []
  end

  def water_volumn(height_arr)
    @height_arr = height_arr
    n = height_arr.length
    raise InvalidException if n.negative? || n > 3*10**4

    for i in 0..n-1
      raise InvalidException if height_arr[i].negative? || height_arr[i] > 10**5
      height_left[0] = height_arr[0] if height_left[0].nil?
      height_left[i] = [height_left[i - 1], height_arr[i]].max
      # puts "height_left[#{i}] = [#{height_left[i - 1]}, #{height_arr[i]}].max : #{height_left[i]}"
    end

    for i in (n - 2).downto(0)
      raise InvalidException if height_arr[i].negative? || height_arr[i] > 10**5
      height_right[n - 1] = height_arr[n - 1] if height_right[n - 1].nil?
      height_right[i] = [height_right[i + 1], height_arr[i]].max
      # puts "height_right[#{i}] = [#{height_right[i + 1]}, #{height_arr[i]}].max : #{height_right[i]}"
    end

    volumn_summary
  end

  private
  def volumn_summary
    for i in (0..height_arr.length - 1)
      @volumn += [height_left[i], height_right[i]].min - height_arr[i]
      puts "volumn = [#{height_left[i]}, #{height_right[i]}].min - #{height_arr[i]} : #{[height_left[i], height_right[i]].min} - #{height_arr[i]} : #{@volumn}"
    end

    return @volumn;
  end
end
