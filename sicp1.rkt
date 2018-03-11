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

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))


(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 9)
(sqrt 16)
(sqrt 36)

;; Exercise 1.6

;; New-If won't work because it is a procedure rather than a special form. In the case of the special form if, it evaluates either one of two expressions based on whether
;; the predicate is true or false

;; In the case of New-If if we assume that the interpreter under the hood is using applicative-order evaluation then the operands of new if are themselves evaluated.
;; One of the operands to new-if in this case is the function calling itself with a new guess. This will go on indefinitely and the cond in new-if never gets to be
;; evaluated.

;; Exercise 1.7
;; The good-enough? test doesn't work so well for very small numbers, and very larger numbers
;; In the case for small numbers, numbers like numbers way smaller than our tolerance say, we see from the special case of newton's method Xn+1 = 0.5 * (Xn + a/Xn) that as
;; a gets small our new guesses also get very small. This means that the difference between successive guesses is smaller. Thus, since we are
;; not controlling our previous guesses we subtract the square of our guess from x, and return too early because we are within reach of our tolerance limit.

;; For larger numbers the computer is unable to save the succesive new guesses precisely due to memory limitations. This means that our error
;; in precison when recursed multitudinous times becomes larger. This will end up making our guesses never fitting the criteria for
;; good-enough? and we will not get an answer as our procedure will recurse indefinitely.

(define (new-sqrt-iter guess last-guess x)
  (if (new-good-enough? guess last-guess)
      guess
      (new-sqrt-iter (improve guess x) guess x)))

(define (new-good-enough? guess last-guess)
  (< (abs (- guess last-guess)) (* 0.001 guess)))


(define (new-sqrt x)
  (new-sqrt-iter 1.0 2.0 x))


(new-sqrt .000009)
(new-sqrt 90000000000000000000000)

;; This test indeed works better for smaller and larger numbers.

;; Exercise 1.8

;; Implement Newton's method for cube roots given the fact that  if y is an approximation
;; to the cube root of x, then a better approximation is given by the value
;; (x/y^2 + 2y) / 3


(define (cube-root-iter guess last-guess x)
  (if (cube-good-enough? guess last-guess)
      guess
      (cube-root-iter (better-guess guess x) guess x)))

;; monitor the guess so that it still works efficiently for large and small numbers
(define (cube-good-enough? guess last-guess)
  (< (abs (- guess last-guess)) (* guess 0.001)))

;; better-guess is defined by the formula given above
(define (better-guess y x)
  (/
   (+ (/ x
          (square y))
       (* 2 y))
    3))

(define (cube-rt x)
  (cube-root-iter 1.0 2.0 x))

(cube-rt 8)
(cube-rt 27)
(cube-rt 125)
(cube-rt 9810)



