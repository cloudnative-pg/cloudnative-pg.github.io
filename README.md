# CloudNativePG Website

Welcome to the **CloudNativePG Website** Project! Are you interested in helping
improve the CloudNativePG website? We’d love your support!

Join the conversation and collaborate with us in the
[#cloudnativepg-www Slack channel](https://cloud-native.slack.com/archives/C08LV0CMNMD).

## Requirements

- [HUGO](https://gohugo.io/)
- [Node.js](https://nodejs.org/en/)

On macOS with brew type: `brew install hugo node`

## Branches

The most important branches are:

- `main`: trunk
- `production`: the one visible in Github Pages

So, if you want to see the changes on cloudnative-pg.io you need to merge them
in the `production` branch.

## Building

Build locally (once you've installed Hugo & npm):

With drafts:

``` sh
npm install && npm run dev
```

As the GH Action builds (excludes draft content):

``` sh
npm install && npm run prod
```

This will compile the css file into `assets/css/output.css`. This file is ignored by git, so it is generated each build. If you make changes to `assets/css/main.css` you will need to restart the hugo server (e.g. stop it and run `npm run prod`) to pick up the changes. This is a temporary fix while Hugo & Tailwind JIT learn how to play nicely together.

### Using Docker

If you'd rather not install Hugo and Node.js locally, you can serve the
site with the official
[`gohugoio/hugo`](https://github.com/gohugoio/hugo/pkgs/container/hugo) image
(it ships the extended build, Node.js and npm):

``` sh
docker run --rm \
  --name cnpg-www \
  -p 8080:8080 \
  --user "$(id -u):$(id -g)" \
  -e HOME=/tmp \
  -v "$(pwd)":/project \
  --entrypoint sh \
  ghcr.io/gohugoio/hugo:v0.169.0 \
  -c "npm install && npm run dev -- --bind 0.0.0.0 -p 8080 -F"
```

The site will then be available at <http://localhost:8080>.

Notes:

- `node_modules/` is in `.gitignore`, so `npm install` writes into your
  working tree and is reused across container runs. If you also run
  `npm install` on the host, delete `node_modules/` before switching
  between host and container (or vice versa) so the Linux-built native
  binaries don't clash with the host ones.
- The image runs as user 1000. `--user` gives you ownership of the files it
  writes. With rootless Podman, use `--userns=keep-id` instead of `--user` and
  `-e HOME`.
- To serve without drafts, replace `npm run dev` with `npm run prod`.
- The image tag pins the Hugo version. Renovate bumps it together with the
  Hugo version of the CI workflows.

### CSS

CSS is partly built by hugo & partly built outside of hugo by `npm run css`, which is called by `npm run dev|prod`. If you start to use a new Tailwind class restarting hugo is required (stop the server and `npm run dev`), if you edit `assets/style.css` it should compile in correctly without restart. This is to mitigate [this issue](https://github.com/gohugoio/hugo/issues/8343).

The Tailwind entry point is `assets/tailwind.css`. It is kept outside `assets/css`, so hugo only processes the generated `output.css` and the other files in that folder.

## Adding content

### Blogs

Before you write a blog, you should add yourself to the list of authors:

``` sh
hugo new authors/$your_github_handle
```

and edit the resulting files (`authors/$your_github_handle/index.md` & `authors/$your_github_handle/temp-avatar.png` - you'll want to replace & rename the avatar image!) to fill in your name.

For example:

``` sh
hugo new authors/drsm79
```

Add a draft blog post by running:

``` sh
hugo new blog/first-post
```

This will make the necessary files and duplicate a header image. Find an [openly available one to replace it with on Unsplash](https://unsplash.com/) or similar, and include the attribution.

Edit the file, and once happy remove the `draft: true` - it should now show up for `npm run prod`.

### Documentation

This repository does not build the documentation. The sources live in the
[operator repository](https://github.com/cloudnative-pg/cloudnative-pg), inside
`docs/src`. The [cloudnative-pg/docs](https://github.com/cloudnative-pg/docs)
repository imports them, builds a Docusaurus site and deploys it with GitHub
Pages, under this site's domain at
[cloudnative-pg.io/docs](https://cloudnative-pg.io/docs/).

A release needs no documentation change here. The operator repository starts
the import on every release tag (RCs included). It also imports `main` on every
change to `docs/src`, which feeds `/docs/devel`.

The `assets/documentation` folder holds the old documentation. Versions up to
1.24, 1.25.0-rc1 and 1.26-rc1 are static copies. The others are redirect stubs
to the new site. No new versions are added there.

## Publishing on the website

Changes that have been merged into `main` are not yet visible on the website. To
publish them, they need to be merged into the `production` branch.

Please publish to `production` by fast-forwarding it to `main`
(`git merge --ff-only main`), as the branch requires a linear history.
This needs to be done by an administrator.

If you try to push to `production` without the right permissions, GitHub
rejects the push with a "Repository rule violations" error.

Please **don't make a pull request**. Instead, get an administrator to make the
needed changes, or to make you an administrator. A pull request would create
unnecessary discrepancies between `main` and `production`.

Once a commit is merged to `production`, github will trigger the `hugo_build`
workflow that will update [cloudnative-pg.io](https://cloudnative-pg.io).
