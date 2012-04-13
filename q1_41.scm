(define (plus-one x)
  (+ x 1))

(define (square x)
  (* x x))

(define (double f)
  (lambda (x)
    (f (f x))
    ))

(define (triple f)
  (lambda (x)
    (f (f (f x)))
    ))

((double square) 2)
((double plus-one) 2)
((triple plus-one) 2)
