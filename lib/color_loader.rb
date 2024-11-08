# frozen_string_literal: true

require 'yaml'

# class ColorLoader for loading color from YAML
class ColorLoader
  # CONTENT_PATH = 'colors.yml'

  def initialize
    @color = load_color
  end

  def color_info
    @color
  end

  def load_color
    YAML.load_file(File.join(__dir__, 'colors.yml'))
  end
end
