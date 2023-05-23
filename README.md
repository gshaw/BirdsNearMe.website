# Birds Near Me website

[Live Site](https://birdsnearme.com)

### Build Instructions

```
brew install asdf
asdf list
asdf plugin add ruby
asdf plugin-update ruby
asdf list all ruby
asdf install ruby latest
asdf global ruby 3.2.2 # change specfic version to latest stable
gem install bundler
bundle add webrick # https://github.com/jekyll/jekyll/issues/8523

brew install just
just -l
just install
just start
```

Pushing to GitHub will publish the site.
