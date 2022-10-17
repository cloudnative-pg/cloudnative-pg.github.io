# Cloud Native Postgres

## Requirements

- [HUGO](https://gohugo.io/)
- [Node.js](https://nodejs.org/en/)

On macOS with brew type: `brew install hugo node`

## Branches

The main branches are:

- `main`: trunk
- `production`: the one visible in Github pages

So, if you want to see the changes on cloudnative-pg.io you need to merge them
in the `production` branch.

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

Documentation lives [alongside the code](https://github.com/cloudnative-pg/cloudnative-pg),
inside the `docs/src` folder. It is written in Markdown using mkdocs.

The website contains a static copy of the HTML files generated from the
Markdown sources, inside the `assets/documentation/$version_number` folder
(where $version_number is a minor release of CloudNativePG).

The `hack/import_docs.sh` script has the logic to import the files from a
release branch, generate the HTML and save the files in the appropriate folder.

Below you find instructions on how to update the docs for a new minor release
or a patch release.

#### New minor release

Create a new file called `X.Y.md` inside the `content/docs` folder, with the following content:

```markdown
---
release:  X.Y.0
location: /documentation/X.Y
release_date: DD Mon Year
release_notes: https://github.com/cloudnative-pg/cloudnative-pg/releases/tag/vX.Y.0
---
```

Then run:

```console
hack/import_docs.sh X.Y
```

This will import all the files under `assets/documentation/X.Y`. Open the
`index.html` page with your browser and verify everything is OK, then add the
folder to the Git repo (in a development branch).

#### New patch release

Modify the `X.Y.md` file inside `content/docs` folder by updating the version
and the release date.

Then run:

```console
hack/import_docs.sh X.Y
```

Apply all changes in the development branch and push. If you are adding a new
patch release to the latest minor version, you will need to update the
`current` branch (which at the moment is a copy of the folder).

