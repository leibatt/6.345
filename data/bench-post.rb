File.read("bench.txt").split("\n\n").last.split("\n").drop(1).each do |line|
	fields = line.split
	num_syllables = fields[0].to_i
	step = fields[1].to_i
	time = fields.last.to_f
	output_filename = "bench/bench-#{num_syllables}-#{step}.#{step == 8 ? "txt" : "fst"}"
	num_output_lines = File.readlines(output_filename).length
	puts "#{num_syllables},#{step},#{time},#{num_output_lines}"
end
