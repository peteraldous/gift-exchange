#lang racket

(require racket/set)

(define names '(Joseph Mary Elizabeth Zacharias Gabriel Simeon Anna))

(define (married? giver receiver)
  (let ([couples (set (cons 'Joseph 'Mary)
                      (cons 'Elizabeth 'Zacharias))])
    (or (set-member? couples (cons giver receiver))
        (set-member? couples (cons receiver giver)))))

; a pair is valid if the giver and receiver are not the same and
; if the giver and receiver are not married to each other
(define (valid? lst)
  (not (ormap (λ (giver receiver)
                (or (eq? giver receiver)
                    (married? giver receiver)))
              names
              lst)))

(define (get-valid-list)
  (let ([lst (shuffle names)])
    (if (valid? lst)
        lst
        (get-valid-list))))

(for ([giver names]
      [receiver (get-valid-list)])
  (printf "~s gives to ~s~n" giver receiver))