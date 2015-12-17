require 'pnglitch'

PNGlitch.open('../source_png/NWA.png') do |p|
  scanlines = Array.new
  p.glitch do |data|
    data.gsub /\e/, 'x'
  end
  p.glitch_after_compress do |data|
    data[rand(data.size)] = 'z'
    data
  end
  p.each_scanline do |s|
    s.gsub! /\d/, 'x'
    s.change_filter 2
    scanlines << s
  end
  puts scanlines.at(0)
  p.save '../glitch_png/compression_filter.png'
end
