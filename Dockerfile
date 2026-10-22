# Caddy with the Cloudflare DNS provider, so Caddy can solve ACME DNS-01
# challenges — the only challenge type that can issue a wildcard certificate.
#
# Both versions are pinned so a rebuild is reproducible; bump them together
# with the upstream releases (Renovate reads the ARG lines).
ARG CADDY_VERSION=2.11.4

FROM caddy:${CADDY_VERSION}-builder AS builder
# renovate: datasource=github-tags depName=caddy-dns/cloudflare
ARG CLOUDFLARE_DNS_VERSION=v0.2.4
RUN xcaddy build --with github.com/caddy-dns/cloudflare@${CLOUDFLARE_DNS_VERSION}

FROM caddy:${CADDY_VERSION}
# eMudhra CA compromise (20 Oct 26): eight eMudhra intermediate keys are
# derivable from their certificates. Take the distro's fixed ca-certificates
# even when the base image predates it.
RUN apk upgrade --no-cache ca-certificates
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
# Fail the build if the module did not make it in.
RUN caddy list-modules | grep -qx 'dns.providers.cloudflare'
