# Build Pelican websites in Github Actions

Pelican is a static site generator written in Python. This action instantiates a Docker container to install Pelican and build the website. This action does not handle publishing the site to Github Pages. This was done intentionally to allow other actions handling the deployment.

## Prerequisites
Ensure you have captured your dependencies in `requirements.txt`. If not you can run the below command:
```bash
pip freeze > requirements.txt
```

## Steps to use
First create a file named at the path `.github/.workflows/pelican.yml`
The conents of the file should be 
```yaml
name: Pelican site build and deploy

on:
  push:
    branches:
      - main
  workflow_dispatch:
  
permissions:
  contents: write
  pages: write
  id-token: write
  
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          submodules: recursive
      - id: pages
        uses: actions/configure-pages@v4
      - uses: trinora/pelican-build-action@main
        env:
          GITHUB_TOKEN: ${{secrets.GITHUB_TOKEN}}
      - uses: actions/upload-pages-artifact@v3
        with:
          path: output

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - id: deployment
        uses: actions/deploy-pages@v4
```

## Default configuration and overrides
This GitHub action will generate the static website using the following defaults
1. Configuration: Using `publishconf.py` as the default configuration file
2. Content: Uses `content` as the default content directory

You can override them by adding the following in the pelican.yml file under env variables
```yaml
PELICAN_CONFIG_FILE: config-file-name
PELICAN_CONTENT_FILE: content-folder-name
