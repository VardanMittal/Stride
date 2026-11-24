# Stride

Stride is a single-user, offline-first personal progress tracker for Android and Windows. This repository is at Milestone 0: it contains a Material 3 launch screen and validates that Supabase configuration was provided through Dart defines.

## Current status

The Flutter SDK is deliberately not installed in the local workspace. GitHub Actions is the sole build and test environment. The CI workflow installs the pinned Flutter SDK (3.50.0), creates the Android/Windows runners, then formats, analyzes, tests, and builds an APK.

Before the first release, explicitly confirm the permanent Android package ID: `dev.vardanmittal.stride`. It must never change after users install a release.

## Required GitHub configuration

Create these repository variables:

| Name | Value |
| --- | --- |
| `SUPABASE_URL` | `https://pthvxpfkpgoyaobvjnkl.supabase.co` |
| `SUPABASE_PROJECT_REF` | `pthvxpfkpgoyaobvjnkl` |

Create these repository secrets (Settings → Secrets and variables → Actions):

| Secret | Where it comes from |
| --- | --- |
| `SUPABASE_ANON_KEY` | Supabase Dashboard → Project Settings → API → publishable/anon key |
| `ANDROID_KEYSTORE_BASE64` | The one-time keystore bootstrap artifact |
| `ANDROID_KEYSTORE_PASSWORD` | The one-time credentials artifact |
| `ANDROID_KEY_ALIAS` | The one-time credentials artifact |
| `ANDROID_KEY_PASSWORD` | The one-time credentials artifact |

For later database migrations, create a GitHub Environment named `production`, make yourself the required reviewer, and add `SUPABASE_ACCESS_TOKEN` and `SUPABASE_DB_PASSWORD` as environment secrets. These are not used by Milestone 0.

## Supabase dashboard setup

1. Open the [Supabase dashboard](https://supabase.com/dashboard/project/pthvxpfkpgoyaobvjnkl).
2. In Authentication → Providers, enable Email. Create your account using email/password.
3. After that account exists, disable public sign-ups in Authentication → Providers/Settings. Do not put a `service_role` key in this app or GitHub Actions.
4. Copy only the publishable/anon key to `SUPABASE_ANON_KEY`.

## One-time Android signing setup

1. Confirm the GitHub repository is private, then run **Bootstrap Android keystore** from the Actions tab.
2. Download `stride-keystore-one-time-download` before its one-day expiry.
3. Open `stride-signing-credentials.txt` locally and copy each value into the matching repository secret. Do not commit, paste into chat, or retain the text file unprotected.
4. Back up `stride-release.jks` and the credentials in a password manager, then delete the GitHub artifact.
5. Delete `.github/workflows/bootstrap-keystore.yml` after successful setup.

If this keystore is lost, Android will not accept an update to an installed Stride app; it will have to be uninstalled and installed again.

## CI and release process

Open a pull request for each milestone. The `CI` workflow produces a `stride-preview-apk` artifact for 14 days. Do not treat a local build as verification.

After CI is green on the release commit, push a tag such as `v0.0.1`. `Release` rebuilds the Android APK and Windows zip, creates checksums, then creates the GitHub Release. The signed-release wiring is intentionally incomplete until generated Android runner files are committed after the first successful CI bootstrap; do not publish or install a release APK yet.

## Manual check after a green preview run

1. Download `stride-preview-apk` from the successful Actions run.
2. On Android, allow installation from the browser/files app when prompted, install `app-debug.apk`, and open it.
3. Confirm the screen reads **Stride** and **Supabase configuration loaded.**
4. On a launch intentionally missing either Dart define, confirm the app shows the configuration error screen rather than crashing.
5. Desktop installation is deferred until the release workflow’s Windows bundle has been validated in CI.

## Known Milestone 0 limits

There is no local database, auth UI, sync, notifications, timer, or widget yet. Those are introduced in later milestones. No analytics, advertising, or paid features will be added.
