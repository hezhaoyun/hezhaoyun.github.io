---
layout: post
title: "TypeScript 学习笔记"
category: tech
date: 2018-03-15 15:16:15 +0800
---

### Unions and type guards

```typescript
type NameOrNameArray = string | string[];

function createName(name: NameOrNameArray) {

    if (typeof name === "string") {
        return name;
    }
    else {
        return name.join(" ");
    }
}

var greetingMessage = Greetings, ${ createName(["Sam", "Smith"]) };
alert(greetingMessage);
```

### Using Generics

```typescript
class Greeter<T> {
    greeting: T;
    constructor(message: T) {
        this.greeting = message;
    }
    greet() {
        return this.greeting;
    }
}
let greeter = new Greeter<string>("Hello, world");
let button = document.createElement('button');
button.textContent = "Say Hello";
button.onclick = function() {
    alert(greeter.greet());
}
document.body.appendChild(button);
```

### 枚举反查名称

枚举类型提供的一个便利是你可以由枚举的值得到它的名字。 例如，我们知道数值为2，但是不确定它映射到Color里的哪个名字，我们可以查找相应的名字：

```typescript
enum Color {Red = 1, Green, Blue};
let colorName: string = Color[2];
alert(colorName);
```

### 类型断言

有时候你会遇到这样的情况，你会比TypeScript更了解某个值的详细信息。 通常这会发生在你清楚地知道一个实体具有比它现有类型更确切的类型。

通过类型断言这种方式可以告诉编译器，“相信我，我知道自己在干什么”。 类型断言好比其它语言里的类型转换，但是不进行特殊的数据检查和解构。 它没有运行时的影响，只是在编译阶段起作用。 TypeScript会假设你，程序员，已经进行了必须的检查。

类型断言有两种形式。 其一是“尖括号”语法：

```typescript
let someValue: any = "this is a string";
let strLength: number = (<string>someValue).length;
```

另一个为as语法：

```typescript
let someValue: any = "this is a string";
let strLength: number = (someValue as string).length;
```

两种形式是等价的。 至于使用哪个大多数情况下是凭个人喜好；然而，当你在TypeScript里使用JSX时，只有as语法断言是被允许地。

### 解构

#### 解构数组

最简单的解构莫过于数组的解构赋值了：

```typescript
let input = [1, 2];
let [first, second] = input;

console.log(first); // outputs 1
console.log(second); // outputs 2
```

这创建了2个命名变量 first 和 second。 相当于使用了索引，但更为方便：

```typescript
first = input[0];
second = input[1];
```

解构作用于已声明的变量会更好：

```typescript
// swap variables
[first, second] = [second, first];
```

作用于函数参数：

```typescript
function f([first, second]: [number, number]) {
    console.log(first);
    console.log(second);
}

f(input);
```

你可以使用...name语法创建一个剩余变量列表：

```typescript
let [first, ...rest] = [1, 2, 3, 4];
console.log(first); // outputs 1
console.log(rest); // outputs [ 2, 3, 4 ]
```

当然，由于是JavaScript, 你可以忽略你不关心的尾随元素：

```typescript
let [first] = [1, 2, 3, 4];
console.log(first); // outputs 1
```

或其它元素：

```typescript
let [, second, , fourth] = [1, 2, 3, 4];
```

#### 对象解构

你也可以解构对象：

```typescript
let o = {
    a: "foo",
    b: 12,
    c: "bar"
}

let {a, b} = o;
```

这通过 o.a and o.b 创建了 a 和 b 。 注意，如果你不需要 c 你可以忽略它。

就像数组解构，你可以用没有声明的赋值：

```typescript
({a, b} = {a: "baz", b: 101});
```

注意，我们需要用括号将它括起来，因为Javascript通常会将以 { 起始的语句解析为一个块。

#### 默认值

默认值可以让你在属性为 undefined 时使用缺省值：

```typescript
function keepWholeObject(wholeObject: {a: string, b?: number}) {
    let {a, b = 1001} = wholeObject;
}
```

现在，即使 b 为 undefined ， keepWholeObject 函数的变量 wholeObject 的属性 a 和 b 都会有值。

### 可选属性

#### 可选属性

接口里的属性不全都是必需的。 有些是只在某些条件下存在，或者根本不存在。 可选属性在应用“option bags”模式时很常用，即给函数传入的参数对象中只有部分属性赋值了。

下面是应用了“option bags”的例子：

```typescript
interface SquareConfig {
    color?: string;
    width?: number;
}

function createSquare(config: SquareConfig): {color: string; area: number} {

    let newSquare = {color: "white", area: 100};

    if (config.color) {
        newSquare.color = config.color;
    }

    if (config.width) {
        newSquare.area = config.width * config.width;
    }

    return newSquare;
}

let mySquare = createSquare({color: "black"});
```

带有可选属性的接口与普通的接口定义差不多，只是在可选属性名字定义的后面加一个?符号。

#### 额外的属性检查

我们在第一个例子里使用了接口，TypeScript让我们传入{ size: number; label: string; }到仅期望得到{ label: string; }的函数里。 我们已经学过了可选属性，并且知道他们在“option bags”模式里很有用。

然而，天真地将这两者结合的话就会像在JavaScript里那样搬起石头砸自己的脚。 比如，拿createSquare例子来说：

```typescript
interface SquareConfig {
    color?: string;
    width?: number;
}

function createSquare(config: SquareConfig): { color: string; area: number } {
    // ...
}

let mySquare = createSquare({ colour: "red", width: 100 });
```

注意传入createSquare的参数拼写为colour而不是color。 在JavaScript里，这会默默地失败。

你可能会争辩这个程序已经正确地类型化了，因为width属性是兼容的，不存在color属性，而且额外的colour属性是无意义的。

然而，TypeScript会认为这段代码可能存在bug。 对象字面量会被特殊对待而且会经过额外属性检查，当将它们赋值给变量或作为参数传递的时候。 如果一个对象字面量存在任何“目标类型”不包含的属性时，你会得到一个错误。

```typescript
// error: 'colour' not expected in type 'SquareConfig'
let mySquare = createSquare({ colour: "red", width: 100 });
```

绕开这些检查非常简单。 最简便的方法是使用类型断言：

```typescript
let mySquare = createSquare({ width: 100, opacity: 0.5 } as SquareConfig);
```

然而，最佳的方式是能够添加一个字符串索引签名，前提是你能够确定这个对象可能具有某些做为特殊用途使用的额外属性。 如果SquareConfig带有上面定义的类型的color和width属性，并且还会带有任意数量的其它属性，那么我们可以这样定义它：

```typescript
interface SquareConfig {
    color?: string;
    width?: number;
	[propName: string]: any;
}
```

我们稍后会讲到索引签名，但在这我们要表示的是SquareConfig可以有任意数量的属性，并且只要它们不是color和width，那么就无所谓它们的类型是什么。

还有最后一种跳过这些检查的方式，这可能会让你感到惊讶，它就是将这个对象赋值给一个另一个变量： 因为squareOptions不会经过额外属性检查，所以编译器不会报错。

```typescript
let squareOptions = { colour: "red", width: 100 };
let mySquare = createSquare(squareOptions);
```

要留意，在像上面一样的简单代码里，你可能不应该去绕开这些检查。 对于包含方法和内部状态的复杂对象字面量来讲，你可能需要使用这些技巧，但是大部额外属性检查错误是真正的bug。 就是说你遇到了额外类型检查出的错误，比如选择包，你应该去审查一下你的类型声明。 在这里，如果支持传入color或colour属性到createSquare，你应该修改SquareConfig定义来体现出这一点。

### 接口中可以有成员变量和方法

与C#或Java里接口的基本作用一样，TypeScript也能够用它来明确的强制一个类去符合某种契约。

```typescript
interface ClockInterface {
    currentTime: Date;
}

class Clock implements ClockInterface {
    currentTime: Date;
    constructor(h: number, m: number) { }
}
```

你也可以在接口中描述一个方法，在类里实现它，如同下面的setTime方法一样：

```typescript
interface ClockInterface {
    currentTime: Date;
    setTime(d: Date);
}

class Clock implements ClockInterface {

    currentTime: Date;
    setTime(d: Date) {
        this.currentTime = d;
    }

    constructor(h: number, m: number) { }
}
```

接口描述了类的公共部分，而不是公共和私有两部分。 它不会帮你检查类是否具有某些私有成员。

### 扩展接口

#### 扩展接口

和类一样，接口也可以相互扩展。 这让我们能够从一个接口里复制成员到另一个接口里，可以更灵活地将接口分割到可重用的模块里。

```typescript
interface Shape {
    color: string;
}

interface Square extends Shape {
    sideLength: number;
}

let square = <Square>{};
square.color = "blue";
square.sideLength = 10;
```

一个接口可以继承多个接口，创建出多个接口的合成接口。

```typescript
interface Shape {
    color: string;
}

interface PenStroke {
    penWidth: number;
}

interface Square extends Shape, PenStroke {
    sideLength: number;
}

let square = <Square>{};
square.color = "blue";
square.sideLength = 10;
square.penWidth = 5.0;
```

#### 混合类型

先前我们提过，接口能够描述JavaScript里丰富的类型。 因为JavaScript其动态灵活的特点，有时你会希望一个对象可以同时具有上面提到的多种类型。

一个例子就是，一个对象可以同时做为函数和对象使用，并带有额外的属性。

```typescript
interface Counter {
    (start: number): string;
    interval: number;
    reset(): void;
}

function getCounter(): Counter {

    let counter = <Counter>function (start: number) { };
    counter.interval = 123;
    counter.reset = function () { };
    
    return counter;
}

let c = getCounter();
c(10);
c.reset();
c.interval = 5.0;
```



在使用JavaScript第三方库的时候，你可能需要像上面那样去完整地定义类型。

#### 接口继承类

当接口继承了一个类类型时，它会继承类的成员但不包括其实现。 就好像接口声明了所有类中存在的成员，但并没有提供具体实现一样。 接口同样会继承到类的private和protected成员。 这意味着当你创建了一个接口继承了一个拥有私有或受保护的成员的类时，这个接口类型只能被这个类或其子类所实现（implement）。

这是很有用的，当你有一个很深层次的继承，但是只想你的代码只是针对拥有特定属性的子类起作用的时候。子类除了继承自基类外与基类没有任何联系。 例：

```typescript
class Control {
    private state: any;
}

interface SelectableControl extends Control {
    select(): void;
}

class Button extends Control {
    select() { }
}

class TextBox extends Control {
    select() { }
}

class Image extends Control {
}

class Location {
    select() { }
}
```



在上面的例子里，SelectableControl包含了Control的所有成员，包括私有成员state。 因为state是私有成员，所以只能够是Control的子类们才能实现SelectableControl接口。 因为只有Control的子类才能够拥有一个声明于Control的私有成员state，这对私有成员的兼容性是必需的。

在Control类内部，是允许通过SelectableControl的实例来访问私有成员state的。 实际上，SelectableControl就像Control一样，并拥有一个select方法。 Button和TextBox类是SelectableControl的子类（因为它们都继承自Control并有select方法），但Image和Location类并不是这样的。

### 把类当做接口使用

如上一节里所讲的，类定义会创建两个东西：类实例的类型和一个构造函数。 因为类可以创建出类型，所以你能够在可以使用接口的地方使用类。

```typescript
class Point {
    x: number;
    y: number;
}

interface Point3d extends Point {
    z: number;
}

let point3d: Point3d = {x: 1, y: 2, z: 3};
```

### 可选参数和默认参数

JavaScript里，每个参数都是可选的，可传可不传。 没传参的时候，它的值就是undefined。 在TypeScript里我们可以在参数名旁使用?实现可选参数的功能。 比如，我们想让last name是可选的：

```typescript
function buildName(firstName: string, lastName?: string) {
    
    if (lastName)
        return firstName + " " + lastName;
    else
        return firstName;
}

let result1 = buildName("Bob");  // works correctly now
let result2 = buildName("Bob", "Adams", "Sr.");  // error, too many parameters
let result3 = buildName("Bob", "Adams");  // ah, just right
```

可选参数必须跟在必须参数后面。 如果上例我们想让first name是可选的，那么就必须调整它们的位置，把first name放在后面。

在TypeScript里，我们也可以为参数提供一个默认值当用户没有传递这个参数或传递的值是undefined时。 它们叫做有默认初始化值的参数。 让我们修改上例，把last name的默认值设置为"Smith"。

```typescript
function buildName(firstName: string, lastName = "Smith") {
    return firstName + " " + lastName;
}

let result1 = buildName("Bob");                  // works correctly now, returns "Bob Smith"
let result2 = buildName("Bob", undefined);       // still works, also returns "Bob Smith"
let result3 = buildName("Bob", "Adams", "Sr.");  // error, too many parameters
let result4 = buildName("Bob", "Adams");         // ah, just right
```

在所有必须参数后面的带默认初始化的参数都是可选的，与可选参数一样，在调用函数的时候可以省略。 也就是说可选参数与末尾的默认参数共享参数类型。

```typescript
function buildName(firstName: string, lastName?: string) {
    // ...
}
```

和

```typescript
function buildName(firstName: string, lastName = "Smith") {
    // ...
}
```

共享同样的类型(firstName: string, lastName?: string) => string。 默认参数的默认值消失了，只保留了它是一个可选参数的信息。

与普通可选参数不同的是，带默认值的参数不需要放在必须参数的后面。 如果带默认值的参数出现在必须参数前面，用户必须明确的传入undefined值来获得默认值。

### 剩余参数

有时，你想同时操作多个参数，或者你并不知道会有多少参数传递进来。 在JavaScript里，你可以使用arguments来访问所有传入的参数。

在TypeScript里，你可以把所有参数收集到一个变量里：

```typescript
function buildName(firstName: string, ...restOfName: string[]) {
    return firstName + " " + restOfName.join(" ");
}

let employeeName = buildName("Joseph", "Samuel", "Lucas", "MacKinzie");
```

剩余参数会被当做个数不限的可选参数。 可以一个都没有，同样也可以有任意个。 编译器创建参数数组，名字是你在省略号（...）后面给定的名字，你可以在函数体内使用这个数组。

这个省略号也会在带有剩余参数的函数类型定义上使用到：

```typescript
function buildName(firstName: string, ...restOfName: string[]) {
    return firstName + " " + restOfName.join(" ");
}

let buildNameFun: (fname: string, ...rest: string[]) => string = buildName;
```

### Lambda表达式和使用this

JavaScript里this的工作机制对JavaScript程序员来说已经是老生常谈了。 的确，学会如何使用它绝对是JavaScript编程中的一件大事。 由于TypeScript是JavaScript的超集，TypeScript程序员也需要弄清this工作机制并且当有bug的时候能够找出错误所在。 this的工作机制可以单独写一本书了，并确已有人这么做了。在这里，我们只介绍一些基础知识。

JavaScript里，this的值在函数被调用的时候才会指定。 这是个既强大又灵活的特点，但是你需要花点时间弄清楚函数调用的上下文是什么。 众所周知这不是一件很简单的事，特别是函数当做回调函数使用的时候。

下面看一个例子：

```typescript
let deck = {

    suits: ["hearts", "spades", "clubs", "diamonds"],
    cards: Array(52),

    createCardPicker: function() {
        return function() {
            let pickedCard = Math.floor(Math.random() * 52);
            let pickedSuit = Math.floor(pickedCard / 13);
            return {suit: this.suits[pickedSuit], card: pickedCard % 13};
        }
    }
}

let cardPicker = deck.createCardPicker();
let pickedCard = cardPicker();

alert("card: " + pickedCard.card + " of " + pickedCard.suit);
```

如果我们运行这个程序，会发现它并没有弹出对话框而是报错了。 因为createCardPicker返回的函数里的this被设置成了window而不是deck对象。 当你调用cardPicker()时会发生这种情况。这里没有对this进行动态绑定因此为window。（注意在严格模式下，会是undefined而不是window）。

为了解决这个问题，我们可以在函数被返回时就绑好正确的this。 这样的话，无论之后怎么使用它，都会引用绑定的‘deck’对象。

我们把函数表达式变为使用lambda表达式（ () => {} ）。 这样就会在函数创建的时候就指定了‘this’值，而不是在函数调用的时候。

```typescript
let deck = {

    suits: ["hearts", "spades", "clubs", "diamonds"],
    cards: Array(52),

    createCardPicker: function() {
        // Notice: the line below is now a lambda, allowing us to capture this earlier
        return () => {
            let pickedCard = Math.floor(Math.random() * 52);
            let pickedSuit = Math.floor(pickedCard / 13);
            return {suit: this.suits[pickedSuit], card: pickedCard % 13};
        }
    }
}

let cardPicker = deck.createCardPicker();
let pickedCard = cardPicker();

alert("card: " + pickedCard.card + " of " + pickedCard.suit);
```

为了解更多关于this的信息，请阅读Yahuda Katz的[Understanding JavaScript Function Invocation and "this"](http://yehudakatz.com/2011/08/11/understanding-javascript-function-invocation-and-this/)。

### 类型兼容性

TypeScript结构化类型系统的基本规则是，如果x要兼容y，那么y至少具有与x相同的属性。比如：

```typescript
interface Named {
    name: string;
}

let x: Named;

// y's inferred type is { name: string; location: string; }
let y = { name: 'Alice', location: 'Seattle' };
x = y;
```

这里要检查y是否能赋值给x，编译器检查x中的每个属性，看是否能在y中也找到对应属性。 在这个例子中，y必须包含名字是name的string类型成员。y满足条件，因此赋值正确。

检查函数参数时使用相同的规则：

```typescript
function greet(n: Named) {
    alert('Hello, ' + n.name);
}

greet(y); // OK
```

注意，y有个额外的location属性，但这不会引发错误。 只有目标类型（这里是Named）的成员会被一一检查是否兼容。

这个比较过程是递归进行的，检查每个成员及子成员。

类与对象字面量和接口差不多，但有一点不同：类有静态部分和实例部分的类型。 比较两个类类型的对象时，只有实例的成员会被比较。 静态成员和构造函数不在比较的范围内。

```typescript
class Animal {
    feet: number;
    constructor(name: string, numFeet: number) { }
}

class Size {
    feet: number;
    constructor(numFeet: number) { }
}

let a: Animal;
let s: Size;
a = s;  //OK
s = a;  //OK
```

#### 类的私有成员

私有成员会影响兼容性判断。 当类的实例用来检查兼容时，如果它包含一个私有成员，那么目标类型必须包含来自同一个类的这个私有成员。 这允许子类赋值给父类，但是不能赋值给其它有同样类型的类。

### 字符串字面量类型

字符串字面量类型允许你指定字符串必须的固定值。 在实际应用中，字符串字面量类型可以与联合类型，类型保护和类型别名很好的配合。 通过结合使用这些特性，你可以实现类似枚举类型的字符串。

```typescript
type Easing = "ease-in" | "ease-out" | "ease-in-out";

class UIElement {
    
    animate(dx: number, dy: number, easing: Easing) {
        
        if (easing === "ease-in") {
            // ...
        }
        else if (easing === "ease-out") {
        }
        else if (easing === "ease-in-out") {
        }
        else {
            // error! should not pass null or undefined.
        }
    }
}

let button = new UIElement();
button.animate(0, 0, "ease-in");
button.animate(0, 0, "uneasy"); // error: "uneasy" is not allowed here
```

你只能从三种允许的字符中选择其一来做为参数传递，传入其它值则会产生错误。

Argument of type '"uneasy"' is not assignable to parameter of type '"ease-in" | "ease-out" | "ease-in-out"'

### 多态的this类型

多态的this类型表示的是某个包含类或接口的子类型。 这被称做F-bounded多态性。 它能很容易的表现连贯接口间的继承，比如。 在计算器的例子里，在每个操作之后都返回this类型：

```typescript
class BasicCalculator {

    public constructor(protected value: number = 0) { }

    public currentValue(): number {
        return this.value;
    }

    public add(operand: number): this {
        this.value += operand;
        return this;
    }

    public multiply(operand: number): this {
        this.value *= operand;
        return this;
    }

    // ... other operations go here ...
}

let v = new BasicCalculator(2)
            .multiply(5)
            .add(1)
            .currentValue();
```

由于这个类使用了this类型，你可以继承它，新的类可以直接使用之前的方法，不需要做任何的改变。

```typescript
class ScientificCalculator extends BasicCalculator {

    public constructor(value = 0) {
        super(value);
    }

    public sin() {
        this.value = Math.sin(this.value);
        return this;
    }
    
    // ... other operations go here ...
}

let v = new ScientificCalculator(2)
        .multiply(5)
        .sin()
        .add(1)
        .currentValue();
```

如果没有this类型，ScientificCalculator就不能够在继承BasicCalculator的同时还保持接口的连贯性。multiply将会返回BasicCalculator，它并没有sin方法。 然而，使用this类型，multiply会返回this，在这里就是ScientificCalculator。