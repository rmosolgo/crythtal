# Crythtal

A lisp in [Crystal](http://crystal-lang.org).

![image](https://cloud.githubusercontent.com/assets/2231765/10119967/9ff816be-645b-11e5-8311-b142f3536bce.png)


Cues taken from:
  - [Lispy tutorial](http://norvig.com/lispy.html), building a lisp in Python
  - [Crisp](https://github.com/rhysd/Crisp), another lisp in Crystal

## About

#### Try it

```
$ crystal src/lisp.cr -- run
Lisp REPL (cntl-d to quit):
>
```

#### Goals

- Learn Crystal ✓
- Implement a dynamic language ✓
- Do something with lisp for once ✓

#### Non-goals

- Implement a full-featured, useful lisp ✗

## Todo

- [x] Parse strings
- [x] Build expressions
- [x] Evaluate expressions in bindings
- [x] Lazy eval (`if`)
- [x] Modify current scope (`define`)
- [x] Lists (`quote`)
- [x] REPL
- [x] Custom functions (`lambda`)
- [ ] Implement all those cool lisp-y list functions
- [ ] Follow [Lispy2](http://norvig.com/lispy2.html)
