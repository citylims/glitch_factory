require 'pnglitch'

PNGlitch.open('source_png/nwa.png') do |p|
  p.each_scanline do |scanline|
    scanline.gsub! /\d/, 'x'
    scanline.change_filter 4
  end
  p.glitch do |data|
    data.gsub /\d/, '2'
  end
  p.save 'broken_png/scanline_filter.png'
  puts p.filter_types
end
