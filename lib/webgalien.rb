
# Load external dependencies
require 'thor'
require 'celluloid/current'
require 'selenium-webdriver'
require 'yaml'
require 'thor'
require 'colorize'
require 'fileutils'

# Load actors
require 'webgalien/actors/crop_png_actor'
require 'webgalien/actors/screenshot_actor'
require 'webgalien/actors/work_actor'

require 'webgalien/screenshot'
require 'webgalien/sitemap'

# Load cli
require 'webgalien/cli'
