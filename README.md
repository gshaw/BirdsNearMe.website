# Birds Near Me website

[https://birdsnearme.com](https://birdsnearme.com)

## Develop

```sh
mise install       # Ruby, Node, cspell, markdownlint, html-proofer
mise run install   # bundle install
mise run dev       # http://localhost:4002 with livereload
mise run check     # build, spell check, markdown lint, internal links
```

Pushing to `main` publishes the site on Cloudflare Pages. `mise run verify` checks the live site afterwards.

## Powered By

- Domain Registrar: [Cloudflare Registrar](https://www.cloudflare.com/products/registrar/)
- DNS: [Cloudflare DNS](https://www.cloudflare.com/dns/)
- Hosting: [Cloudflare Pages](https://pages.cloudflare.com)
- Build System: [Jekyll](https://jekyllrb.com)
- CSS: [Pico.css](https://picocss.com)
