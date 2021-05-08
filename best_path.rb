# Example:
# grid = [[0,6,0],[5,8,7],[0,9,0]]
# grid = [[1,0,7],[2,0,6],[3,4,5],[0,3,0],[9,0,20]]
# solution = Solution.new
# solution.get_maximum_diamond grid

class InvalidException < StandardError; end

class Solution
  def deep_link(ans, next_item = {}, index = 0)
    @collector[index] = [] if @collector[index].nil?
    return @collector[index] if @collector.length == ans.length || next_item.nil?

    items = ans.reject{|h| @collector[index].include?(h[:current]) }.sort_by{|h| h[:current]}
    if next_item.empty?
      items.each_with_index do |item, i|
        @collector[i] = [] if @collector[i].nil?
        @collector[i] << item[:current]
        next_item = ans.filter{|h| h[:current].eql?(item[:val])}.first
        deep_link(ans, next_item, i)
      end
    else
      @collector[index] << next_item[:current]
      next_item = items.filter{|h| h[:current].eql?(next_item[:val])}.first
      deep_link(ans, next_item, index)
    end
  end

  def get_maximum_diamond(grid)
    return InvalidException if grid.size.zero?
    return InvalidException if grid.size > 15

    ans = []
    grid2d = [[]]
    c = grid.size
    for i in (0..c-1)
      r = grid[i].size
      return InvalidException if r > 15

      for j in (0..r-1)
        grid2d[i] = [] if grid2d[i].nil?
        grid2d[i][j] = 0
      end
    end

    for col in (0..c-1)
      for row in (0..r-1)
        raise InvalidException if grid[row][col].to_i.negative? || grid[row][col].to_i > 100
        next if grid[row][col].to_i.zero?

        if col == 0
          left = 0
        else
          left = {val: grid[row][col - 1], col: col - 1, position: 'left', row: row, current: grid[row][col]}
        end

        if col == c-1
          right = 0
        else
          right = {val: grid[row][col + 1] || 0, col: col + 1, position: 'right', row: row, current: grid[row][col]}
        end

        if row == 0
          down = 0
        else
          down = {val: grid[row - 1][col], col: col, position: 'down', row: row - 1, current: grid[row][col]}
        end

        if row == (r-1)
          up = 0
        else
          up = {val: grid[row + 1][col], col: col, position: 'up', row: row + 1, current: grid[row][col]}
        end

        ans << [left, right, up, down].delete_if{|m|m.is_a?(Integer)}.max_by{|m|m[:val]}
        ans.uniq!{|h| h[:current]}
      end
    end

    @collector = [[]]
    deep_link(ans)
    max = @collector.map(&:sum).max
    ans.sort_by{|h| h[:current]}.each{|h| puts "#{h}"}
    "#{@collector.filter{|arr| arr.sum.eql?(max)}.first.join(' -> ')} = #{max}"
  end
end
