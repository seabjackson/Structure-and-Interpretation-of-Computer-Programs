#lang sicp


;; Exercise 1.1

10
(+ 5 3 4)
(- 9 1)
(/ 6 2)
(+ (* 2 4) (- 4 6))
(define a 3)
(define b (+ a 1))
(+ a b (* a b))
(= a b)
(if (and (> b a) (< b (* a b)))
    b
    a)
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
(+ 2 (if (> b a) b a))
(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))

(min 1 2 3)
132
312
321
213
231

;; Exercise 1.2

(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (-  2  7 )))

;; as above rewritten using pretty printing format
(/ (+ 5
      4
      (- 2 (- 3 (+ 6 (/ 4 5)))))
   (* 3
      (- 6 2)
      (- 2 7)))

;; Exercise 1.3
;;Define a procedure that takes three numbers as arguments and
;;returns the sum of the squares of the two larger numbers.

; define a function to square numbers
(define (square x)
  (* x x))

;; define a function to
(define (sum-square x y)
  (+ (square x) (square y)))

(define (sum-two-larger x y z)
  (cond ((= x (min x y z)) (sum-square y z))
        ((= y (min x y z)) (sum-square x z))
        ((= z (min x y z)) (sum-square x y))))

(sum-two-larger 3 4 2)

;; Exercise 1.4

;;Observe that our model of evaluation allows for combinations
;;whose operators are compound expressions. Use this observation
;;to describe the behavior of the following procedure:

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;; This expression ends up with (+ a b) or (- a b) where b < 0
;; Thus we are always adding be to a and it is equivalent to
;; a + |b|

;; Exercise 1.5  Ben Bitdiddle has invented a test to determine whether the interpreter
;; he is faced with is using applicative-order evaluation or normal-order evaluation.
;; He defines the following two procedures:

;;(define (p) (p))

;(define (test x y) 
;  (if (= x 0) 
;     0 
;      y))


;; In normal-order evaluation we fully expand and then reduce, where as in applicative-
;; order evaluation we evaluate the arguments and then apply. Since the first procedure is an
;; inherently recursive one as it's defined in terms of itself then if we were to use applicative
;; -order evaluation it would evaluate the arguments of the test procedure. That is, it evaluaties
;; 0 which equals 0, then it will attempt to evaluate (p). This will end up in an infinite loop
;; If we use normal-order evaluation it would only evaluate the operands at the time when
;; it is needed. Thus, it would check the body of the test function, and will produce 0
;; (p)  will never be evaluated.



