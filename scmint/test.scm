(define (test msg exp expected)
  (let ((result (test-eval exp)))
    (print (list msg exp))
    (if (equal? expected result)
        (begin
          (print 'Good)
          (print "ecpected: " expected)
          (print "result: " result))
	(begin
	  (print 'NG)
	  (print "expected: " expected)
	  (print "result: " result)))))

(define (test-eval prog)
  (with-error-handler
   (lambda (e)
     (print (list '_test-error e))
     'error)
   (lambda () 
     (eval prog (interaction-environment)))))

