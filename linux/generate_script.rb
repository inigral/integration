puts "Username:"
username = gets.chomp

puts "Password:"
password = gets.chomp

File.open("send_csv.sh", "w+") do |file|
  if username.strip.empty?
    puts "Need a username"
    break
  end
  if password.strip.empty?
    puts "Need a password"
    break
  end
  
  lines = File.open("sendcsv_template.sh").readlines
  credentials = []
  credentials << "USERNAME='#{username}'"
  credentials << "PASSWORD='#{password}'"
  file.puts(credentials + lines)
end
