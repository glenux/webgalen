# Webgalen

A tool to dissect of websites (tribute to [Galen of Pergamon](https://en.wikipedia.org/wiki/Galen))

It is able to :
-  crawl websites to create a sitemap, 
- uses the sitemap to create full page screenshots

## Roadmap

- device profiles selection for screenshots (:warning: work in progress/unstable)
- compare screenshots to produce a diff (i already have a fully fonctional side-project for that, waiting to be integrated and automated in webgalen)
- annotate screenshots (define a bounding-box => add comment + red/green figures like the ones on trello => produce screenshot slices)
- push annotation + slices on a project management tool (ex: trello, redmine, etc.)
- use annotation bounding-box + diff to detect which comments are involved in a diff (modifié)

## Prerequisites

Install a few tools

    apt-get install img2pdf imagemagick

Increase memory in imagemagick policy `/etc/ImageMagick-6/policy.xml`

    <policy domain="resource" name="memory" value="2GiB"/>

## Usage

    $ be exe/webgalen
    Commands:
      webgalen help [COMMAND]    # Describe available commands or one specific command
      webgalen list-devices      # list available profiles
      webgalen screenshot FILE   # take screenshots for each page
      webgalen sitemap URL FILE  # crawl site and export sitemap

    Options:
      -ua, [--user-agent=USER-AGENT]  # choose user agent (default Mozilla)


## Contributing

1. Fork it ( http://github.com/glenux/webgalen/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Credits

Author & Maintainer: Glenn Y. ROLLAND

Contributors: none yet ;)

Got questions? Need help? Tweet at @glenux


## License

Webgalen is Copyright © 2018 Glenn ROLLAND. It is free software, and may be redistributed under the terms specified in the LICENSE file.

