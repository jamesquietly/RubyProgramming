def merge_sort(arr)
    if arr.length < 2
        return arr
    else
        mid = arr.length/2
        left = merge_sort(arr[0...mid])
        right = merge_sort(arr[mid..-1])
        merge(left, right)
    end
end

def merge(left, right)
    result = []
    until left.empty? || right.empty? do
        left[0] < right[0] ? result.push(left.shift()) : result.push(right.shift())    
    end
    #exits if one side is empty
    #so need to add remaining
    result + left + right
end

