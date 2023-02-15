module TracksHelper
    include ERB::Util

  def ugly_lyrics(lyrics)
    lines = lyrics.split("\n")
    html_lines = lines.map { |line| "♫ " + h(line) }
    raw("<pre>" + html_lines.join("\n") + "</pre>")
  end
end
