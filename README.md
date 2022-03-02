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

## Adding content

Add a draft blog post by running:

```
hugo new content/blog/first-post.md
```

Edit the file, and once happy remove the `draft: true` - it should now show up for `npm run prod`.
