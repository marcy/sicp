;;; pi / 8 に収束
(define (pi-sum a b)
  (cond ((> a b) 0)
        (else (+ (/ 1.0 (* a (+ a 2)))
                 (pi-sum (+ a 4) b)))))
(* (pi-sum 1 5000) 8)

;;; 抽象化ヴァージョン
(define (sum term next a b)
  (cond ((> a b) 0)
        (else (+ (term a)
                 (sum term next (next a) b)))))
