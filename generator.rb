#!/usr/bin/env ruby

require 'fileutils'

def template name
  $data ||= DATA.read
  $data[/(?<=@@ #{name}\n)([^@]+)/m]
end

ARGV.each do |name|
  id = Dir['*'].count + 1
  folder = "#{id}-#{name}"
  puts "> creating folder #{folder}"
  FileUtils::mkdir_p folder
  puts "> creating #{folder}/#{name}.rb"
  File.open("#{folder}/#{name}.rb", 'w', 0755) { |file| file.write(template('ruby-program')) }
  puts "> creating #{folder}/#{name}.cpp"
  File.open("#{folder}/#{name}.cpp", 'w') { |file| file.write(template('cpp-program')) }
end

__END__

@@ ruby-program
#!/usr/bin/env ruby

gets.to_i.times do |i|
  # = gets.split.map &:to_i
  puts "Case ##{i+1}: "
end

@@ cpp-program
#include <iostream>
#include <fstream>

using namespace std;

int main(int argc, char const *argv[])
{
  if (argc >= 1) {
    ifstream  file;
    int       cases;

    file.open(argv[1]);
    file >> cases;
    for (int c = 0; c < cases; c++) {
      cout << "Case #" << c+1 << ":" << endl;
    }
    file.close();
    return 0;
  }
  return 1;
}