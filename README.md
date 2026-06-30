# container-cicd

A CI/CD toolbox image for use in Bitbucket Pipelines, bundling the common tools needed for infrastructure and deployment workflows.

## What it does

The `Containerfile` assembles a Debian-based image by copying pre-built tool binaries from upstream OCI images. This avoids installing tools from package managers at runtime and keeps the layer structure explicit and auditable.

Tools included:

| Tool | Source |
|------|--------|
| AWS CLI | `docker.io/amazon/aws-cli:latest` |
| jq | `ghcr.io/jqlang/jq` |
| kubectl | `registry.k8s.io/kubectl` |
| Python + uv tooling | `ghcr.io/thredd-platform/oci-python:latest` |
| Node.js | `ghcr.io/thredd-platform/oci-node:latest` |
| tfswitch | `ghcr.io/thredd-platform/oci-tfswitch:latest` |
| Terramate | `ghcr.io/thredd-platform/oci-terramate:latest` |

The image is built for `linux/amd64` and `linux/arm64` via GitHub Actions and published to the GitHub Container Registry at:

```
ghcr.io/thredd-platform/container-cicd:latest
```

## Usage

Reference the image in your `bitbucket-pipelines.yml`:

```yaml
image: ghcr.io/thredd-platform/container-cicd:latest

pipelines:
  default:
    - step:
        script:
          - aws --version
          - kubectl version --client
          - terraform version
```

## Version updates

[Renovate](https://docs.renovatebot.com/) is configured to automatically open pull requests when new versions of pinned tools (jq, kubectl) are published, keeping the `Containerfile` up to date.
