; scheme doesn't limit number size so we need a custom function to throw away bits
; or we will run out of memory. I've chosen to bound at the C++ ULLONG_MAX minimum standard
; (2^64 - 1)
(define ULLONG_MAX 18446744073709551615) ; (2^64 - 1)

(define (add-stream s1 s2)
    (stream-map + s1 s2)
)

(define (stream-scalar operator scalar stream)
    (define scalar-stream (cons-stream scalar scalar-stream) )
    (stream-map operator stream scalar-stream)
)
(define ones
    (cons-stream 1 ones))

(define positive-integers
    (cons-stream 1 (add-stream ones positive-integers)))

(define (print-stream s num)
    (display (stream-car s)) (newline)
    (cond
        ((> num 1) (print-stream (stream-cdr s) (- num 1)))
    )
)

(define (expt-mod base pow)
    ; mod any number by ULLONG_MAX
    (define (mod x)
        (modulo x ULLONG_MAX)
    )
    ; core of the expt-mod funciton, O(lg n)
    (define (recur base product pow)
        (cond
            ((<= pow 1) (mod (* base product)) )
            ((even? pow) (recur (mod (expt base 2)) product (/ pow 2)) )
            ((odd? pow) (recur base (mod (* base product)) (- pow 1)) )
        )
    )
    (recur base 1 pow)
)
; the x-stream is equivalent to the following:
; (define x 123456789)
; (set! x (mod (* 314527869 (+ x 1234567)))) 
(define x-stream
    (cons-stream 123456789
        (stream-scalar modulo ULLONG_MAX
            (stream-scalar * 314527869
                (stream-scalar + 1234567 x-stream )
            ) 
        )
    )
)


(define (jkiss)
    (define x 123456789)
    (define y 987654321)
    (define z 43219876)
    (define c 6543217)

    ;(set! x (* 314527869 (+ x 1234567)))

    (set! y (expt-mod y (arithmetic-shift y 5)))
    (set! y (expt-mod y (arithmetic-shift y -7)))
    (set! y (expt-mod y (arithmetic-shift y 22)))

    (define t (* 4294584393 (+ z c)))
    (set! c (arithmetic-shift t -32))
    (set! z t)
    (+ x y z)
)




;(define x (jkiss))
;(define y (jkiss))
;(display x) (newline)
;(display y) (newline)
(print-stream x 100)
