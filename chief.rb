#!/usr/bin/ruby
require 'find'
require 'stringio'

def finder(file)
  title = nil
  IO.foreach(file) do |line|
    m = line.match(/^title: ([\s\S]*)/)
    if !!m
      title = m[1]
      break
    end
  end

  return if title.nil?

  title.include?('"') ? title.chop.gsub!( /"/, '') : title.chop
end

posts = []
Find.find('content/post') do |filename|
  next unless File.file?(filename)
  next unless filename.include?('.md')
  next if filename.include?('README')

  title = finder(filename)
  next if title.nil?

  posts << { title: title, filename: filename.gsub!(/content\/post\//, '') }
end

readme = <<HEREDOC
# zhaolion's dropbox

个人随手整理的一些文章

## 文章列表

HEREDOC

io = StringIO.new
io.write(readme)
posts.each do |p|
  io.write("- [#{p[:title]}](#{p[:filename]})\n")
end

begin
  file = File.open('content/post/README.md', 'w')
  file.write(io.string)
ensure
  file.close unless file.nil?
end
