;; 線形再帰
(define (fact n)
    (cond ((< n 1) 1)
          (else
           (* n (fact (- n 1))))))

;; 末尾再帰
(define (ifact n)
  (define (fact-iter product counter)
    (cond ((> counter n) product)
          (else (fact-iter (* counter product)
                      (+ counter 1)))))
  (fact-iter 1 1))

;; 木構造再帰
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

