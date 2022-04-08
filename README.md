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

Add a draft blog post by running:

```
hugo new blog/first-post
```

This will make the necessary files and duplicate a header image. Find an [openly available one to replace it with on Unsplash](https://unsplash.com/) or similar, and include the attribution.

Edit the file, and once happy remove the `draft: true` - it should now show up for `npm run prod`.
