# convert a string to a base64 (=k8s secrets)
echo 'qiyune0tttvj3uk1q0gcb7di' | base64

# generate a 24 rnd string
< /dev/urandom tr -dc a-z0-9 | head -c${1:-24};echo;