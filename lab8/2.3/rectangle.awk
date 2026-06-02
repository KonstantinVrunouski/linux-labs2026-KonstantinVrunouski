#!/usr/bin/awk -f
# Variant 1, task 2: rectangle area and perimeter

function area(w, h) {
    return w * h
}

function perimeter(w, h) {
    return 2 * (w + h)
}

function main(w, h) {
    printf "Width: %g, Height: %g\n", w, h
    printf "Area: %g\n", area(w, h)
    printf "Perimeter: %g\n", perimeter(w, h)
}

BEGIN {
    main(12, 5)
}