require 'pnglitch'

PNGlitch.open('source_png/NWA.png') do |p|
  p.glitch do |data|
    data.gsub /\d/, 'x'
  end
  p.save 'glitch_png/example.png'
end
