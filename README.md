Having fun testing out Nim

#### Run tests
```
$ testament pattern "tests/*.nim
```

#### Usage
```
# compile
$ nim c src/jgrep.nim

# test
$ echo '{"foo": {"bar": 2}, "baz": 3}' | src/jgrep.out 2
{"foo":{"bar":2}}
```
