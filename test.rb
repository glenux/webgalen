#!/usr/bin/env ruby

urls = %w[
  https://boutique.pressecotedivoire.fr/reading?id=SOIRINFO7163pZyPXQ#page=1
  https://boutique.pressecotedivoire.fr/reading?id=NOTREVOIE5947jneW2f#page=1
  https://boutique.pressecotedivoire.fr/reading?id=LGINFOS1979CHPFdD#page=1
  https://boutique.pressecotedivoire.fr/reading?id=LETEMPS4463XBeNW4#page=1
]

urls.each do |url|
  cmd = "bundle exec ./download.rb \"#{url}\""
  system cmd
  unless $?.success? 
    # try again
    system cmd
  end
end
