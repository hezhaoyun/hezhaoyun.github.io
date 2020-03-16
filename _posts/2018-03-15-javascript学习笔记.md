---
layout: post
title: "JavaScript学习笔记"
category: tech
date: 2018-03-15 14:20:27 +0800
---

### JavaScript 使用

那些老旧的实例可能会在 <script> 标签中使用 type="text/javascript"。现在已经不必这样做了。JavaScript 是所有现代浏览器以及 HTML5 中的默认脚本语言。

### JavaScript 语句

在 JavaScript 中，用分号来结束语句是可选的。

### JavaScript 变量

未使用值来声明的变量，其值实际上是 undefined。

在以下两条语句执行后，变量 carname 的值依然是 "Volvo"：

```javascript
var carname = "Volvo";
var carname;
```

### JavaScript 数据类型

Undefined 这个值表示变量不含有值。

可以通过将变量的值设置为 null 来清空变量。

当您声明新变量时，可以使用关键词 "new" 来声明其类型：

```javascript
var carname=new String;
var x=      new Number;
var y=      new Boolean;
var cars=   new Array;
var person= new Object;
```

JavaScript 变量均为对象。当您声明一个变量时，就创建了一个新的对象。

### ECMAScript 原始类型

ECMAScript 有 5 种原始类型（primitive type），即 Undefined、Null、Boolean、Number 和 String。

对变量或值调用 typeof 运算符将返回下列值之一：

- undefined - 如果变量是 Undefined 类型的
- boolean - 如果变量是 Boolean 类型的
- number - 如果变量是 Number 类型的
- string - 如果变量是 String 类型的
- object - 如果变量是一种引用类型或 Null 类型的

当函数无明确返回值时，返回的也是值 "undefined"，如下所示：

```javascript
function testFunc() {
}

alert(testFunc() == undefined);  //输出 "true"
```

对于浮点字面量的有趣之处在于，用它进行计算前，真正存储的是字符串。

最后一个特殊值是 NaN，表示非数（Not a Number）。NaN 是个奇怪的特殊值。一般说来，这种情况发生在类型（String、Boolean 等）转换失败时。例如，要把单词 blue 转换成数值就会失败，因为没有与之等价的数值。与无穷大一样，NaN 也不能用于算术计算。NaN 的另一个奇特之处在于，它与自身不相等，这意味着下面的代码将返回 false：

```javascript
alert(NaN == NaN);  //输出 "false"
```

出于这个原因，不推荐使用 NaN 值本身。函数 isNaN() 会做得相当好：

```javascript
alert(isNaN("blue"));  //输出 "true"
alert(isNaN("666"));  //输出 "false"
```

对于浮点字面量的有趣之处在于，用它进行计算前，真正存储的是字符串。

### ECMAScript 类型转换

ECMAScript 的 Boolean 值、数字和字符串的原始值的有趣之处在于它们是伪对象，这意味着它们实际上具有属性和方法。

Number 类型的 toString() 方法比较特殊，它有两种模式，即*默认模式*和*基模式*。采用默认模式，toString() 方法只是用相应的字符串输出数字值（无论是整数、浮点数还是科学计数法），如下所示：

```javascript
var iNum1 = 10;
var iNum2 = 10.0;
alert(iNum1.toString());	//输出 "10"
alert(iNum2.toString());	//输出 "10"
```

注释：在默认模式中，无论最初采用什么表示法声明数字，Number 类型的 toString() 方法返回的都是数字的十进制表示。因此，以八进制或十六进制字面量形式声明的数字输出的都是十进制形式的。

采用 Number 类型的 toString() 方法的基模式，可以用不同的*基*输出数字，例如二进制的基是 2，八进制的基是 8，十六进制的基是 16。

*基*只是要转换成的基数的另一种加法而已，它是 toString() 方法的参数：

```javascript
var iNum = 10;
alert(iNum.toString(2));	//输出 "1010"
alert(iNum.toString(8));	//输出 "12"
alert(iNum.toString(16));	//输出 "A"
```

在前面的示例中，以 3 种不同的形式输出了数字 10，即二进制形式、八进制形式和十六进制形式。HTML 采用十六进制表示每种颜色，在 HTML 中处理数字时这种功能非常有用。

注释：对数字调用 toString(10) 与调用 toString() 相同，它们返回的都是该数字的十进制形式。

ECMAScript 提供了两种把非数字的原始值转换成数字的方法，即 parseInt() 和 parseFloat()。

正如您可能想到的，前者把值转换成整数，后者把值转换成浮点数。只有对 String 类型调用这些方法，它们才能正确运行；对其他类型返回的都是 NaN。

ECMAScript 中可用的 3 种强制类型转换如下：

- Boolean(value) - 把给定的值转换成 Boolean 型；
- Number(value) - 把给定的值转换成数字（可以是整数或浮点数）；
- String(value) - 把给定的值转换成字符串；

用这三个函数之一转换值，将创建一个新值，存放由原始值直接转换成的值。这会造成意想不到的后果。

### ECMAScript 引用类型

在 ECMAScript 中很少使用 Boolean 对象，即使使用，也不易理解。

问题通常出现在 Boolean 表达式中使用 Boolean 对象时。例如：

```javascript
var oFalseObject = new Boolean(false);
var bResult = oFalseObject && true;	//输出 true
```

在这段代码中，用 false 值创建 Boolean 对象。然后用这个值与原始值 true 进行 AND 操作。在 Boolean 运算中，false 和 true 进行 AND 操作的结果是 false。不过，在这行代码中，计算的是 oFalseObject，而不是它的值 false。

正如前面讨论过的，在 Boolean 表达式中，所有对象都会被自动转换为 true，所以 oFalseObject 的值是 true。然后 true 再与 true 进行 AND 操作，结果为 true。

Number 对象还有几个处理数值的专用方法。

#### toFixed() 方法

toFixed() 方法返回的是具有指定位数小数的数字的字符串表示。例如：

```javascript
var oNumberObject = new Number(68);
alert(oNumberObject.toFixed(2));  //输出 "68.00"
```

在这里，toFixed() 方法的参数是 2，说明应该显示两位小数。该方法返回 "68.00"，空的字符串位由 0 来补充。对于处理货币的应用程序，该方法非常有用。toFixed() 方法能表示具有 0 到 20 位小数的数字，超过这个范围的值会引发错误。

#### toExponential() 方法

与格式化数字相关的另一个方法是 toExponential()，它返回的是用科学计数法表示的数字的字符串形式。

与 toFixed() 方法相似，toExponential() 方法也有一个参数，指定要输出的小数的位数。例如：

```javascript
var oNumberObject = new Number(68);
alert(oNumberObject.toExponential(1));  //输出 "6.8e+1"
```

这段代码的结果是 "6.8e+1"，前面解释过，它表示 6.8x101。问题是，如果不知道要用哪种形式（预定形式或指数形式）表示数字怎么办？可以用 toPrecision() 方法。

#### toPrecision() 方法

toPrecision() 方法根据最有意义的形式来返回数字的预定形式或指数形式。它有一个参数，即用于表示数的数字总数（不包括指数）。例如，

```javascript
var oNumberObject = new Number(68);
alert(oNumberObject.toPrecision(1));  //输出 "7e+1"
```

这段代码的任务是用一位数字表示数字 68，结果为 "7e+1"，以另外的形式表示即 70。的确，toPrecision() 方法会对数进行舍入。不过，如果用 2 位数字表示 68，就容易多了：

```javascript
var oNumberObject = new Number(68);
alert(oNumberObject.toPrecision(2));  //输出 "68"
```

当然，输出的是 "68"，因为这正是该数的准确表示。不过，如果指定的位数多于需要的位数又如何呢？

```javascript
var oNumberObject = new Number(68);
alert(oNumberObject.toPrecision(3));  //输出 "68.0"
```

在这种情况下，toPrecision(3) 等价于 toFixed(1)，输出的是 "68.0"。

toFixed()、toExponential() 和 toPrecision() 方法都会进行舍入操作，以便用正确的小数位数正确地表示一个数。

提示：与 Boolean 对象相似，Number 对象也很重要，不过应该少用这种对象，以避免潜在的问题。只要可能，都使用数字的原始表示法。

### ECMAScript 一元运算符

delete 运算符删除对以前定义的对象属性或方法的引用。例如：

```javascript
var o = new Object;
o.name = "David";
alert(o.name);  //输出 "David"delete o.name;
alert(o.name);  //输出 "undefined"
```

delete 运算符不能删除开发者未定义的属性和方法。例如，下面的代码将引发错误：

```javascript
delete o.toString;
```

即使 toString 是有效的方法名，这行代码也会引发错误，因为 toString() 方法是原始的 ECMAScript 方法，不是开发者定义的。

void 运算符对任何值返回 undefined。该运算符通常用于避免输出不应该输出的值，例如，从 HTML 的 <a> 元素调用 JavaScript 函数时。要正确做到这一点，函数不能返回有效值，否则浏览器将清空页面，只显示函数的结果。例如：

```html
<a href="javascript:window.open('about:blank')">Click me</a>
```

如果把这行代码放入 HTML 页面，点击其中的链接，即可看到屏幕上显示 "[object]"。[TIY](http://www.w3school.com.cn/tiy/t.asp?f=jseg_operators_unary_void)

这是因为 window.open() 方法返回了新打开的窗口的引用。然后该对象将被转换成要显示的字符串。

要避免这种效果，可以用 void 运算符调用 window.open() 函数：

```html
<a href="javascript:void(window.open('about:blank'))">Click me</a>
```

这使 window.open() 调用返回 undefined，它不是有效值，不会显示在浏览器窗口中。

提示：请记住，没有返回值的函数真正返回的都是 undefined。

### ECMAScript 等性运算符

在比较时，该运算符还遵守下列规则：

- 值 null 和 undefined 相等。
- 在检查相等性时，不能把 null 和 undefined 转换成其他值。
- 如果某个运算数是 NaN，等号将返回 false，非等号将返回 true。
- 如果两个运算数都是对象，那么比较的是它们的引用值。如果两个运算数指向同一对象，那么等号返回 true，否则两个运算数不等。

全等号由三个等号表示（===），只有在无需类型转换运算数就相等的情况下，才返回 true。

例如：

```javascript
var sNum = "66";
var iNum = 66;
alert(sNum == iNum);	//输出 "true"
alert(sNum === iNum);	//输出 "false"
```

#### 等号和非等号

在 ECMAScript 中，等号由双等号（==）表示，当且仅当两个运算数相等时，它返回 true。非等号由感叹号加等号（!=）表示，当且仅当两个运算数不相等时，它返回 true。为确定两个运算数是否相等，这两个运算符都会进行类型转换。

执行类型转换的规则如下：

- 如果一个运算数是 Boolean 值，在检查相等性之前，把它转换成数字值。false 转换成 0，true 为 1。
- 如果一个运算数是字符串，另一个是数字，在检查相等性之前，要尝试把字符串转换成数字。
- 如果一个运算数是对象，另一个是字符串，在检查相等性之前，要尝试把对象转换成字符串。
- 如果一个运算数是对象，另一个是数字，在检查相等性之前，要尝试把对象转换成数字。

在比较时，该运算符还遵守下列规则：

- 值 null 和 undefined 相等。
- 在检查相等性时，不能把 null 和 undefined 转换成其他值。
- 如果某个运算数是 NaN，等号将返回 false，非等号将返回 true。
- 如果两个运算数都是对象，那么比较的是它们的引用值。如果两个运算数指向同一对象，那么等号返回 true，否则两个运算数不等。

重要提示：即使两个数都是 NaN，等号仍然返回 false，因为根据规则，NaN 不等于 NaN。

等号和非等号的同类运算符是全等号和非全等号。这两个运算符所做的与等号和非等号相同，只是它们在检查相等性前，不执行类型转换。

### ECMAScript 赋值运算符

主要的算术运算以及其他几个运算都有复合赋值运算符：

- 乘法/赋值（*=）
- 除法/赋值（/=）
- 取模/赋值（%=）
- 加法/赋值（+=）
- 减法/赋值（-=）
- 左移/赋值（<<=）
- 有符号右移/赋值（>>=）
- 无符号右移/赋值（>>>=）

ECMAScript 迭代语句

for-in 语句

for 语句是严格的迭代语句，用于枚举对象的属性。

它的语法如下：

```javascript
for (property in expression) statement
```

例子：

```javascript
for (sProp in window) {
  alert(sProp);
}
```

这里，for-in 语句用于显示 window 对象的所有属性。

前面讨论过的 PropertyIsEnumerable() 是 ECMAScript 中专门用于说明属性是否可以用 for-in 语句访问的方法。

### ECMAScript switch 语句

ECMAScript 和 Java 中的 switch 语句有两点不同。在 ECMAScript 中，switch 语句可以用于字符串，而且能用不是常量的值说明情况：

```javascript
var BLUE = "blue", RED = "red", GREEN  = "green";

switch (sColor) {
  case BLUE: alert("Blue");
    break;
  case RED: alert("Red");
    break;
  case GREEN: alert("Green");
    break;
  default: alert("Other");
}
```

这里，switch 语句用于字符串 sColor，声明 case 使用的是变量 BLUE、RED 和 GREEN，这在 ECMAScript 中是完全有效的。

### ECMAScript 函数概述

#### arguments 对象

在函数代码中，使用特殊对象 arguments，开发者*无需明确指出参数名*，就能访问它们。

例如，在函数 sayHi() 中，第一个参数是 message。用 arguments[0] 也可以访问这个值，即第一个参数的值（第一个参数位于位置 0，第二个参数位于位置 1，依此类推）。

因此，无需明确命名参数，就可以重写函数：

```javascript
function sayHi() {
  if (arguments[0] == "bye") {
    return;
  }

  alert(arguments[0]);
}
```

#### 检测参数个数

还可以用 arguments 对象检测函数的参数个数，引用属性 arguments.length 即可。

下面的代码将输出每次调用函数使用的参数个数：

```javascript
function howManyArgs() {
  alert(arguments.length);
}

howManyArgs("string", 45);
howManyArgs();
howManyArgs(12);
```

上面这段代码将依次显示 "2"、"0" 和 "1"。

注释：与其他程序设计语言不同，ECMAScript 不会验证传递给函数的参数个数是否等于函数定义的参数个数。开发者定义的函数都可以接受任意个数的参数（根据 Netscape 的文档，最多可接受 255 个），而不会引发任何错误。任何遗漏的参数都会以 undefined 传递给函数，多余的函数将忽略。

#### 模拟函数重载

用 arguments 对象判断传递给函数的参数个数，即可模拟函数重载：

```javascript
function doAdd() {
  if(arguments.length == 1) {
    alert(arguments[0] + 5);
  } else if(arguments.length == 2) {
    alert(arguments[0] + arguments[1]);
  }
}

doAdd(10);	//输出 "15"
doAdd(40, 20);	//输出 "60"
```

当只有一个参数时，doAdd() 函数给参数加 5。如果有两个参数，则会把两个参数相加，返回它们的和。所以，doAdd(10) 输出的是 "15"，而 doAdd(40, 20) 输出的是 "60"。

### Function 对象（类）

Function 对象也有与所有对象共享的 valueOf() 方法和 toString() 方法。这两个方法返回的都是函数的源代码，在调试时尤其有用。

### Javascript闭包

函数内部声明变量的时候，一定要使用var命令。如果不用的话，你实际上声明了一个全局变量！

```javascript
function f1(){
    n=999;
}

f1();
alert(n); // 999
```

闭包可以用在许多地方。它的最大用处有两个，一个是前面提到的可以读取函数内部的变量，另一个就是让这些变量的值始终保持在内存中。

### ECMAScript 对象应用

除对象的所有引用时要当心。如果一个对象有两个或更多引用，则要正确废除该对象，必须将其所有引用都设置为 null。

### ECMAScript 对象作用域

ECMAScript 中只存在一种作用域 - 公用作用域。ECMAScript 中的所有对象的所有属性和方法都是公用的。

由于缺少私有作用域，开发者确定了一个规约，说明哪些属性和方法应该被看做私有的。这种规约规定在属性前后加下划线：

```javascript
obj._color_ = "blue";
```

这段代码中，属性 color 是私有的。注意，下划线并不改变属性是公用属性的事实，它只是告诉其他开发者，应该把该属性看作私有的。

有些开发者还喜欢用单下划线说明私有成员，例如：obj._color。

ECMAScript 并没有静态作用域。不过，它可以给构造函数提供属性和方法。还记得吗，构造函数只是函数。函数是对象，对象可以有属性和方法。

关键字 this 总是指向调用该方法的对象，例如：

```javascript
var oCar = new Object;
oCar.color = "red";
oCar.showColor = function() {
  alert(this.color);
};

oCar.showColor();		//输出 "red"
```

引用对象的属性时，必须使用 this 关键字。例如，如果采用下面的代码，showColor() 方法不能运行：

```javascript
function showColor() {
  alert(color);
};
```

如果不用对象或 this 关键字引用变量，ECMAScript 就会把它看作局部变量或全局变量。

### ECMAScript 定义类或对象

ECMAScript 拥有很多创建对象或类的方法。

#### 工厂方式

##### 原始的方式

因为对象的属性可以在对象创建后动态定义，所有许多开发者都在 JavaScript 最初引入时编写类似下面的代码：

```javascript
var oCar = new Object;
oCar.color = "blue";
oCar.doors = 4;
oCar.mpg = 25;
oCar.showColor = function() {
  alert(this.color);
};
```

在上面的代码中，创建对象 car。然后给它设置几个属性：它的颜色是蓝色，有四个门，每加仑油可以跑 25 英里。最后一个属性实际上是指向函数的指针，意味着该属性是个方法。执行这段代码后，就可以使用对象 car。

不过这里有一个问题，就是可能需要创建多个 car 的实例。

##### 解决方案 - 工厂方式

要解决该问题，开发者创造了能创建并返回特定类型的对象的工厂函数（factory function）。

例如，函数 createCar() 可用于封装前面列出的创建 car 对象的操作：

```javascript
function createCar() {
  var oTempCar = new Object;
  oTempCar.color = "blue";
  oTempCar.doors = 4;
  oTempCar.mpg = 25;
  oTempCar.showColor = function() {
    alert(this.color);
  };
  return oTempCar;
}

var oCar1 = createCar();
var oCar2 = createCar();
```

在这里，第一个例子中的所有代码都包含在 createCar() 函数中。此外，还有一行额外的代码，返回 car 对象（oTempCar）作为函数值。调用此函数，将创建新对象，并赋予它所有必要的属性，复制出一个我们在前面说明过的 car 对象。因此，通过这种方法，我们可以很容易地创建 car 对象的两个版本（oCar1 和 oCar2），它们的属性完全一样。

##### 为函数传递参数

我们还可以修改 createCar() 函数，给它传递各个属性的默认值，而不是简单地赋予属性默认值：

```javascript
function createCar(sColor,iDoors,iMpg) {
  var oTempCar = new Object;
  oTempCar.color = sColor;
  oTempCar.doors = iDoors;
  oTempCar.mpg = iMpg;
  oTempCar.showColor = function() {
    alert(this.color);
  };
  return oTempCar;
}

var oCar1 = createCar("red",4,23);
var oCar2 = createCar("blue",3,25);

oCar1.showColor();		//输出 "red"
oCar2.showColor();		//输出 "blue"
```

给 createCar() 函数加上参数，即可为要创建的 car 对象的 color、doors 和 mpg 属性赋值。这使两个对象具有相同的属性，却有不同的属性值。

##### 在工厂函数外定义对象的方法

虽然 ECMAScript 越来越正式化，但创建对象的方法却被置之不理，且其规范化至今还遭人反对。一部分是语义上的原因（它看起来不像使用带有构造函数 new 运算符那么正规），一部分是功能上的原因。功能原因在于用这种方式必须创建对象的方法。前面的例子中，每次调用函数 createCar()，都要创建新函数 showColor()，意味着每个对象都有自己的 showColor() 版本。而事实上，每个对象都共享同一个函数。

有些开发者在工厂函数外定义对象的方法，然后通过属性指向该方法，从而避免这个问题：

```javascript
function showColor() {
  alert(this.color);
}

function createCar(sColor,iDoors,iMpg) {
  var oTempCar = new Object;
  oTempCar.color = sColor;
  oTempCar.doors = iDoors;
  oTempCar.mpg = iMpg;
  oTempCar.showColor = showColor;
  return oTempCar;
}

var oCar1 = createCar("red",4,23);
var oCar2 = createCar("blue",3,25);

oCar1.showColor();		//输出 "red"
oCar2.showColor();		//输出 "blue"
```

在上面这段重写的代码中，在函数 createCar() 之前定义了函数 showColor()。在 createCar() 内部，赋予对象一个指向已经存在的 showColor() 函数的指针。从功能上讲，这样解决了重复创建函数对象的问题；但是从语义上讲，该函数不太像是对象的方法。

所有这些问题都引发了*开发者定义*的构造函数的出现。

#### 构造函数方式

创建构造函数就像创建工厂函数一样容易。第一步选择类名，即构造函数的名字。根据惯例，这个名字的首字母大写，以使它与首字母通常是小写的变量名分开。除了这点不同，构造函数看起来很像工厂函数。请考虑下面的例子：

```javascript
function Car(sColor,iDoors,iMpg) {
  this.color = sColor;
  this.doors = iDoors;
  this.mpg = iMpg;
  this.showColor = function() {
    alert(this.color);
  };
}

var oCar1 = new Car("red",4,23);
var oCar2 = new Car("blue",3,25);
```

下面为您解释上面的代码与工厂方式的差别。首先在构造函数内没有创建对象，而是使用 this 关键字。使用 new 运算符构造函数时，在执行第一行代码前先创建一个对象，只有用 this 才能访问该对象。然后可以直接赋予 this 属性，默认情况下是构造函数的返回值（不必明确使用 return 运算符）。

现在，用 new 运算符和类名 Car 创建对象，就更像 ECMAScript 中一般对象的创建方式了。

你也许会问，这种方式在管理函数方面是否存在于前一种方式相同的问题呢？是的。

就像工厂函数，构造函数会重复生成函数，为每个对象都创建独立的函数版本。不过，与工厂函数相似，也可以用外部函数重写构造函数，同样地，这么做语义上无任何意义。这正是下面要讲的原型方式的优势所在。

#### 原型方式

该方式利用了对象的 prototype 属性，可以把它看成创建新对象所依赖的原型。

这里，首先用空构造函数来设置类名。然后所有的属性和方法都被直接赋予 prototype 属性。我们重写了前面的例子，代码如下：

```javascript
function Car() {
}

Car.prototype.color = "blue";
Car.prototype.doors = 4;
Car.prototype.mpg = 25;
Car.prototype.showColor = function() {
  alert(this.color);
};

var oCar1 = new Car();
var oCar2 = new Car();
```

在这段代码中，首先定义构造函数（Car），其中无任何代码。接下来的几行代码，通过给 Car 的 prototype 属性添加属性去定义 Car 对象的属性。调用 new Car() 时，原型的所有属性都被立即赋予要创建的对象，意味着所有 Car 实例存放的都是指向 showColor() 函数的指针。从语义上讲，所有属性看起来都属于一个对象，因此解决了前面两种方式存在的问题。

此外，使用这种方式，还能用 instanceof 运算符检查给定变量指向的对象的类型。因此，下面的代码将输出 TRUE：

```javascript
alert(oCar1 instanceof Car);	//输出 "true"
```

##### 原型方式的问题

原型方式看起来是个不错的解决方案。遗憾的是，它并不尽如人意。

首先，这个构造函数没有参数。使用原型方式，不能通过给构造函数传递参数来初始化属性的值，因为 Car1 和 Car2 的 color 属性都等于 "blue"，doors 属性都等于 4，mpg 属性都等于 25。这意味着必须在对象创建后才能改变属性的默认值，这点很令人讨厌，但还没完。真正的问题出现在属性指向的是对象，而不是函数时。函数共享不会造成问题，但对象却很少被多个实例共享。请思考下面的例子：

```javascript
function Car() {
}

Car.prototype.color = "blue";
Car.prototype.doors = 4;
Car.prototype.mpg = 25;
Car.prototype.drivers = new Array("Mike","John");
Car.prototype.showColor = function() {
  alert(this.color);
};

var oCar1 = new Car();
var oCar2 = new Car();

oCar1.drivers.push("Bill");

alert(oCar1.drivers);	//输出 "Mike,John,Bill"
alert(oCar2.drivers);	//输出 "Mike,John,Bill"
```

上面的代码中，属性 drivers 是指向 Array 对象的指针，该数组中包含两个名字 "Mike" 和 "John"。由于 drivers 是引用值，Car 的两个实例都指向同一个数组。这意味着给 oCar1.drivers 添加值 "Bill"，在 oCar2.drivers 中也能看到。输出这两个指针中的任何一个，结果都是显示字符串 "Mike,John,Bill"。

由于创建对象时有这么多问题，你一定会想，是否有种合理的创建对象的方法呢？答案是有，需要联合使用构造函数和原型方式。

#### 混合的构造函数/原型方式

联合使用构造函数和原型方式，就可像用其他程序设计语言一样创建对象。这种概念非常简单，即用构造函数定义对象的所有非函数属性，用原型方式定义对象的函数属性（方法）。结果是，所有函数都只创建一次，而每个对象都具有自己的对象属性实例。

我们重写了前面的例子，代码如下：

```javascript
function Car(sColor,iDoors,iMpg) {
  this.color = sColor;
  this.doors = iDoors;
  this.mpg = iMpg;
  this.drivers = new Array("Mike","John");
}

Car.prototype.showColor = function() {
  alert(this.color);
};

var oCar1 = new Car("red",4,23);
var oCar2 = new Car("blue",3,25);

oCar1.drivers.push("Bill");

alert(oCar1.drivers);	//输出 "Mike,John,Bill"
alert(oCar2.drivers);	//输出 "Mike,John"
```

现在就更像创建一般对象了。所有的非函数属性都在构造函数中创建，意味着又能够用构造函数的参数赋予属性默认值了。因为只创建 showColor() 函数的一个实例，所以没有内存浪费。此外，给 oCar1 的 drivers 数组添加 "Bill" 值，不会影响到 oCar2 的数组，所以输出这些数组的值时，oCar1.drivers 显示的是 "Mike,John,Bill"，而 oCar2.drivers 显示的是 "Mike,John"。因为使用了原型方式，所以仍然能利用 instanceof 运算符来判断对象的类型。

这种方式是 ECMAScript 采用的主要方式，它具有其他方式的特性，却没有他们的副作用。不过，有些开发者仍觉得这种方法不够完美。

#### 动态原型方法

对于习惯使用其他语言的开发者来说，使用混合的构造函数/原型方式感觉不那么和谐。毕竟，定义类时，大多数面向对象语言都对属性和方法进行了视觉上的封装。请考虑下面的 Java 类：

```javascript
class Car {
  public String color = "blue";
  public int doors = 4;
  public int mpg = 25;

  public Car(String color, int doors, int mpg) {
    this.color = color;
    this.doors = doors;
    this.mpg = mpg;
  }
  
  public void showColor() {
    System.out.println(color);
  }
}
```

Java 很好地打包了 Car 类的所有属性和方法，因此看见这段代码就知道它要实现什么功能，它定义了一个对象的信息。批评混合的构造函数/原型方式的人认为，在构造函数内部找属性，在其外部找方法的做法不合逻辑。因此，他们设计了动态原型方法，以提供更友好的编码风格。

动态原型方法的基本想法与混合的构造函数/原型方式相同，即在构造函数内定义非函数属性，而函数属性则利用原型属性定义。唯一的区别是赋予对象方法的位置。下面是用动态原型方法重写的 Car 类：

```javascript
function Car(sColor,iDoors,iMpg) {
  this.color = sColor;
  this.doors = iDoors;
  this.mpg = iMpg;
  this.drivers = new Array("Mike","John");
  
  if (typeof Car._initialized == "undefined") {
    Car.prototype.showColor = function() {
      alert(this.color);
    };
	
    Car._initialized = true;
  }
}
```

直到检查 typeof Car._initialized 是否等于 "undefined" 之前，这个构造函数都未发生变化。这行代码是动态原型方法中最重要的部分。如果这个值未定义，构造函数将用原型方式继续定义对象的方法，然后把 Car._initialized 设置为 true。如果这个值定义了（它的值为 true 时，typeof 的值为 Boolean），那么就不再创建该方法。简而言之，该方法使用标志（_initialized）来判断是否已给原型赋予了任何方法。该方法只创建并赋值一次，传统的 OOP 开发者会高兴地发现，这段代码看起来更像其他语言中的类定义了。

#### 混合工厂方式

这种方式通常是在不能应用前一种方式时的变通方法。它的目的是创建假构造函数，只返回另一种对象的新实例。

这段代码看起来与工厂函数非常相似：

```javascript
function Car() {
  var oTempCar = new Object;
  oTempCar.color = "blue";
  oTempCar.doors = 4;
  oTempCar.mpg = 25;
  oTempCar.showColor = function() {
    alert(this.color);
  };

  return oTempCar;
}
```

与经典方式不同，这种方式使用 new 运算符，使它看起来像真正的构造函数：

```javascript
var car = new Car();
```

由于在 Car() 构造函数内部调用了 new 运算符，所以将忽略第二个 new 运算符（位于构造函数之外），在构造函数内部创建的对象被传递回变量 car。

这种方式在对象方法的内部管理方面与经典方式有着相同的问题。强烈建议：除非万不得已，还是避免使用这种方式。

#### 采用哪种方式

如前所述，目前使用最广泛的是混合的构造函数/原型方式。此外，动态原始方法也很流行，在功能上与构造函数/原型方式等价。可以采用这两种方式中的任何一种。不过不要单独使用经典的构造函数或原型方式，因为这样会给代码引入问题。

### JavaScript定义类

```javascript
// Define Class: 工厂方法

function createStudent(name, sex, age) {

    var student = new Object;

    student.name = name;
    student.sex = sex;
    student.age = age;

    student.print = function() {
        console.log("name: " + name + ", sex: " + sex + ", age: " + age);
    }

    return student;
}

var student = createStudent('hecai', 'F', 9)
student.print()

// Define Class: 构造函数

function Student(name, sex, age) {

    this.name = name;
    this.sex = sex;
    this.age = age;

    this.print = function() {
        console.log("name: " + name + ", sex: " + sex + ", age: " + age);
    }
}

var zhaoyun = new Student('zhaoyun', 'M', 37);
zhaoyun.print();

// Define Class: 原型方式

function Car(model, color) {
    this.model = model;
    this.color = color;
}

Car.prototype.year = 2015;
Car.prototype.name = "KIA KX3";
Car.prototype.print = function() {
    console.log(this.color + ' ' + this.name);
}

var car = new Car('KX3', 'red');
car.print();

// Define Class: 混合的构造函数/原型方式

function Car(sColor,iDoors,iMpg) {
    this.color = sColor;
    this.doors = iDoors;
    this.mpg = iMpg;
    this.drivers = new Array("Mike","John");
}

Car.prototype.showColor = function() {
    console.log(this.color);
};

var oCar1 = new Car("red",4,23);
var oCar2 = new Car("blue",3,25);

oCar1.drivers.push("Bill");

console.log(oCar1.drivers);    //输出 "Mike,John,Bill"
console.log(oCar2.drivers);    //输出 "Mike,John"

// Define Class: 动态原型方法

function Car(sColor,iDoors,iMpg) {

    this.color = sColor;
    this.doors = iDoors;
    this.mpg = iMpg;
    this.drivers = new Array("Mike","John");

    if (typeof Car._initialized == "undefined") {

        Car.prototype.showColor = function() {
            alert(this.color);
        };

        Car._initialized = true;
    }
}
```

### JavaScript prototype

将函数用作构造函数调用（使用new操作符调用）的时候，新创建的对象会从原型对象上继承属性和方法。

### ECMAScript 继承机制实现

#### 继承机制的实现

要用 ECMAScript 实现继承机制，您可以从要继承的基类入手。所有开发者定义的类都可作为基类。出于安全原因，本地类和宿主类不能作为基类，这样可以防止公用访问编译过的浏览器级的代码，因为这些代码可以被用于恶意攻击。

选定基类后，就可以创建它的子类了。是否使用基类完全由你决定。有时，你可能想创建一个不能直接使用的基类，它只是用于给子类提供通用的函数。在这种情况下，基类被看作抽象类。

尽管 ECMAScript 并没有像其他语言那样严格地定义抽象类，但有时它的确会创建一些不允许使用的类。通常，我们称这种类为抽象类。

创建的子类将继承超类的所有属性和方法，包括构造函数及方法的实现。记住，所有属性和方法都是公用的，因此子类可直接访问这些方法。子类还可添加超类中没有的新属性和方法，也可以覆盖超类的属性和方法。

#### 继承的方式

和其他功能一样，ECMAScript 实现继承的方式不止一种。这是因为 JavaScript 中的继承机制并不是明确规定的，而是通过模仿实现的。这意味着所有的继承细节并非完全由解释程序处理。作为开发者，你有权决定最适用的继承方式。

下面为您介绍几种具体的继承方式。

#### 对象冒充

构想原始的 ECMAScript 时，根本没打算设计对象冒充（object masquerading）。它是在开发者开始理解函数的工作方式，尤其是如何在函数环境中使用 this 关键字后才发展出来。

其原理如下：构造函数使用 this 关键字给所有属性和方法赋值（即采用类声明的构造函数方式）。因为构造函数只是一个函数，所以可使 ClassA 构造函数成为 ClassB 的方法，然后调用它。ClassB 就会收到 ClassA 的构造函数中定义的属性和方法。例如，用下面的方式定义 ClassA 和 ClassB：

```javascript
function ClassA(sColor) {
    this.color = sColor;
    this.sayColor = function () {
        alert(this.color);
    };
}

function ClassB(sColor) {
}
```

还记得吗？关键字 this 引用的是构造函数当前创建的对象。不过在这个方法中，this 指向的所属的对象。这个原理是把 ClassA 作为常规函数来建立继承机制，而不是作为构造函数。如下使用构造函数 ClassB 可以实现继承机制：

```javascript
function ClassB(sColor) {
    this.newMethod = ClassA;
    this.newMethod(sColor);
    delete this.newMethod;
}
```

在这段代码中，为 ClassA 赋予了方法 newMethod（请记住，函数名只是指向它的指针）。然后调用该方法，传递给它的是 ClassB 构造函数的参数 sColor。最后一行代码删除了对 ClassA 的引用，这样以后就不能再调用它。

所有新属性和新方法都必须在删除了新方法的代码行后定义。否则，可能会覆盖超类的相关属性和方法：

```javascript
function ClassB(sColor, sName) {
    this.newMethod = ClassA;
    this.newMethod(sColor);
    delete this.newMethod;

    this.name = sName;
    this.sayName = function () {
        alert(this.name);
    };
}
```

为证明前面的代码有效，可以运行下面的例子：

```javascript
var objA = new ClassA("blue");
var objB = new ClassB("red", "John");
objA.sayColor();	//输出 "blue"
objB.sayColor();	//输出 "red"
objB.sayName();		//输出 "John"
```

#### 对象冒充可以实现多重继承

有趣的是，对象冒充可以支持多重继承。也就是说，一个类可以继承多个超类。用 UML 表示的多重继承机制如下图所示：

例如，如果存在两个类 ClassX 和 ClassY，ClassZ 想继承这两个类，可以使用下面的代码：

```javascript
function ClassZ() {
    this.newMethod = ClassX;
    this.newMethod();
    delete this.newMethod;

    this.newMethod = ClassY;
    this.newMethod();
    delete this.newMethod;
}
```

这里存在一个弊端，如果存在两个类 ClassX 和 ClassY 具有同名的属性或方法，ClassY 具有高优先级。因为它从后面的类继承。除这点小问题之外，用对象冒充实现多重继承机制轻而易举。

由于这种继承方法的流行，ECMAScript 的第三版为 Function 对象加入了两个方法，即 call() 和 apply()。

#### call() 方法

call() 方法是与经典的对象冒充方法最相似的方法。它的第一个参数用作 this 的对象。其他参数都直接传递给函数自身。例如：

```javascript
function sayColor(sPrefix,sSuffix) {
    alert(sPrefix + this.color + sSuffix);
};

var obj = new Object();
obj.color = "blue";

sayColor.call(obj, "The color is ", "a very nice color indeed.");
```

在这个例子中，函数 sayColor() 在对象外定义，即使它不属于任何对象，也可以引用关键字 this。对象 obj 的 color 属性等于 blue。调用 call() 方法时，第一个参数是 obj，说明应该赋予 sayColor() 函数中的 this 关键字值是 obj。第二个和第三个参数是字符串。它们与 sayColor() 函数中的参数 sPrefix 和 sSuffix 匹配，最后生成的消息 "The color is blue, a very nice color indeed." 将被显示出来。

要与继承机制的对象冒充方法一起使用该方法，只需将前三行的赋值、调用和删除代码替换即可：

```javascript
function ClassB(sColor, sName) {
    //this.newMethod = ClassA;
    //this.newMethod(color);
    //delete this.newMethod;
    ClassA.call(this, sColor);

    this.name = sName;
    this.sayName = function () {
        alert(this.name);
    };
}
```

这里，我们需要让 ClassA 中的关键字 this 等于新创建的 ClassB 对象，因此 this 是第一个参数。第二个参数 sColor 对两个类来说都是唯一的参数。

#### apply() 方法

apply() 方法有两个参数，用作 this 的对象和要传递给函数的参数的数组。例如：

```javascript
function sayColor(sPrefix,sSuffix) {
    alert(sPrefix + this.color + sSuffix);
};

var obj = new Object();
obj.color = "blue";

sayColor.apply(obj, new Array("The color is ", "a very nice color indeed."));
```

这个例子与前面的例子相同，只是现在调用的是 apply() 方法。调用 apply() 方法时，第一个参数仍是 obj，说明应该赋予 sayColor() 函数中的 this 关键字值是 obj。第二个参数是由两个字符串构成的数组，与 sayColor() 函数中的参数 sPrefix 和 sSuffix 匹配，最后生成的消息仍是 "The color is blue, a very nice color indeed."，将被显示出来。

该方法也用于替换前三行的赋值、调用和删除新方法的代码：

```javascript
function ClassB(sColor, sName) {
    //this.newMethod = ClassA;
    //this.newMethod(color);
    //delete this.newMethod;
    ClassA.apply(this, new Array(sColor));

    this.name = sName;
    this.sayName = function () {
        alert(this.name);
    };
}
```

同样的，第一个参数仍是 this，第二个参数是只有一个值 color 的数组。可以把 ClassB 的整个 arguments 对象作为第二个参数传递给 apply() 方法：

```javascript
function ClassB(sColor, sName) {
    //this.newMethod = ClassA;
    //this.newMethod(color);
    //delete this.newMethod;
    ClassA.apply(this, arguments);

    this.name = sName;
    this.sayName = function () {
        alert(this.name);
    };
}
```

当然，只有超类中的参数顺序与子类中的参数顺序完全一致时才可以传递参数对象。如果不是，就必须创建一个单独的数组，按照正确的顺序放置参数。此外，还可使用 call() 方法。

#### 原型链（prototype chaining）

继承这种形式在 ECMAScript 中原本是用于原型链的。上一章介绍了定义类的原型方式。原型链扩展了这种方式，以一种有趣的方式实现继承机制。

在上一章学过，prototype 对象是个模板，要实例化的对象都以这个模板为基础。总而言之，prototype 对象的任何属性和方法都被传递给那个类的所有实例。原型链利用这种功能来实现继承机制。

如果用原型方式重定义前面例子中的类，它们将变为下列形式：

```javascript
function ClassA() {
}

ClassA.prototype.color = "blue";
ClassA.prototype.sayColor = function () {
    alert(this.color);
};

function ClassB() {
}

ClassB.prototype = new ClassA();
```

原型方式的神奇之处在于突出显示的蓝色代码行。这里，把 ClassB 的 prototype 属性设置成 ClassA 的实例。这很有意思，因为想要 ClassA 的所有属性和方法，但又不想逐个将它们 ClassB 的 prototype 属性。还有比把 ClassA 的实例赋予 prototype 属性更好的方法吗？

注意：调用 ClassA 的构造函数，没有给它传递参数。这在原型链中是标准做法。要确保构造函数没有任何参数。

与对象冒充相似，子类的所有属性和方法都必须出现在 prototype 属性被赋值后，因为在它之前赋值的所有方法都会被删除。为什么？因为 prototype 属性被替换成了新对象，添加了新方法的原始对象将被销毁。所以，为 ClassB 类添加 name 属性和 sayName() 方法的代码如下：

```javascript
function ClassB() {
}

ClassB.prototype = new ClassA();

ClassB.prototype.name = "";
ClassB.prototype.sayName = function () {
    alert(this.name);
};
```

可通过运行下面的例子测试这段代码：

```javascript
var objA = new ClassA();
var objB = new ClassB();
objA.color = "blue";
objB.color = "red";
objB.name = "John";
objA.sayColor();
objB.sayColor();
objB.sayName();
```

此外，在原型链中，instanceof 运算符的运行方式也很独特。对 ClassB 的所有实例，instanceof 为 ClassA 和 ClassB 都返回 true。例如：

```javascript
var objB = new ClassB();
alert(objB instanceof ClassA);	//输出 "true"
alert(objB instanceof ClassB);	//输出 "true"
```

在 ECMAScript 的弱类型世界中，这是极其有用的工具，不过使用对象冒充时不能使用它。

原型链的弊端是不支持多重继承。记住，原型链会用另一类型的对象重写类的 prototype 属性。

#### 混合方式

这种继承方式使用构造函数定义类，并非使用任何原型。对象冒充的主要问题是必须使用构造函数方式，这不是最好的选择。不过如果使用原型链，就无法使用带参数的构造函数了。开发者如何选择呢？答案很简单，两者都用。

在前一章，我们曾经讲解过创建类的最好方式是用构造函数定义属性，用原型定义方法。这种方式同样适用于继承机制，用对象冒充继承构造函数的属性，用原型链继承 prototype 对象的方法。用这两种方式重写前面的例子，代码如下：

```javascript
function ClassA(sColor) {
    this.color = sColor;
}

ClassA.prototype.sayColor = function () {
    alert(this.color);
};

function ClassB(sColor, sName) {
    ClassA.call(this, sColor);
    this.name = sName;
}

ClassB.prototype = new ClassA();

ClassB.prototype.sayName = function () {
    alert(this.name);
};
```

在此例子中，继承机制由两行突出显示的蓝色代码实现。在第一行突出显示的代码中，在 ClassB 构造函数中，用对象冒充继承 ClassA 类的 sColor 属性。在第二行突出显示的代码中，用原型链继承 ClassA 类的方法。由于这种混合方式使用了原型链，所以 instanceof 运算符仍能正确运行。

下面的例子测试了这段代码：

```javascript
var objA = new ClassA("blue");
var objB = new ClassB("red", "John");
objA.sayColor();	//输出 "blue"
objB.sayColor();	//输出 "red"
objB.sayName();	//输出 "John"
```

### javascript - import / export

这个文章更全面：<http://cnodejs.org/topic/5231a630101e574521e45ef8>

ES6之模前已经出现了js块加载的方案，最主要的是CommonJS和AMD规范。

CommonJS主要应用于服务器，实现同步加载，如nodejs。

AMD规范应用于浏览器，如requirejs，为异步加载。

ES6在语言规格的层面上，实现了模块功能，而且实现得相当简单，完全可以取代现有的CommonJS和AMD规范，成为浏览器和服务器通用的模块解决方案。

ES6模块主要有两个功能：export 和 import

export 用于对外输出本模块（一个文件可以理解为一个模块）变量的接口

import 用于在一个模块中加载另一个含有 export 接口的模块。

也就是说使用 export 命令定义了模块的对外接口以后，其他 js 文件就可以通过 import 命令加载这个模块（文件）。

Sample 1

```javascript
// source: test.js:
//--------------------

var name="xiaoqiu";
var age=22;

export {name,age};

// use in: index.js:
//--------------------

import {name,age} from './test.js’

console.log(name);
```



Sample 2

```javascript
// source: test.js
//--------------------

export function getName() {
     return name;
}

export function getAge() {
    return age;
}

// use in: index.js:
//--------------------

import * as test from './test.js'

console.log("import:” + test.getName() + "…” + test.getAge());  
```



一个js中只能有一个default语句，要么export一个对象（Sampe 3），要么export 一个变量/函数（Sample 4）

Sample 3

```javascript
// source: test.js
//--------------------

export default{
    name:'xiaoqiu',
    getAge:function(){
        return 22;
    }
}

// use in: index.js
//--------------------

import test from './test.js';

console.log(test.getAge());
```

Sample 4

```javascript
// source: test.js
//--------------------

export default function getAge(){
	return 22;
}

// use in: index.js
//--------------------

import getAge from './test.js';

console.log(getAge());  
```

### arguments 对象

在函数代码中，使用特殊对象 arguments，开发者无需明确指出参数名，就能访问它们。

例如，在函数 sayHi() 中，第一个参数是 message。用 arguments[0] 也可以访问这个值，即第一个参数的值（第一个参数位于位置 0，第二个参数位于位置 1，依此类推）。

因此，无需明确命名参数，就可以重写函数：

```javascript
function sayHi() {

    if (arguments[0] == "bye") {
        return;
    }

    alert(arguments[0]);
}
```

### Function 对象的 length 属性

ECMAScript 定义的属性 length 声明了函数期望的参数个数。例如：

```javascript
function doAdd(iNum) {
    alert(iNum + 10);
}

function sayHi() {
    alert("Hi");
}

alert(doAdd.length);    //输出 "1"
alert(sayHi.length);    //输出 "0"
```

函数 doAdd() 定义了一个参数，因此它的 length 是 1；sayHi() 没有定义参数，所以 length 是 0。

记住，无论定义了几个参数，ECMAScript 可以接受任意多个参数（最多 25 个），这一点在《函数概述》这一章中讲解过。属性 length 只是为查看默认情况下预期的参数个数提供了一种简便方式。

### throw...try...catch

```javascript
var x = prompt("请输入 0 至 10 之间的数：", "")

try {
    if (x > 10) throw "Err1"
    if (x < 0) throw "Err2"
    if (isNaN(x)) throw "Err3"
}
catch (er) {
    if (er == "Err1") alert("错误！该值太大！")
    if (er == "Err2") alert("错误！该值太小！")
    if (er == "Err3") alert("错误！该值不是数字！")
}
```

