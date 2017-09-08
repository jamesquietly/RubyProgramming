#iteration method
def fibs(number)
    result = []
    #for zero
    if number == 0 then return result end
    #for two or one
    if number <= 2 then return number == 2 ? [0, 1] : [0] end
    #three or more
    if number > 2
        result.push(0)
        result.push(1)
        (number - 2).times do 
            result.push(result[-2] + result[-1])
        end
    end
    return result
end

#recursion method
def fibs_rec(number)
    #asking for zero
    if number == 0 then return [] end
    #asking for two or one
    if number <= 2 then return number == 2 ? [0,1] : [0] end
    #else three or more
    a = fibs_rec(number - 1)
    return a << a[-2] + a[-1]
end