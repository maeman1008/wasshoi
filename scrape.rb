
require 'open-uri'
require 'nokogiri'

def scrape(url)
  charset = nil
  html = open(url) do |f|
    charset = f.charset
    f.read
  end

  doc = Nokogiri::HTML.parse(html, nil, charset)

  puts "============================URL:#{url}"
  doc.css('p').each do |sample|
    str = sample.to_s
    lines = str.split(/<br>/)
    if !lines.nil?
      lines.each do |line|
        matches = line.match(/https?:\/\/.*flickr[\S]+/)
        if !matches.nil?
          match = matches[0]
          puts match.sub(/]/, "")
        end
      end
    end
  end
end

ARGV.each_with_index do |arg, i|
  url = arg
  scrape(url)
end
