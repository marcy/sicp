(define (minus-one x)
  (- x 1))

(define (plus-one x)
  (+ x 1))

(define (compose f g)
  (lambda (x)
    (f (g x))))

((compose plus-one minus-one) 1)

