require 'pnglitch'
PNGlitch.open('source_png/NWA.png') do |p|
  p.each_scanline do |line|
    line.graft rand(5)
  end
  p.save "glitch_png/graft_filter.png"
end
