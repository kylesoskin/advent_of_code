p File.read('input.txt').lines.map{|x|q,r=x.split;((q={?A=>?X,?B=>?Y,?C=>?Z}[q])==r ? 3:({?X=>?Z,?Y=>?X,?Z=>?Y}[r]==q ? 6:0))+(r.ord-87)}.sum
# Result: 17189

