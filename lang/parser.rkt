#lang brag
bf-program : (@main_|function|c_set_global| macro | NOPARSE)*

simple_list_comp: /"[" (INTEGER (/"," INTEGER)* | INTEGER [/"," INTEGER] /"." dot_placeholder INTEGER)  /"]"

macro: ("expandM" | "afterParse" | "afterParseSkip" | "expandMSkip" | "expandOnceSkip" | "coach")
/"(" ((@operator /";") | block | @main_ | function  )* /")"/";"

if_oper : /"if" /"(" @calc-p15 /")" (block | (@operator /";")) [/"else" (block | (@operator /";"))]
for_oper : for_oper_standart | for_oper_in_range
for_oper_standart : /"for" /"(" (@c_set | @c_let)/";"  @calc-p15 /";" @operator /")" (block | (@operator /";"))
for_oper_in_range : /"for" /"(" /"auto" NAME /":" @operator /")" (block | (@operator /";"))

main_ : /"void" /"main" /"(" /")" block
function : /"void" NAME /"(" NAME (/"," NAME)* /")" block
c_set_global : NAME /"=" @operator /";"

block : /"{" ( if_oper | @for_oper |  @operator  /";" | NOPARSE )* /"}"
operator : @calc-p15  | c_print | c_set | c_let | macro
operand : INTEGER | NAME | simple_list_comp | if_oper | @for_oper |  /"(" @calc-p15 /")"

calc-p0 :   @operand 
calc-p2 :   @unop2 | @calc-p0 
calc-p3 :   @unop3 | @calc-p2
calc-p5 :   binop5 | @calc-p3
calc-p6 :   binop6 | @calc-p5
calc-p9 :   binop9 | @calc-p6
calc-p10 :  binop10 | @calc-p9
calc-p14 :  binop14 | @calc-p10
calc-p15 :  binop15 | @calc-p14

c_let : /"int" NAME /"=" (@operator) 
c_set : NAME /"=" (@operator)

binop15 : @calc-p15 "||" @calc-p15
binop14 : @calc-p14 "&&"  @calc-p14
binop10 : @calc-p10 ("==" | "!=") @calc-p10
binop9 : @calc-p9 (">" | "<" | ">=" | "<=") @calc-p9
binop6 : @calc-p6 ("+" | "-") @calc-p6
binop5 : @calc-p5 ("%" | "*" | "/") @calc-p5
unop3 :  not 
unop2 :  apply | index_

not : (/"!" @calc-p3)

apply : (@calc-p2 /"(" @calc-p15 (/"," @calc-p15)* /")" )
index_ : (@calc-p2 /"[" @calc-p15 /"]" )


c_print : (/"<"/"<" @calc-p15 | /"print" @calc-p15)
dot_placeholder : /"."