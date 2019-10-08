(define (jkiss)
    (define x 123456789)
    (define y 987654321)
    (define z 43219876)
    (define c 6543217)

    (set! x (* 314527869 (+ x 1234567)))
    ;(set! y (expt y (arithmetic-shift y 5)))
    ;(set! y (expt y (arithmetic-shift y -7)))
    ;(set! y (expt y (arithmetic-shift y 22)))

    ;(define t (* 4294584393ULL (+ z c)))
    ;(set! c (arithmetic-shift t -32))
    ;(set! z t)
    (+ x y z)
)
(begin
    (jkiss)
)
