require 'pnglitch'

PNGlitch.open('source_png/NWA.png') do |p|
  # p.glitch do |data|
  #   data.gsub /\d/, '2'
  # end
  p.glitch_after_compress do |data|
    # puts data
    data[rand(data.size) / 2] = 'cX'
    data
  end
  p.save 'glitch_png/compression_filter.png'
end
