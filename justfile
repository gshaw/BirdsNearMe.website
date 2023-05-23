start:
  bundle exec jekyll serve --livereload --open-url --port 4002

install:
  bundle install

deploy:
  git push
