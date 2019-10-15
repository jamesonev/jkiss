; scheme doesn't limit number size so we need a custom function to throw away bits
; or we will run out of memory. I've chosen to bound at the C ULLONG_MAX standard
; (2^64 - 1)
(define ULLONG_MAX 18446744073709551615) ; (2^64 - 1)


(define (expt-mod base pow)
    ; mod any number by ULLONG_MAX
    (define (mod x) 
        (modulo x ULLONG_MAX)
    )
    ; find the largest power of 2 n such that 2^n < pow and the base 
    (define (find-largest-power current pow)
        (cond
            ((>= (expt base current) ULLONG_MAX) current)
            ((<= (* current 2) pow) (find-largest-power (* current 2) pow))
            (else current)
        )
    )
    (define (helper base product pow )
        (define current (find-largest-power 1 pow))
        (cond
            ; must be tail recursive or we will reach the recursive call limit for large values of pow
            ((> pow 1) (helper base (mod (expt base current)) (- pow current) ))
            ; check that we actually raised base to a power
            ((and (= pow 1) (= product 1)) (mod base))
            ; since we know we raised the base to a power,
            ((= pow 1) (modulo product ULLONG_MAX))
            ;((= pow 0) 1)
            (else #f)   ;negatives not implemented
            )
        )
    (helper base 1 pow)
    ;(find-largest-power 1 pow)
    ;(expt x 524288)
)

(define (jkiss)
    (define x 123456789)
    (define y 987654321)
    (define z 43219876)
    (define c 6543217)

    (set! x (* 314527869 (+ x 1234567)))

    (set! y (expt-mod y 100 ULLONG_MAX))
    ;(set! y (expt-mod y (arithmetic-shift y -7) ULLONG_MAX))
    ;(set! y (expt-mod y (arithmetic-shift y 22) ULLONG_MAX))

    ;(define t (* 4294584393ULL (+ z c)))
    ;(set! c (arithmetic-shift t -32))
    ;(set! z t)
    (+ x y z)
)
(define (powmod x pow mod)
    (define (helper x product pow)
        (cond
            ((> pow 1) (helper x (modulo (* x product) mod) (- pow 1)))
            (else product)
        )
    )
    (helper x 1 mod)
)
(begin
    ;(display (expt 987654322 8200))
    (expt-mod 10433013 133)
    ;(powmod 4321 12 10000)
    ;(jkiss)
    ;(define y 1002400300003294855)
    ;(define pow (arithmetic-shift y 5))
    ;(display pow)
    ;(expt 2 100000)
)
