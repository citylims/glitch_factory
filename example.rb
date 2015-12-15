require 'pnglitch'

PNGlitch.open('source_png/NWA.png') do |p|
  p.glitch do |data|
    data.gsub /\d/, 'x'
  end
  p.save 'broken_png/NWA.png'
end
