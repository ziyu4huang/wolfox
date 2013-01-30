
puts ">>> call 'ls -al'"
system("ls -al ")
puts ">>>> call 'ls -al', rediret result to file"
system("ls -al ", [:out, :err]=>['test.log', 'w'])
puts ">>> call cat"

f = open('test.txt', 'r')

#puts "file's fileno #{f.fileno}"

puts "begin of grep"
f = IO.popen('grep xxx', 'w')
f.puts "xxxx"
f.puts "xxxx"
f.puts "yyy"
f.puts "yyy"
f.puts "111"
f.close_write
#puts f.read
#require 'popen3'
puts "end of grep"

puts "begin of grep, redrect result to grep_resut.log"
IO.popen('grep xxx', 'w', [:out, :err]=>['xxxx.log', 'w', 0644]) do |f|
	f.puts "xxxx"
	f.puts "xxxx"
	f.puts "yyy"
	f.puts "yyy"
	f.puts "111"
	f.close_write
end
puts "end of grep"

IO.popen(["ls", "/", :err=>[:child, :out]]) {|ls_io|
  ls_result_with_error = ls_io.read
  puts "xxxxxxxxxxxxxxxxx"
  puts ls_result_with_error
}


puts "XXXXXXXXXXXXXXXXXX"
require 'open3'
Open3.popen2e('grep xxx') do | i, oe, t|
	i.puts "xxxx"
	i.puts "xxxx"
	i.puts "1234"
	i.puts "yyy"
	i.puts "xxxxxx"
	i.close_write

	oe.each do |line| 
		puts "get from grep :" + line
	end

	exit_code = t.value
end


