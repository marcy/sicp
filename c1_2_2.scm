;;; フィボナッチ数
;; 木構造再帰
(define (fib-tree n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib-tree (- n 1))
                 (fib-tree (- n 2))))))

(fib-tree 5)

;; 反復的再帰
(define (fib-rep n)
  (define (fib-iter a b counter)
    (cond ((= counter 0) b)
          (else (fib-iter (+ a b)
                          a
                          (- counter 1)))))
  (fib-iter 1 0 n))

(fib-rep 10)
(fib-iter 1 0 5)

;;; 両替
(define  (count-charge amount)
  (define (cc amount kind-of-coins)
    (define (first-denomination kind-of-coins)
      (cond ((= kind-of-coins 1) 1)
            ((= kind-of-coins 2) 5)
            ((= kind-of-coins 3) 10)
            ((= kind-of-coins 4) 50)))
    (cond ((= amount 0) 1)
          ((or (< amount 0) (= kind-of-coins 0)) 0)
          (else (+ (cc amount (- kind-of-coins 1))
                   (cc (- amount (first-denomination kind-of-coins))
                       kind-of-coins)
                   ))))
  (cc amount 4))

(count-charge 100)
