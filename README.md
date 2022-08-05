# python-lisp-interpreter
Lisp interpreter written in Python 3

This program is based on Peter Norvig's [article](http://norvig.com/lispy.html) and Michael Nielsen's [essay](https://michaelnielsen.org/ddi/lisp-as-the-maxwells-equations-of-software/)

### How to use it

To run interpreter in repl mode run ```python3 mylisp.py ```

To load mylisp files before entering repl mode run ```python3 mylisp.py <filename>.lsp```

### Brief description

#### Parsing

Function ```parse``` takes string representation of a program as input, calls ```tokenize``` to get a list of tokens, and then call ```read_from``` to create list representation of expression. You can run the interpreter in repl mode. There is also ```load``` function that loads program from file, executes it, and starts the repl.

#### Environments

An environment is a mapping from variable names to their values. By default, ```eval``` will use a global environment that includes the names for a bunch of standard functions. This environment can be augmented with user-defined variables, using the expression ```(define symbol value)```. 

#### Evaluation

```eval``` function evaluates an expression in an environment. It enumerates the different types of expressions it might be evaluating, and reads from or modifies the environment, as appropriate. ```lambda``` expressions evaluate to the appropriate anonymous Python function, with a new environment modified by the addition of the appropriate variable keys, and their values.

### What makes it Turing Complete?

Language is Turing Complete when it can implement Turing Complete system. [Rule110](https://en.wikipedia.org/wiki/Rule_110) has been proven to be Turing Complete so I decided to implement it in mylisp language.

Here's the code of Rule110 in mylisp:

```lisp
(define rule110 (lambda (cells)
  (next-gen (wrap-cells cells))))

(define next-gen (lambda (cells)
  (if (< (length cells) 3)
    (q ())
    (cons (match-rule (get-first-three cells)) (next-gen (cdr cells))))))

(define get-first-three (lambda (cells)
  (cons (car cells) (cons (car (cdr cells)) (cons (car (cdr (cdr cells))) (q ()))))))

(define wrap-cells (lambda (cells)
  (cons (last cells) (append cells (car cells)))))

(define match-rule (lambda (current)
  (cond ((eq? current (q (1 1 1))) 0 )
    ((eq? current (q (1 1 0))) 1 )
    ((eq? current (q (1 0 1))) 1 )
    ((eq? current (q (1 0 0))) 0 )
    ((eq? current (q (0 1 1))) 1 )
    ((eq? current (q (0 1 0))) 1 )
    ((eq? current (q (0 0 1))) 1 )
    ((eq? current (q (0 0 0))) 0 ))))

```

Run ```python3 mylisp.py rule110.lsp``` to load defined procedures.

```bash
mylisp> (rule110 (q (1 0 1 1 0 0 1 1 0 0)))
(1 1 1 1 0 1 1 1 0 1)
```

This program consists of:
* basic list operations ```(car exp) (cdr exp) (cons exp1 exp2)```
* quotations ```(q exp)```
* definitions ```(define symbol exp)```
* procedures ```(lambda (symbol...) exp)```
* conditionals ```(cond (p1 e1) ... (pn en))``` and ```(if test conseq alt)```
* comparison operators ```(eq? exp1 exp2)``` and ```(< exp1 exp2)```
* operations that help with working with lists ```(last exp)``` and ```(append exp exp2)```

This set of operations makes my language Turing Complete. I think that a more experienced Lisp programmer could create this program without using ```last``` and ```append``` (create the same functionality using more basic operations like ```cons car cdr```) and therefore reduce the set of operations but I will leave it as it is for now.
