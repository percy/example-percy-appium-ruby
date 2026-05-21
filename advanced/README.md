# Advanced Percy + Appium-Ruby

This directory exercises the full applicable Percy SDK feature surface for `percy-appium-app` (Ruby gem). See the basic example at the repo root for the minimum integration.

## What this example covers

An RSpec suite (`spec/advanced_spec.rb`) where each `it` exercises one row of the [App Percy / Appium Native matrix](../../../docs/advanced-example-feature-matrix.md): device_name override, orientation, fullscreen + status_bar/nav_bar heights, ignore regions via xpath / appium element / custom bbox, consider regions via xpath, sync mode, test_case + labels.

Web-only options marked `N/A` in `matrix.yml`.

## Run locally

```bash
cd advanced
make install
export AA_USERNAME="<browserstack username>"
export AA_ACCESS_KEY="<browserstack access key>"
export APP="bs://<your hashed app id>"
export PERCY_TOKEN="<your project token>"
make test
```

## CI note

The advanced CI job is `workflow_dispatch`-only — App Percy CI requires a real BrowserStack device session.

## Coverage matrix

States: `Covered` / `N/A — <reason>` / `Planned` / `Deprecated`. Source of truth is [`matrix.yml`](./matrix.yml).
