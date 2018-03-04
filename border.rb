require "mini_magick"

def halt(message)
    print message, "\n"
    exit 1
end

halt '1 argument expected' if ARGV.size != 1

fin = ARGV[0]
fout = fin + ".border.jpg"

halt 'Unable to find source file' unless File.exists?(fin)


image  = MiniMagick::Image.new(fin)

border = 60

`magick convert -size #{image.width + border}x#{image.height + border} xc:white #{fout}`

result = MiniMagick::Image.new(fout)

  result = result.composite(image) do |c|
    c.compose "Over"
    c.geometry "+#{border/2}+#{border/2}"
  end


result.write(fout)