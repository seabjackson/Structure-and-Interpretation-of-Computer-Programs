#lang sicp

;; 1.3 Define a procedure that takes three numbers as arguments
;; and returns the sum of the squares of the larger two numbers


(define (square x) (* x x))
(define (sum-squares x y)
  (+ (square x) (square y)))

(define (sum-squares-larger-two x y z)
  (cond ((and (<= x y) (<= x z)) (sum-squares y z))
        ((and (<= y x) (<= y z)) (sum-squares x z))
        (else (sum-squares x y))))

(sum-squares-larger-two 1 2 3)

