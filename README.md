# Cloud Native Postgres

## Requirements

- [HUGO](https://gohugo.io/)
- [Node.js](https://nodejs.org/en/)

On macOS with brew type: `brew install hugo node`

## Building

Build locally (once you've installed Hugo & npm):

With drafts:
```
npm install && npm run dev
```

As the GH Action builds (excludes draft content):
```
npm install && npm run prod
```

This will compile the css file into `assets/css/output.css`. This file is ignored by git, so it is generated each build. If you make changes to `assets/css/main.css` you will need to restart the hugo server (e.g. stop it and run `npm run prod`) to pick up the changes. This is a temporary fix while Hugo & Tailwind JIT learn how to play nicely together.

### CSS

CSS is partly built by hugo & partly built outside of hugo by `npm run css`, which is called by `npm run dev|prod`. If you start to use a new Tailwind class restarting hugo is required (stop the server and `npm run dev`), if you edit `assets/style.css` it should compile in correctly without restart. This is to mitigate [this issue](https://github.com/gohugoio/hugo/issues/8343).

## Adding content

### Blogs

Before you write a blog, you should add yourself to the list of authors:

```
hugo new authors/$your_github_handle
```

and edit the resulting files (`authors/$your_github_handle/index.md` & `authors/$your_github_handle/temp-avatar.png` - you'll want to replace & rename the avatar image!) to fill in your name.

For example:

```
hugo new authors/drsm79
```

Add a draft blog post by running:

```
hugo new blog/first-post
```

This will make the necessary files and duplicate a header image. Find an [openly available one to replace it with on Unsplash](https://unsplash.com/) or similar, and include the attribution.

Edit the file, and once happy remove the `draft: true` - it should now show up for `npm run prod`.

### Documentation

Documentation lives [next to the code](https://github.com/cloudnative-pg/cloudnative-pg), and is imported into this repo manually (via the `hach/import_docs.sh` hack script).
Once the mkdocs files are placed in `assets/documentation/$version_number` run:

```
hugo new docs/$version_number.md
```

to link them into the site. For example, if you were publishing the 1.16.0 release, you would run:

```
hugo new docs/1.16.md
```

to make the docs available.
