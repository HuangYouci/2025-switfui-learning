let iLoveHim: Bool = true
let heLoveMe: Bool = true

if (iLoveHim && heLoveMe){
    print("We love each other")
} else if (iLoveHim && !heLoveMe){
    print("He don't love me")
} else if (!iLoveHim && heLoveMe){
    print("I don't love him")
} else {
    print("We don't love each other")
}
