(define (average-damp f)
  (define (avarage a b)
    (/ (+ a b) 2))
  (lambda (x) (avarage x (f x))))

((average-damp (lambda (x) (* x x))) 10)
