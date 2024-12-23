# INPUT = 'sample_input.txt'
INPUT = 'input.txt'


@dir1 = {}
@dir2 = {}
@all = []
File.read(INPUT).lines.each do |l| 
  o,t = l.chomp.split(?-)
  @all << o
  @all << t
  @dir1[o] ||= []
  @dir1[o] << t
  @dir2[t] ||= []
  @dir2[t] << o
end

def connected(o,t)
  (@dir1[o]||[]).include?(t) || (@dir2[t]||[]).include?(o) || (@dir1[t]||[]).include?(o) || (@dir2[o]||[]).include?(t) 
end

def are_all_connected(computers)
  computers.all?{|computer|
    other_computers = computers - [computer]
    other_computers.all?{|c| connected(computer,c)}
  }
end

@all = @all.uniq
results = @all.combination(3).select {|computers| are_all_connected(computers)}.sort
pp results.select {|d| d.any?{|e| e[0] == "t"}}.count