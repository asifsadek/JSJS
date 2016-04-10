(* Operators in JSJS *)
type op =
  (* num operators *)
  | Add | Sub | Mul | Div | Mod | Neg
  (* string operators *)
  | Caret
  (* boolean operators *)
  | And | Or | Not
  (* relational operators *)
  | Lte | Gte | Neq | Equals | Lt | Gt
  (* list operators *)
  | Cons

(* Types in JSJS are either a primitive type
   or a function type. both of these types are
   defined in a mutually recursive fashion *)
type primitiveType =
  (* a generic type *)
  | T of char
  (* a general type. used to define
     empty lists or empty maps *)
  | TAny
  | TNum
  | TString
  | TBool
  | TUnit
  (* type of exception associated with a message *)
  | TExn of string
  (* a generic function if of type function
     plus a list of char literals e.g T, U *)
  | TFunGeneric of funcType * char list
  | TFun of funcType
  (* list type - a list of primitive types *)
  | TList of primitiveType
  (* map type - a tuple of key type, value type *)
  | TMap of primitiveType * primitiveType

(* a function type takes a list of primitive types
   and returns a primitive type *)
and funcType = primitiveType list * primitiveType

(* everything is an expression in JSJS *)
type expr =
  | UnitLit
  | NumLit of float
  | BoolLit of bool
  | StrLit of string
  (* binary operation *)
  | Binop of expr * op * expr
  (* unary operation *)
  | Unop of op * expr
  (* a list literal is a list of expressions *)
  | ListLit of expr list
  (* a map literal is a list of key-value pairs *)
  | MapLit of (expr * expr) list
  (* a block is a list of expression *)
  | Block of expr list
  (* an assignment expression takes a string,
     an annotated type and an expression *)
  | Assign of string * primitiveType * expr
  (* a value is just a string *)
  | Val of string
  (* if-then-else takes 3 expressions - predicate,
     then expr and else expr *)
  | If of expr * expr * expr
  (* a function call takes fn name and a list of arguments (exprs) *)
  | Call of string * expr list
  (* a fn literal is of func_decl record *)
  | FunLit of func_decl
  (* a module literal is a module name and expression *)
  | ModuleLit of string * expr
  (*  an exception type that is generated by throw expr *)
  | Exn of expr
  (* a try catch block has two exprs and an identifier that acts as
     a placeholder for the message *)
  | TryCatch of expr * string * expr

and

(* a record defining a function declaration
   that contains the following
   1. a list of formals i.e a tuple of (name, type of formal)
   2. return type of the function
   3. a boolean indicating whether the function is generic
   4. list of generic types (e.g. T, U, A, B) *)
func_decl = {
  formals       : (string * primitiveType) list;
  return_type   : primitiveType;
  body          : expr;
  is_generic    : bool;
  generic_types : char list;
};;

(* a JSJS program is a list of expressions *)
type program = expr list;;
