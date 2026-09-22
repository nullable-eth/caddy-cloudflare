# caddy-cloudflare

The official `caddy` image rebuilt with the
[`caddy-dns/cloudflare`](https://github.com/caddy-dns/cloudflare) module, so
Caddy can solve ACME **DNS-01** challenges against a Cloudflare-hosted zone.
DNS-01 is the only challenge that can issue a wildcard certificate.

```
ghcr.io/nullable-eth/caddy-cloudflare:<caddy version>   e.g. :2.11.4
ghcr.io/nullable-eth/caddy-cloudflare:sha-<commit>      pin by this
```

## Use

```caddyfile
{
	acme_dns cloudflare {env.CF_API_TOKEN}
}

*.example.com {
	...
}
```

The token needs **Zone → DNS → Edit** on the one zone, nothing else.

## Versions

`CADDY_VERSION` and `CLOUDFLARE_DNS_VERSION` are pinned in the Dockerfile; the
build fails if the module is not in the resulting binary. A weekly scheduled
build picks up base-image fixes for the same versions.
