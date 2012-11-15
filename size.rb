def readfilesize(file)
	if File.exists?(file) & !Dir.exists?(file) then
		puts "#Size:#{File.size file}:File: \t #{file}"
		File.size file
	elsif File.exists?(file) & Dir.exists?(file) then
		puts "#Size:#{File.size file}:Dir: \t #{file}"
		File.size file
	else
		0
	end
end

def readdirsize(dir)
	dp = Dir.open dir
	totalsize = 0
	dp.each do |d|
		if (d == ".") | (d == "..") | (d == ".git") then next else
			if File.exists?( dir + "/" + d ) & !Dir.exists?( dir + "/" + d ) then totalsize += readfilesize( dir + "/" + d )
			elsif Dir.exists?( dir + "/" + d ) then totalsize += (readdirsize( dir + "/" + d ).to_i + readfilesize( dir + "/" + d ) )
			end
		end
	end
	return totalsize
end

totalsize = readdirsize(ARGV[0]).to_i
puts "#Size:#{totalsize}:Dir: \t #{ARGV[0]}/"
