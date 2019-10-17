; scheme doesn't limit number size so we need a custom function to throw away bits
; or we will run out of memory. I've chosen to bound at the C++ ULLONG_MAX minimum standard
; (2^64 - 1)
(define ULLONG_MAX 18446744073709551615) ; (2^64 - 1)


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

(define (jkiss)
    (define x 123456789)
    (define y 987654321)
    (define z 43219876)
    (define c 6543217)

    (set! x (* 314527869 (+ x 1234567)))

    (set! y (expt-mod y 5))
    (set! y (expt-mod y (arithmetic-shift y -7)))
    (set! y (expt-mod y (arithmetic-shift y 22)))

    (define t (* 4294584393 (+ z c)))
    (set! c (arithmetic-shift t -32))
    (set! z t)
    (+ x y z)
)

(begin
    (jkiss)
)
