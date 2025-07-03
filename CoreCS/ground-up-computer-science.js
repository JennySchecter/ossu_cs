var show = console.log;
//++++++++Start定义pair数据结构，也可称为元组(tuple)，以及对应的一些函数功能++++++++
function pair(a,b){
    return select => select(a,b);
}
function first(p) {
    return p((a, b) => a);
}
function second(p) {
    return p((a, b) => b);
}
function isPair(x) {
    return typeof (x) == "function";
}
function pairToString(p) {
    if (!isPair(p)) {
        return String(p);
    } else {
        return "("
        + pairToString(first(p))
        + ", "
        + pairToString(second(p))
        + ")";
    }
}
//++++++++End定义pair数据结构，也可称为元组(tuple)，以及对应的一些函数功能++++++++

//++++++++Start由pair组成list的一些函数功能++++++++
var head = first;
var tail = second;
function length(p) {
    if (p == null) {
        return 0;
    } else {
        return 1 + length(tail(p))
    }
}
function append(ls1,ls2){
    if (ls1 == null) {
        return ls2;
    } else {
        return pair(head(ls1),append(tail(ls1),ls2));
    }
}
function nth(ls,n){
    if (ls == null) {
        throw "out of index";
    } else if(n == 0){
        return head(ls);
    } else {
        return nth(tail(ls),n-1);
    }
}

var ls = pair(1, pair(2, null));
// show(pairToString(pair(2, null)));
//++++++++End由pair组成list的一些函数功能++++++++
//++++++++Start定义一个表达式的抽象数据结构及类似于解释器(interpreter)的函数calc++++++++ 
function binop(op, e1, e2) {
    return pair("binop", pair(op, pair(e1, pair(e2, null))));
}
function isBinOp(binop) {
    return isPair(binop) && first(binop) == "binop";
}
function binopOp(binop) {
    return first(second(binop));
}
function binopE1(bop) {
    return first(second(second(bop)));
}
function binopE2(bop) {
    return first(second(second(second(bop))));
}
function toInfix(bop) {
    if (isBinOp(bop)) {
        return "(" +
            toInfix(binopE1(bop)) +
            " " +
            binopOp(bop) +
            " " +
            toInfix(binopE2(bop)) +
            ")"
    } else {
        return bop;
    }
}

function toPrefix(bop){
    if (isBinOp(bop)) {
        return "(" +
            binopOp(bop) +
            " " +
            toInfix(binopE1(bop)) +
            " " +
            toInfix(binopE2(bop)) +
            ")"
    } else {
        return bop;
    }
}

function calc(bop){
    if (isBinOp(bop)) {
        var op = binopOp(bop);
        switch (op) {
            case "+":
                return calc(binopE1(bop)) + calc(binopE2(bop));
            case "-":
                return calc(binopE1(bop)) - calc(binopE2(bop));
            case "*":
                return calc(binopE1(bop)) * calc(binopE2(bop));
            case "/":
                let denominator = calc(binopE2(bop));
                if (denominator == 0) {
                    throw "表达式有分母为0";
                }
                return calc(binopE1(bop)) / denominator;
            default:
                throw "操作符不在允许范围内";
        }
        //return eval(calc(binopE1(bop)) + binopOp(bop) + calc(binopE2(bop)));  这样也可
    } else {
        return bop;
    }
}
//++++++++End定义一个表达式的抽象数据结构及类似于解释器(interpreter)的函数calc++++++++ 
var p = pair(2, 1);
var ls = pair(1,pair(2,null));
// show(nth(ls,0));
// first(p);
// second(p);
var bop = binop("+", binop("/", 0,1), binop("*", 2, 3));
// toInfix(bop);

// show(calc(bop));

//+++++++++Lookup table 查询表pair组成的list，可以不定义数据结构+++++++++
var emptyTable = null;
var pizza = pair("pizza",128);
var cake = pair("cake",46);
var pasta = pair("pasta",68);
var steak = pair("steak",258);
var salad = pair("salad",45);
var beer = pair("beer",35);
var menu1 = pair(pizza,pair(cake,pair(pasta,pair(steak,pair(salad,pair(beer,emptyTable))))));
var menu2 = pair(pair("pizza",128),pair(pair("cake",46),pair(pair("pasta",68),pair(pair("steak",258),pair(pair("salad",45),pair(pair("beer",35),emptyTable))))));
// show(menu1==menu2);
// show(pairToString(menu1));
// show(pairToString(menu2));

function lookupTable(key, table) {
    if (table == emptyTable) {
        throw "can not find";
    } else if (first(head(table)) == key) {
        return second(head(table));
    } else {
        return lookupTable(key,tail(table));
    }
}
//  testing example
// show(lookupTable("cake",menu1));
// show(lookupTable("beer",menu1));
// show(lookupTable("steak",menu1));
// show(lookupTable("steak",emptyTable));
// show(lookupTable("aaa", menu1));

function addTable(key,value,oldTable) {
    return pair(pair(key,value),oldTable);
}

// show(pairToString(addTable("noddle",22,menu1)));

//-------------------- Binary Search Tree --------------------//
var emptyBST = null;
//--------BSTs Constructor, an ADT(abstruct data type)--------// 
function bst(key, value, left, right) {
    return pair("bst", pair(pair(key, value), pair(left, pair(right, null))));
}
//--------BSTs 插入节点--------// 
function addBST(key, value, node) {
    var newNode = bst(key, value, emptyBST, emptyBST);
    if (node == emptyBST) {
        return newNode;
    } else {
        // 如果插入节点的值比父节点小，则插入父节点的左子节点、否则插入父节点的右子节点
        var nodeKey = first(first(second(node)));
        var nodeValue = second(first(second(node)));
        var nodeLeftTree = first(second(second(node)));
        var nodeRightTree = first(second(second(second(node))));
        if (key < nodeKey) {
            if (nodeLeftTree == emptyBST) {
                return bst(nodeKey, nodeValue, newNode, nodeRightTree);
            } else {
                return bst(nodeKey, nodeValue, addBST(key, value, nodeLeftTree), nodeRightTree);
            }
        } else {
            if (nodeRightTree == emptyBST) {
                return bst(nodeKey, nodeValue, nodeLeftTree, newNode);
            } else {
                return bst(nodeKey, nodeValue, nodeLeftTree, addBST(key, value, nodeRightTree));
            }
        }
    }
}

var bstMenu1 = bst("pizza", 128, emptyBST, emptyBST);
show(pairToString(bstMenu1));
// show(listToString(bstMenu1));
// var bstMenu2 = addBST("cake", 46, bstMenu1);
// show(pairToString(bstMenu2));

// var bstMenu3 = addBST("pasta", 68, bstMenu2);
// show(pairToString(bstMenu3));

// var bstMenu4 = addBST("steak", 258, bstMenu3);
// show(pairToString(bstMenu4));

// var bstMenu5 = addBST("salad", 45, bstMenu4);
// show(pairToString(bstMenu5));

// var bstMenu6 = addBST("beer", 35, bstMenu5);
// show(pairToString(bstMenu6));

//--------BSTs 查找节点--------// 
function lookupBST(key, node) {
    if (node == emptyBST) {
        throw "can not find";
    } else {
        var nodeKey = first(first(second(node)));
        var nodeValue = second(first(second(node)));
        var nodeLeftTree = first(second(second(node)));
        var nodeRightTree = first(second(second(second(node))));
        if (key == nodeKey) {
            return nodeValue;
        } else if (key < nodeKey) {
            return lookupBST(key, nodeLeftTree);
        } else {
            return lookupBST(key, nodeRightTree);
        }
    }
}

// show(lookupBST("salad",bstMenu6));
// show(lookupBST("pasta",bstMenu6));
// show(lookupBST("steak",bstMenu6));

// Interpreter 解释器
// variable Constructor
function variable(name) {
    return pair("variable",pair(name,null));
}
// variable's type predicate and vistors
function isVariable(x){
    return isPair(x) && first(x) == "variable";
}
function variableName(v){
    return first(second(v));
}
// function Constructor, for simplify, function just have one parameter
function func(param,body) {
    return pair("function", pair(param, pair(body, null)));
}
function isFunction(x) {
    return isPair(x) && first(x) == "function";
}
function funcParam(f){
    return first(second(f));
}
function funcBody(f){
    return first(second(second(f)));
}
//-------------  call -------------//
// 调用的第一个成员叫"操作符"（operator），第二个成员叫操作数（operand 或 argument）。
// 操作符可能是以下几种：
// 1. 函数表达式（匿名函数）
// 2. 指向函数的变量
// 3. 另一个调用，调用了返回函数的函数（比如 compose）
function call(op, arg){
    return pair("call", pair(op, pair(arg, null)));
}
function isCall(x){
    return isPair(x) && first(x) == "call";
}
function callOp(c){
    return first(second(c));
}
function callArg(f) {
    return first(second(second(f)));
}

// x => y => x + y  转化为我们自己语言的函数表达，这是一个柯里化函数  currying
var func1 = func("x",func("y",binop("+",variable("x"),variable("y"))));
//  (x => y => x + y)(2)(3)  转化为我们自己语言的函数调用
var call1 = call(call(func1,2),3);

// 增加一个闭包数据类型
function closure(exp,env){
    return pair("closure", pair(exp, pair(env, null)));
}
function isClosure(exp) {
    return isPair(exp) && first(exp) == "closure";
}
function closureFun(c) {
    return first(second(c));
}
function closureEnv(f) {
    return first(second(second(f)));
}

// --------- if ---------
function ifExp(conditon,trueBranch,falseBranch) {
    return pair("ifExp",pair(conditon,pair(trueBranch,pair(falseBranch,null))));
}
function isIfExp(x) { return isPair(x) && first(x) == "ifExp" }
function ifCondition(ifexp) { return first(second(ifexp)); }
function ifTrueBranch(ifexp) { return first(second(second(ifexp))); } 
function ifFalseBranch(ifexp) { return first(second(second(second(ifexp)))); }




// 把程序转换成字符串
function expToString(exp) {
    if (typeof (exp) == "number" || typeof (exp) == "string") {    
        return exp;  
    }  else if (isVariable(exp))  {    
        return variableName(exp);  
    }  else if (isFunction(exp))   {    
        return expToString(funcParam(exp)) + " => " + expToString(funcBody(exp));
    }  else if (isCall(exp))   {    
        var op = callOp(exp);
        var argString = "("
            + expToString(callArg(exp))
            + ")";
        if (isFunction(op)) {
            var fopString = expToString(op);
            return "(" 
                + fopString
                + ")"
                + argString;
        } else {
            return expToString(op) + argString;
        }
    }  else if (isBinOp(exp))   {    
        return "(" + expToString(binopE1(exp)) + binopOp(exp) + expToString(binopE2(exp)) + ")";
    }  else if (isClosure(exp))  {   
        // 闭包没有标准的显示方式，为了帮助理解，我们自己设计一个显示方式    
        // 显示的内容是函数加上 env 的内容，中间加一个冒号 :    
        // 函数需要递归调用 expToString，env 可以调用 listToString  
        show(pairToString(closureEnv(exp)));
        return expToString(closureFun(exp)) + " : " + listToString(closureEnv(exp));
    }  else   {    
        // 报错，非法表达式。    
        throw "illegal expression";  
    }
}
// (x => y => z => (x+y+z))(x)(y)(z);
// (x=> x * x)(3)
// show(expToString(variable("x")));  // x
// show(expToString(func("x", variable("x")))); // x => x
// show(expToString(func("x", binop("+", variable("x"), 2)))); // x => (x+2)
// show(expToString(func("x", binop("+", 1, binop("*", variable("x"), 2))))); // x => (1+(x*2))
// show(expToString(func1)); // x => y => x + y 
// show(expToString(call(variable("f"), 2))); // f(2)
// show(expToString(call(variable("f"), call(variable("g"), 2))));// f(g(2))
// (x => (x*x))(3)
// show(expToString(call(func("x", binop("*", variable("x"), variable("x"))),3)));
// (x => y => (x+y))(2)(3)
// show(expToString(
//     call(
//         call(
//             func("x", 
//                 func("y", 
//                     binop("+", variable("x"), variable("y")))), 
//             2), 
//         3)));
// f => x => f(x)
// show(expToString(func("f", func("x", call(variable("f"), variable("x"))))));

function listToString(exp) {
    if (typeof (exp) == "number" || typeof (exp) == "string") {
        return exp;
    } else if (isVariable(exp)) {
        return "(variable " + variableName(exp) + ")";
    } else if (isFunction(exp)) {
        return "(function " + listToString(funcParam(exp)) + " " + listToString(funcBody(exp)) + ")";
    } else if (isBinOp(exp)) {
        return "(binop " + binopOp(exp) + " " + listToString(binopE1(exp)) + " " + listToString(binopE2(exp)) + ")";
    } else if (isClosure(exp)) {
        return "(closure " + listToString(closureFun(exp)) + " " + listToString(closureEnv(exp)) + ")";
    } else if (isPair(exp)) {
        if (first(exp) == "bst") {
            var nodeKey = first(first(second(exp)));
            var nodeValue = second(first(second(exp)));
            var nodeLeftTree = first(second(second(exp)));
            var nodeRightTree = first(second(second(second(exp))));
            return "(bst " + listToString(nodeKey) + " " + listToString(nodeValue) + " " + listToString(nodeLeftTree) + " " + listToString(nodeRightTree) + ")";
        } else {
            return "(" + listToString(first(exp)) + " . " + listToString(second(exp)) + ")";
        }
    } else if (exp == null) {
        return "()";
    } else{
        // 报错，非法表达式。    
        throw "illegal expression";
    }
}

var sqFun = func("x", binop("*", variable("x"), variable("x")));

// show(pairToString(sqFun));
show(listToString(interp(sqFun)));

// 使用抽象接口，有可能后面不使用Table，而是BST
var emptyEnv = emptyTable;
var extEnv = addTable;
var lookupEnv = lookupTable;

// var emptyEnv = emptyBST;
// var extEnv = addBST;
// var lookupEnv = lookupBST;

//----------- Interpreter ---------
function interp(exp) {
    function interp(exp, env) {
        if (typeof (exp) == "number" || typeof (exp) == "boolean" || typeof (exp) == "string") {
            return exp;
        } else if (isVariable(exp)) {
            try {
                return lookupEnv(variableName(exp), env);
            } catch (error) {
                throw "undefined variable: " + variableName(exp);
            }
        } else if (isFunction(exp)) {
            // return exp; // not over yet, need create a closure 
            return closure(exp,env);
        } else if (isCall(exp)) {
            var op = interp(callOp(exp),env);
            var arg = interp(callArg(exp),env);
            // if (isFunction(op)) {
            //     var newEnv = extEnv(funcParam(op), arg, env);
            //     return interp(funcBody(op),newEnv);
            // } else {
            //     throw "Calling non-function: " + pairToString(op);
            // }
            if (isClosure(op)) {
                var f = closureFun(op);
                var newEnv = extEnv(funcParam(f), arg, closureEnv(op));
                return interp(funcBody(f), newEnv);
            } else {
                throw "Calling non-function";
            }
        } else if (isBinOp(exp)) {
            var op = binopOp(exp);
            switch (op) {
                case "+":
                    return interp(binopE1(exp), env) + interp(binopE2(exp), env);
                case "-":
                    return interp(binopE1(exp), env) - interp(binopE2(exp), env);
                case "*":
                    return interp(binopE1(exp), env) * interp(binopE2(exp), env);
                case "/":
                    let denominator = interp(binopE2(exp), env);
                    if (denominator == 0) {
                        throw "表达式有分母为0";
                    }
                    return interp(binopE1(exp), env) / denominator;
                case "==":
                    return interp(binopE1(exp), env) == interp(binopE2(exp), env);
                case ">":
                    return interp(binopE1(exp), env) > interp(binopE2(exp), env);
                case "<":
                    return interp(binopE1(exp), env) < interp(binopE2(exp), env);
                default:
                    throw "操作符不在允许范围内";
            }
        } else if (isIfExp(exp)){
            var condition = interp(ifCondition(exp),env);
            if (condition) {
                return interp(ifTrueBranch(exp),env);
            } else {
                return interp(ifFalseBranch(exp), env);
            }
        } else {
            throw "Illegal expression: " + pairToString(exp);
        }
    }
    return interp(exp, emptyEnv);
}

// --------------------------------------------------------------------------------------
// 闭包就是函数的值。为什么要有闭包呢？回忆第一课的例子，var g = (x => y => x + y)(2)，         --
// 我们得到 y => x + y 并让变量 g 指向它。但 y => x + y 并不是完整的信息，我们必须记住 x 等于 2，--
// 才能在 g(3) 调用时找到 x 的值。我们必须记住函数产生的时候（而不是调用的时候），                ---
// 函数体里面出现的自由变量（free variable）和它们的值。                                     ---
// 在 y => x + y 里面，x 就是自由变量，因为它不是这个函数里面的参数或变量。闭包就是用来记忆这个信息的。-
// --------------------------------------------------------------------------------------

// show(interp(binop("-",binop("*",3,4),2)));
// show(interp(variable("x"),emptyTable));
// show(interp(call(func("x", binop("+", variable("x"), 2)),2)))
// show(interp(call(
//         call(
//             func("x",
//                 func("y",
//                     binop("+",variable("x"),variable("y")))
//                 ),
//             2),
//        3)));
// show(interp(call1,emptyEnv));

var curriedAdd = func("x", func("y", binop("+", variable("x"), variable("y"))));

show(interp(call(call(curriedAdd, 2), 3)));

show(expToString(interp(call(curriedAdd, 2))));

// -------- compose (curried) ---------
// f => g => x => f(g(x))
var composeFun = func("f", func("g", func("x", call(variable("f"), call(variable("g"), variable("x")))))); 
var add1 = func("x", binop("+", variable("x"), 1)); 
var square = func("x", binop("*", variable("x"), variable("x")));

// var composed = compose(add1)(square);
var composed1 = call(call(composeFun, add1), square);
// composed(3)
var composeCall1 = call(composed1, 3); 
show(interp(composeCall1));
// compose(square)(add1)(3)
var composeCall2 = call(call(call(composeFun, square), add1), 3);
show(interp(composeCall2));


// show(interp(ifExp(true, "cat", "dog")));
// show(interp(ifExp(false, "cat", "dog")));
// show(interp(ifExp(binop("<", 1, 2), "cat", "dog")));
// show(interp(ifExp(binop(">", 1, 2), "cat", "dog")));
// show(interp(call(func("f", ifExp(call(variable("f"), 12), "cat", "dog")), func("x", binop(">", variable("x"), 7)))));
// show(interp(call(func("f", ifExp(call(variable("f"), 5), "cat", "dog")), func("x", binop(">", variable("x"), 7)))));

// Y combinator 的定义
// Y组合子实际上是为了实现lambda演算模型实现匿名函数递归计算
// 下面的Y其实是 Y(G) = G ,即是寻找函数的不动点
// 由于要实现匿名函数的递归，因此使用Y计算出匿名函数
var Y = f => 
(x => f(v => x(x)(v)))
(x => f(v => x(x)(v)));

var factGen = fact => 
n => { 
    if (n == 0) { 
        return 1; 
    } else { 
        return n * fact(n - 1); 
    } 
}; 
var yfact = Y(factGen); 
show(yfact(5));

// 另一种实现 Y组合子的方式 
var Y = f => 
(x => x(x))
(y => f(x => y(y)(x)));
var fac = Y(f => n => n > 1 ? n * f(n - 1) : 1);
fac(10)
