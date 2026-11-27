# pass-extension.org

[![][build]][project] [![][online]][domain]

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

[pass]: https://www.passwordstore.org/
[Hugo]: https://gohugo.io/
[Slate]: https://github.com/pages-themes/slate
