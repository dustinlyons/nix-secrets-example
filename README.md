# secrets-nix-example
This is an example of my `nix-secrets` repository, used in [`nixos-config`](https://github.com/dustinlyons/nixos-config/). It uses [`agenix`](https://github.com/ryantm/agenix) to manage encrypting and decrypting your sensitive data.

To get started, you need a set of SSH keys that will persist between installations. 

You'll want to keep them secure and available in the event you're forced to reinstall the OS.

# How I manage keys
I first created an EdDSA public/private key pair to use for `agenix`, and then I `age` encrypted them to a set of three Yubikeys I use in my daily life. In this way, they're backed up and the key to read them is stored away in something secure I'm already using.

If I wanted, I could also probably [store the encrypted keys as paper](https://www.jabberwocky.com/software/paperkey/). But I prefer the Yubikey approach.

Here are the steps I took to create secrets from Yubikeys.

## Yubikeys
### Encrypt keys to multiple Yubikeys
I used this to encrypt my "bootstrap" keys to a set of Yubikeys. From my `nixos-config` working directory:

Bring in `age` and `yubikey` related tools. This is currently defined [here](https://github.com/dustinlyons/nixos-config/blob/main/flake.nix#L44).
```sh
nix develop
```

Export `yubikey` identities.
```sh
age-plugin-yubikey --identity > identities
```

This cryptic shit makes the identities suitable for use in the next step. ChatGPT wrote it.
```sh
identities=$(cat identities | grep Recipient | sed -e "s/ //g" | cut -d':' -f2 | sed -e 's/^age\(.*\)/ -r age\1/g'  | tr -d '\n')
```

Encrypt the key to an `age` file.
```sh
age $identities -o id_ed25519_agenix.age id_ed25519_agenix
```

### Decrypt using Yubikey
I used this to read keys for the initial bootstrap. I delete the decrypted keys after use.
```sh
age-plugin-yubikey --identity > identity 2>/dev/null
```
```sh
cat id_ed25519_agenix.age | age -d -i identity
```
