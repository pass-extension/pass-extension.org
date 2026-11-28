---
title: Migrate from pass-otp 0.1
description: Convert pass-otp 0.1 tokens to the otpauth:// Key Uri Format.
logo: logo/otp.svg
repo: https://github.com/pass-extension/pass-otp
---

`pass-otp` now stores OTP tokens in the standard
[Key Uri Format](https://github.com/google/google-authenticator/wiki/Key-Uri-Format).
Tokens saved by pass-otp 0.1 must be rewritten in this format.

## Edit each token

```sh
pass edit totp-secret
```

Old format:

```
otp_secret: AAAAAAAAAAAAAAAA
otp_type: totp
otp_algorithm: sha1
otp_period: 30
otp_digits: 6
```

New format:

```
otpauth://totp/totp-secret?secret=AAAAAAAAAAAAAAAA&issuer=totp-secret
```

## Default values

The following default values do not need to be specified in the URI:

| parameter | default |
| --------- | ------- |
| algorithm | sha1    |
| period    | 30      |
| digits    | 6       |
