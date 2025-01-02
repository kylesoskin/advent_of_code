INPUT_FILE = "input.txt"
input = File.read(INPUT_FILE)
top, bottom = input.split(/^$/)

inital_vals = top.lines.map {|l| 
  f,s = l.chomp.split(": ")
  [f,s.to_i]
}.to_h

lines = bottom.lines
lines.shift
gates = lines.map{|l| 
    wires,result = l.chomp.split(" -> ")
    v1, op, v2 = wires.split(" ")
    {v1:,op:,v2:,result:}
}
done = false
until done
  gates.each do |g|
    v1 = inital_vals[g[:v1]]
    v2 = inital_vals[g[:v2]]
    next if v1.nil? || v2.nil?
    r = case g[:op]
      when "AND"
        v1 & v2
      when "OR"
        v1 | v2
      when "XOR"
        v1 ^ v2
      end
    inital_vals[g[:result]] = r 
  end
  curr_val = inital_vals.select {|k,v|
    k.start_with?("z")
  }.sort_by{|k,v| k}.reverse.map(&:last).join.to_i(2)
  pp curr_val
  gets
end

