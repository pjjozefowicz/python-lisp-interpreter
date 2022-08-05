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