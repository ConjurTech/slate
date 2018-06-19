# Unique header generation
require 'middleman-core/renderers/redcarpet'

$head_count = {}

class UniqueHeadCounter < Middleman::Renderers::MiddlemanRedcarpetHTML
  def initialize
    super
  end
  def header(text, header_level)
    friendly_text = text.parameterize

    $head_count[friendly_text] ||= 0
    $head_count[friendly_text] += 1
    if $head_count[friendly_text] > 1
      friendly_text += "-#{$head_count[friendly_text]}"
    end
    return "<h#{header_level} id='#{friendly_text}'>#{text}</h#{header_level}>"
  end
end
