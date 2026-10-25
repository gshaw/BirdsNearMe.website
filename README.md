# Birds Near Me website

[https://birdsnearme.com](https://birdsnearme.com)

## Develop

```sh
mise install       # Hugo, Node, cspell, markdownlint, lychee
mise run dev       # http://localhost:4002 with live reload
mise run check     # build, spell check, markdown lint, internal links
```

Deploy with `mise run deploy`. It refuses unless you're on a clean `main` with nothing newer on GitHub, then checks, pushes, waits for Cloudflare Pages and runs `mise run verify`. `mise run deploy-status` says whether `main` is live. The rule is in [Workshop's deploy note](https://github.com/gshaw/Workshop/blob/main/Tooling/deploy.md).

## Powered By

- Domain Registrar: [Cloudflare Registrar](https://www.cloudflare.com/products/registrar/)
- DNS: [Cloudflare DNS](https://www.cloudflare.com/dns/)
- Hosting: [Cloudflare Pages](https://pages.cloudflare.com)
- Build System: [Hugo](https://gohugo.io)
- CSS: [Pico.css](https://picocss.com)
