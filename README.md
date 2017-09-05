# Im-Lab Encrypting/Decrypting Data Procedures(BETA)

## Tool and password files 
* Tool file: _Imlab_encryption_tool.sh_
* Password file: _pass_

## Change password file permission
* ```chmod 400 pass```
* save it in a safe place (e.g. ```~/.ssh/```)

## Encrypt/Decrypt a single file
* Encryption usage: ```sh imlab_encryption_openssl.sh test1/README.md ~/.ssh/pass encrypt```
* Decryption usage: ```sh imlab_encryption_openssl.sh test1/README.md.enc ~/.ssh/pass decrypt```

## Encrypt/Decrypt a folder 
* Encryption usage: ```sh imlab_encryption_openssl.sh test1 ~/.ssh/pass encrypt```
* Decryption usage: ```sh imlab_encryption_openssl.sh test1 ~/.ssh/pass decrypt```
