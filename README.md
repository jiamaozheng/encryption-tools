# Encrypting/Decrypting Data Procedures

## Tool and password files 
* Tool file: _encryption_tool.sh_
* Password file: _pass_

## Change password file permission
* ```chmod 400 pass```
* save it in a safe place (e.g. ```~/.ssh/```)

## Encrypt/Decrypt a single file
* Encryption usage: ```bash encryption_tool.sh test1/README.md ~/.ssh/pass encrypt```
* Decryption usage: ```bash encryption_tool.sh test1/README.md.enc ~/.ssh/pass decrypt```

## Encrypt/Decrypt a folder 
* Encryption usage: ```bash encryption_tool.sh test1 ~/.ssh/pass encrypt```
* Decryption usage: ```bash encryption_tool.sh test1 ~/.ssh/pass decrypt```
