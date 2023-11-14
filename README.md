# secrets-nix
This repository has private age-encrypted files used by Nix agenix.

## Create or edit an existing secret for use in Nix
```sh
EDITOR=vim nix run github:ryantm/agenix -- -e root-password.age
```

## Age encrypt a file to multiple Yubikeys
For future usecases, but not really needed anymore.
```sh
age-plugin-yubikey --identity > identities
```
```sh
identities=$(cat identities | grep Recipient | sed -e "s/ //g" | cut -d':' -f2 | sed -e 's/^age\(.*\)/ -r age\1/g'  | tr -d '\n')
```
```sh
age $identities -o file.age file
```

## Decrypt agenix SSH key with Yubikey
If you need the keys associated with these age files, decrypt them with our Yubikey.
```sh
age-plugin-yubikey --identity > identity 2>/dev/null
```
```sh
cat id_ed25519_user.age | age -d -i identity
```
