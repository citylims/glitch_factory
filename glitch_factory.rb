require 'pnglitch'

count = 0
infiles = %w(source_png/NWA.png)
infiles.each do |file|
  puts file
  [false, true].each do |compress|
    infile = file
    [:optimized, :sub, :up, :average, :paeth].each do |filter|
      [:replace, :transpose, :defect].each do |method|
        count += 1
        png = PNGlitch.open infile
        # set filter options
        png.change_all_filters filter unless filter == :optimized
        options = [filter.to_s]
        options << method.to_s
        options << 'compress' if compress
        puts options
        outfile = "NWA-#{count}-#{options}.png"
        # call method
        process = lambda do |data, range|
          case method
          when :replace
            range.times do
              data[rand(data.size)] = 'x'
            end
            data
          when :transpose
            x = data.size / 4
            data[0, x] + data[x * 2, x] + data[x * 1, x] + data[x * 3..-1]
          when :defect
            (range / 5).times do
              data[rand(data.size)] = ''
            end
            data
          end
        end
        unless compress
          png.glitch do |data|
            process.call data, 50
          end
        else
          png.glitch_after_compress do |data|
            process.call data, 10
          end
        end
        png.save outfile
        png.close
      end
    end
  end
end
File.unlink 'tmp.png'
