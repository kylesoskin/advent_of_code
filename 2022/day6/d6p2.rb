arr = File.read('input.txt').chars

def cycle_all(arr, n) 
  i = 0 
  while i <= arr.size
    t = arr[i .. i+n-1]
    return i+n if t.uniq.size == t.size
    i += 1
  end
end

# # Part 1
p cycle_all(arr, 4)
# # Part 2
p cycle_all(arr, 14)

