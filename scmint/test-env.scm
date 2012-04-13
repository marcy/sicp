(load "./test.scm")

(load "./env.scm")

(test "make-frame" 
      '(make-frame '(x y z) '("x" "y" "z"))
      '((x . "x") (y . "y") (z . "z")))

(define frame-bottom (make-frame '(x y z) '("x" "y" "z")))
(define frame-top (make-frame '(t o p) '(1 2 3)))

(test "extend-environment"
      '(extend-environment '(x y z) '("x" "y" "z") ())
      (list frame-bottom))

(define env (extend-environment '(x y z) '("x" "y" "z") ()))

(test "extend-environment"
      '(extend-environment 
	'(t o p) 
	'(1 2 3) 
	'(((x . "x") (y . "y") (z . "z"))))
      (cons frame-top env))

(set! env (extend-environment '(t o p) '(1 2 3) env))

(test "lookup-var-val"
      '(lookup-var-val 'p env)
      3)

(test "lookup-var-val"
      '(lookup-var-val 'z env)
      "z")

(test "lookup-var-val"
      '(lookup-var-val 'unknown env)
      'error)

(test "lookup-var"
      '(lookup-var 'z (first-frame (rest-env env)))
      '(z . "z"))

(define b (lookup-var 'z (first-frame (rest-env env))))

(binding-set! (lookup-var 'z (first-frame (rest-env env))) "zz")

(print env)


(define expected-env
  '(
    ((new-var . new-val) 
     (t . 1) (o . 2) (p . 3))
    ((x . "x") (y . "y") (z . "z"))))

(test "define-env"
      '(define-env 'new-var 'new-val env)
      expected-env)


(define-env 'new-var 'new-val env)


      