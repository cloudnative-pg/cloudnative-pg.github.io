---
build:
  list: never
  publishResources: false
  render: never
---

# End Users section order

Each Markdown entry in the `end_users` directory (except this README file)
should have a `weight` in the Hugo preamble, like so:

``` txt
---
title: Shinkansen
image: logo/shinkansen.png
homepage: https://shinkansen.finance/
weight: 11
---
```

The weight should be computed so that entries are displayed in the End Users
page in chronological order, the oldest entries at the top.

The entries in this directory are based in the CNPG [ADOPTERS.md](https://github.com/cloudnative-pg/cloudnative-pg/blob/e5ef2fdaccd2c8fbdbf319f1224a0f90bbcfed30/ADOPTERS.md)
file.
To ensure the weights of end-users don't need modification as more and more are
added, we should use as `weight` of an end user, its ordering in the
ADOPTERS file.

E.g. Shinkansen is in line 44, whereas EDB is in line 34. We subtract 33 so we
begin at 1. So, for EDB `weight: 1`, and for Shinkansen, `weight: 11`.
