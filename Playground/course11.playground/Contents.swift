let score = 70
let attend = 0.7

switch(score, attend){
        case(_, ..<0.6):
             print("出席率過低")
        case(60..., _):
             print("PASS")
        case(40..., 0.8...):
             print("補考")
        default:
             print("重修")
    }

let lover = ("Ben", 175)
switch (lover) {
     case (let Name, 180...) where Name.first != "B":
     print("Marry to \(Name)")
     default:
     print("Solo")
     break;
     }
