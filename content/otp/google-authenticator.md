---
title: Migrate from Google Authenticator
description: Move your Google Authenticator TOTP tokens to pass-otp.
logo: logo/otp.svg
repo: https://github.com/pass-extension/pass-otp
---

The script below transforms the Google Authenticator SQLite database of an
Android phone into `otpauth://` URIs that `pass otp` can import.

## Dump the database

The database is only readable on a rooted phone. Follow
[these hints](https://android.stackexchange.com/questions/63252/how-do-i-back-up-google-authenticator#86861)
to copy `/data/data/com.google.android.apps.authenticator2/databases/databases`
to your computer, for example as `google_authenticator_database.sqlite3`.

This file holds all your OTP secrets in clear: delete it once the migration is done.

## Convert it

```bash
#!/usr/bin/env bash
# Usage: ga2otp.bash google_authenticator_database.sqlite3
#
# The accounts table looks like:
#   CREATE TABLE accounts (_id INTEGER PRIMARY KEY, email TEXT NOT NULL,
#     secret TEXT NOT NULL, counter INTEGER DEFAULT 0, type INTEGER,
#     provider INTEGER DEFAULT 0, issuer TEXT DEFAULT NULL,
#     original_name TEXT DEFAULT NULL);
#
# Each row is converted to:
#   otpauth://totp/johndoe@example.com?secret=SECRET&issuer=Google
set -euo pipefail

sqlite3 -batch "$1" "SELECT printf('otpauth://totp/%s?secret=%s&issuer=%s', email, secret, issuer) FROM accounts;"
```

## Import into pass

`pass otp insert` reads a URI from stdin. Insert each token under a path of your choice:

```sh
echo "otpauth://totp/johndoe@example.com?secret=SECRET&issuer=Google" | pass otp insert otp/google
```
