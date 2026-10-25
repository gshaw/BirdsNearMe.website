# Agent Notes

<!-- cspell:ignore birdsnearme -- the domain and Cloudflare Pages project name -->

Background for AI agents working in this repo.

## What this is

The marketing site for Birds Near Me, a worldwide birding field guide for iPhone built on
eBird data, live at [birdsnearme.com](https://birdsnearme.com). A Hugo site on Cloudflare
Pages. The app itself lives in a separate repo, `BirdsNearMe`.

**The repo and the site are both public.** Anything committed here is published.

Keep it minimal. Don't add a theme, Hugo modules, pages or build steps unless asked. Every
template is in `layouts/`.

## Commands

```sh
mise run dev       # hugo server on :4002 with live reload
mise run check     # build + spell + markdownlint + internal links
mise run deploy    # guard, check, push, wait for Pages, verify
mise run verify    # curl the live site
mise run deploy-status  # is main live?
```

**Read the counts, not just the exit code.** lychee prints `N OK` and cspell
prints `Files checked: N`. A green run over zero files checked nothing.

## Deploys

Cloudflare Pages project `birdsnearme-website` builds every push. `main` goes to
production; other branches get a preview URL. The build runs
`hugo --cleanDestinationDir --panicOnWarning` into `public/`, with `HUGO_VERSION` set in the
Cloudflare project for production and preview, so a Hugo bump means changing `.mise.toml`
and that variable together. `--panicOnWarning` makes a deprecation fail the build rather
than scroll past.

**Deploy with `mise run deploy`**, never a bare `git push` to `main`.
`scripts/deploy-guard.sh` refuses unless the branch is `main`, the tree is clean and
`origin/main` isn't ahead. Then it runs `check`, pushes, waits for the "Cloudflare Pages"
check run on the commit (`scripts/pages-status.sh --wait`) and runs `verify`. A merged PR
also deploys, since Pages builds every push to `main`. The rule and the list of sites are
in [Workshop's deploy note](https://github.com/gshaw/Workshop/blob/main/Tooling/deploy.md).

GitHub Actions runs `mise run -c check` on pushes and PRs. It doesn't block Cloudflare.

## Layout

- `hugo.toml` holds the site name, description, icon, copyright start year and author.
  The layout reads them; don't hard-code them in HTML.
- `layouts/baseof.html` is the page shell. `layouts/_partials/head.html` has the meta and
  Open Graph tags; a page can override the description with `description:` and the preview
  image with `ogimage:` in front matter.
- `content/`: `_index.md` (the home page), `support.md`, `privacy.md`, `404.md`.
  `uglyURLs` keeps pages at `/privacy.html`, as before; Cloudflare serves them at
  `/privacy`, the canonical URL.
- `static/` is published as it is: icons, the QR code, screenshots, and `pico.min.css`,
  Pico 1.5 copied in rather than loaded from a CDN.
- `public/` is build output; it's gitignored.

Hugo doesn't run template code inside Markdown files: a loop over data goes in a
shortcode in `layouts/_shortcodes/`. A link with spaces needs angle brackets:
`[text](<mailto:x?subject=A B>)`, and a blank line inside a raw HTML block ends it.

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
