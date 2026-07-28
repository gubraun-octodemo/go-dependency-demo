# GHAS dependency scanning demo

This intentionally vulnerable Go application demonstrates GitHub Advanced
Security dependency scanning with a small, understandable codebase.

> [!CAUTION]
> This project deliberately pins a vulnerable dependency. Do not deploy it to
> an untrusted or production environment.

## Vulnerability

The application directly uses `golang.org/x/net/http2` through an h2c HTTP/2
handler and pins `golang.org/x/net` at `v0.7.0`.

- Advisory: [GHSA-4374-p667-p6c8](https://github.com/advisories/GHSA-4374-p667-p6c8)
- Severity: High
- Issue: HTTP/2 rapid reset can cause excessive server work
- Patched version: `v0.17.0`

## Run

With Go 1.20 or newer:

```sh
go run .
curl http://localhost:8080/
curl -i http://localhost:8080/health
```

Or with Docker:

```sh
docker build -t dependency-demo .
docker run --rm -p 8080:8080 dependency-demo
```

## Demonstrate dependency scanning

1. Push this project to a GitHub repository.
2. Enable **Settings > Security > Advanced Security > Dependency graph**.
3. Enable **Dependabot alerts**.
4. Open **Security > Dependabot** and inspect the alert for
   `golang.org/x/net`.
5. Merge or reproduce the Dependabot update to remediate the alert.

To fix the vulnerability manually:

```sh
go get golang.org/x/net@v0.17.0
go mod tidy
```
