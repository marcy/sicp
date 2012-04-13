;; for report

(load "./scmint.scm")

(print "---------- cond ----------")
(print (= 8 (_eval '(cond ((> 1 2) 3)
                          ((> 2 1) 8)
                          (else 1)) toplevel-environment)))
(print (= 3 (_eval '(cond ((< 1 3) 3)
                          (else 1)) toplevel-environment)))
(print (= 1 (_eval '(cond ((> 1 3) 3)
                          (else 1)) toplevel-environment)))


(newline)
(print "---------- define ----------")
(_eval '(def x "hoge") toplevel-environment)
(print "hoge = " (_eval 'x toplevel-environment))

(newline)
(print "---------- lambda ----------")
(_eval '(def f (fn (x) (+ x 1))) toplevel-environment)
(print (= 2 (_eval '(f 1) toplevel-environment)))


(newline)
(print "---------- delay & force ----------")
(_eval '(def f (delay (+ y 1))) toplevel-environment)
(_eval '(def y 1) toplevel-environment)
(print (= 2 (_eval '(force (delay (+ y 1))) toplevel-environment)))
