# pass-extension.org

[![][workflow]][action] [![][online]][domain]

Website for the [pass] extensions, served at <https://pass-extension.org>.

Built with [Hugo] and the [Slate] GitHub Pages theme. No content is copied here; it all comes from the extension repositories.

## Build

To work locally with this project, you'll have to follow the steps below:

1. Clone this project: `git clone https://github.com/pass-extension/pass-extension.org.git`
1. Install Hugo, Pandoc, and Just
1. Preview your project: `just serve`
1. Add content
1. Generate the website: `just build`

Deployment: GitHub Actions builds and deploys to GitHub Pages on every push, and
weekly to pick up upstream changes.

## Add an extension

1. Add its repository URL to `repos` in the `Justfile`
1. Add a `[[params.extensions]]` entry to `hugo.toml`
1. Add `static/logo/<name>.svg`

[domain]: https://pass-extension.org
[workflow]: https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fpass-extension%2Fpass-extension.org%2Fbadge%3Fref%3Dmain&style=flat-square
[action]: https://actions-badge.atrox.dev/pass-extension/pass-extension.org/goto?ref=main
[online]: https://img.shields.io/website/https/pass-extension.org.svg?style=flat-square

[pass]: https://www.passwordstore.org/
[Hugo]: https://gohugo.io/
[Slate]: https://github.com/pages-themes/slate
