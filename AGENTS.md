# Agent Notes

<!-- cspell:ignore birdsnearme -- the domain and Cloudflare Pages project name -->

Background for AI agents working in this repo.

## What this is

The marketing site for Birds Near Me, a worldwide birding field guide for iPhone built on
eBird data, live at [birdsnearme.com](https://birdsnearme.com). A Jekyll site on Cloudflare
Pages. The app itself lives in a separate repo, `BirdsNearMe`.

**The repo and the site are both public.** Anything committed here is published.

Keep it minimal. Don't add gems, plugins, pages or build steps unless asked.

## Commands

```sh
mise run install   # bundle install
mise run dev       # serve on :4002 with livereload
mise run check     # build + spell + markdownlint + internal links
mise run verify    # curl the live site after a deploy
mise run deploy    # check, then git push
```

**Read the counts, not just the exit code.** html-proofer prints `Ran on N files` and cspell
prints `Files checked: N`. A green run over zero files checked nothing.

## Deploys

Cloudflare Pages project `birdsnearme-website` builds every push. `main` goes to
production; other branches get a preview URL. The build runs `bundle exec jekyll build`
with `RUBY_VERSION` set in the Cloudflare project, so a Ruby bump means changing `Gemfile`,
`.mise.toml` and that variable together.

GitHub Actions runs `mise run -c check` on pushes and PRs. It doesn't block Cloudflare.

## Layout

- `_config.yml` holds the site name, description, icon, copyright start year and author.
  The layout reads them; don't hard-code them in HTML.
- `_layouts/page.html` is the only layout. `_includes/head.html` has the meta and Open Graph
  tags; a page can override the description with `description:` and the preview image with
  `ogimage:` in front matter.
- `index.md`, `support.md`, `privacy.md`, `404.md`.
- `pico.min.css` is Pico 1.5, copied in rather than loaded from a CDN.

## Writing

- Claims must match the released app on the App Store, not the rewrite in the app repo.
  In September 2026 that was version 1.5 (March 2019), which needs iOS 10 or later. Update
  `index.md` and `support.md` when a new version ships.
- The app's data comes from eBird, Flickr, Wikipedia and xeno-canto. Keep the
  acknowledgements and the privacy policy in step with that list.

## Suppressions

Suppress a check inline, with a reason, in the file that provoked it:
`<!-- cspell:ignore word -->` or `<!-- markdownlint-disable-next-line MD0xx -->`. Move a
word to `cspell.config.yaml` only once a second file needs it.

## Branches, issues and PRs

- Branch names are flat and short: `<issue>-<slug>`, no `claude/` prefix.
- Issue and PR bodies aren't hard-wrapped.
- Squash-merge only.
