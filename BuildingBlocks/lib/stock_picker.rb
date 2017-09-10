def stock_picker(array)
    max_profit = -1
    max_days = []
    array[0..-2].each_index do |i|
        array[(i+1)..-1].each_index do |j|
            #need to buy before you can sell
            if i < j
                #sell day - buy day
                current_profit = array[j] - array[i]
                if current_profit > max_profit
                    max_profit = current_profit
                    max_days.clear
                    max_days.push(i)
                    max_days.push(j)
                end
            end
        end
    end
    max_days
end

puts stock_picker([17,3,6,9,15,8,6,1,10])