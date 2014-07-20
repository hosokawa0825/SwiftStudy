//
//  SCHTabBarController.swift
//  pisa_iPad
//
//  Created by hosokawa toru on 2014/07/16.
//  Copyright (c) 2014年 simplex Inc. All rights reserved.
//

//FoundationをimportするとObjcの対応するクラス（例えば、Stringに対するNSString）のメソッドが使えるようになる
import Foundation

func main() {
    
    var hoge = "hoge"
    let const = "const"
    let str = "before" + ":" + "after"
    let dict = ["japan" : "tokyo", "france" : "paris"]
    let array = ["1", "2"]
    
    // as ~でキャストできる。配列の要素の型を指定すると、それを取り出した変数(str)の型が型推論で決まる
    for str in array as [String] {
        println(str)
    }
    let aaa : AnyObject = "aaa"
    let sss = aaa as? Int // as?はキャスト出来なかった場合はnilを返す
    
    // ifの条件式は()で囲ってもいいし囲まなくてもいい
    var name : String = "str"
    if name.isEmpty {
        println(name)
    } else {
        println(name)
    }
    
    let width = 44
    let widthStr = String(width) // String()で型変換できる
    
    var num: Int = 0
    // ObjCのように、0だったらfalseとはできない。num == 0のように比較して真理値にしないといけない
    if num {
        println("0")
    }
    
    let opt:String? = dict["japan"]
    if opt {
        // optは分岐内から参照できないが、!を付けると参照出来る
        let message = "test" + opt!
    }
    if let opt2 = dict["japan"] {
        // 条件文で代入し、代入できたら分岐内に入る。この場合は分岐内でopt2を参照できる。optional bindingという機能
        let message = "test" + opt2
    }
    
    var sum = 0
    for var i = 0; i < 5; i++ {
        sum += i
    }
    
    // 5を含む
    for i in 1...5 {
        sum += i
    }
    
    // 5を含まない
    for i in 1..<5 {
        sum += i
    }
    
    for name in array {
        println(name)
    }
    
    for (country, city) in dict {
        println(country + ":" + city)
    }
    
    var idx = 0
    while idx < 5 {
        idx++
    }
    
    // breakは書かなくてもfall throughしない
    let animal = "cat"
    switch animal {
    case "cat" :
        println("猫")
    case "dog" :
        println("犬")
    case "c", "a" :
        println("a")
    default :
        println("動物")
    }
    
    var point = (10, 5, "name")
    switch point {
    case let (x, y, name) where x > 100 :
        println(x)
    case let (x, y, name) where name.hasSuffix("u"):
        println(name)
    case let (x, y, name):
        // whereを書かないとdefaultと同じ意味になる
        println(y)
    }
    
    enum Sports: Int {
        case Tennis, Soccer
    }
    
    // switchがenumをすべて網羅しているかをコンパイラがチェックしてくれる
    let s = Sports.Tennis
    switch s {
    case Sports.Tennis:
        println("tennis")
        // Enumの型名は省略可能
    case .Soccer:
        println("Soccer")
    }
    
    // 関数宣言
    func calc(price:Float, tax:Float) ->Float {
        return price / tax
    }
    
    // ...で任意の数の引数を渡せる。paramsはArray型になる
    func concat(params: String...) -> String {
        // 可変長引数は他の可変長引数を取る関数に渡せないので、なるべく可変長引数を使わず配列にすべき。
        concat(params)
        
        // 関数をネストできる
        func innerFunc(name: String) -> String {
            return name
        }
        
        var result = ""
        for param in params {
            result += param
        }
        return result
    }
    
    // 高階関数
    func higherFunc(score: Int, condition: Int -> Bool) -> Bool {
        if condition(score) {
            return false
        } else {
            return true
        }
    }
    
    func condition(score:Int) -> Bool {
        return true
    }
    
    higherFunc(90, condition)
    
    // 関数はオブジェクトとして扱える
    func createCondition(average:Int) -> (Int -> Bool) {
        return condition
    }
    
    let cond = createCondition(30)
    cond(45)
    
    // クロージャ。Blocksよりだいぶシンタックスがわかりやすい！
    higherFunc(90, {(x:Int) -> Bool in return x > 99})
    
    // 型推論があるので、クロージャの引数と返値の型を省略出来る！
    higherFunc(90, {x in return x > 99})
    
    // 1行クロージャの場合はreturnも省略可能
    higherFunc(90, {x in x > 99})
    
    // レキシカル変数
    func addMore(x: Int) -> () -> Int {
        var res = 0
        func append() -> Int {
            res += x
            return res
        }
        return append
    }
    
    var more = addMore(5)
    more() // 5
    more() // 10
    
    
    // クラス定義
    class Stone {
        // プロパティ。今のところプロパティにはスコープが無いのですべてPublic。。メソッドも。
        var color: String
        // 定数プロパティ
        let name:String? = nil
        
        // イニシャライザ。初期値の無いプロパティはここで初期化しないとエラーになる
        // 引数のデフォルト値を設定出来る
        // デフォルト値を持つ引数は最後におくべき。でないと呼び出し側で引数を省略する時に困る
        init(name:String, color:String = "white") {
            self.name = name
            self.color = color
            // \()で文字列を埋め込める。数値でも文字列に変換してくれる。
            self.name = "\(color)stone\(11 + 2)"
        }
        
        // インスタンスメソッド
        func whoAmI() -> String {
            return "me"
        }
    }
    
    // インスタンス化
    var stone = Stone(name:"name")
    stone.whoAmI()
    
    // 継承
    class DirectionStone: Stone {
        var direction:Int = 0
        
        init(color: String="silver", direction: Int=0) {
            super.init(name:"name", color:color)
            self.direction = direction
        }
        
        // override
        override func whoAmI() -> String {
            return "overrided"
        }
    }
    
    var dirStone = DirectionStone(direction:1)
    dirStone.whoAmI()
    
    // generics
    func toArray<T>(params:T...) -> [T] {
        var result = [T]()
        for param in params {
            result.append(param)
        }
        return result
    }
    
    toArray<Int>(1,2,3)
    toArray(1,2,3)
    
    // 配列に格納する型を指定出来る
    var strArray = Array<String>()
    
    // バイナリリテラル
    0b101
    
    // 8進数
    0o107
    
    // 16進数
    0x2ff
    
    // 浮動小数点数(-2e2は-2*10^2)
    -2e2
    
    enum Week {
        case Sunday
        case Monday
        
        // enumにメソッドを定義出来る
        var isHoliday: Bool {
            switch self {
            case Sunday:
                return true
            default:
                return false
            }
        }
        
        // mutating修飾子を付けると自分自身を別インスタンスに置き換えられる。プロパティの変更も出来る
        mutating func nextDay() {
            switch self {
            case Sunday: self = Monday
            case Monday: self = Sunday
            }
        }
    }
    
    var day1 = Week.Sunday
    day1.isHoliday // true
    day1.nextDay()
    day1 == Week.Monday // true
    let day2 = Week.Monday
    day2.nextDay() // 定数のEnumは変更出来ない。Enumのプロパティも変更出来ない

    
    enum Shape {
        // Enumの要素はプロパティを持てる。以下のようにプロパティを定義する
        case Rectangle(x: Float, y: Float, width: Float, height: Float)
        case Circle(x: Float, y: Float, radius:Float)
        
        static let pi: Float = 3.14

        var area: Float {
            switch self {
            case let Shape.Rectangle(_, _, width, height):
                return width * height
            case let Shape.Circle(_, _, radius):
                return radius * radius * Shape.pi
            }
        }
    }
    
    // rectの型はShape
    let rect = Shape.Rectangle(x: 0, y: 0, width: 10, height: 12)
    rect.area // 120
    
    // enumのパターンマッチ
    switch rect {
        // xが1の場合、下記caseに入る
    case let .Rectangle(x: 1, y: y, width:width, height:height):
        println("rect")
        // xが1かつyが2の場合、下記caseに入る
    case let .Rectangle(x: 1, y: 2, width:width, height:height):
        println("rect")
        // すべてのパターンを網羅出来ていないので、コンパイルエラーになるはずだけど、ならない。。
        // パターン網羅をチェックしてくれるので、基本的にdefaultは使わないようにすべき。
    }
    
    // Enumの要素にStringやDoubleなどの値(Raw Value)を割り当てることが出来る。
    // この場合、すべての要素に値を割り当て、かつ重複が無いようにしないといけない。
    enum RawWeek : String {
        case Sunday = "sun"
        case Monday = "mon"
    }
    
    // intの場合はすべて指定しなくても自動でIncrementしてくれる
    enum RawIntWeek : Int {
        case Sunday = 1
        case Monday // 2
    }
    
    // raw valueを取り出す
    let rawValue = RawIntWeek.Monday.toRaw()
    // raw valueからenumに変換
    let mon = RawIntWeek.fromRaw(2)
    
    let day = RawIntWeek.Monday
    // RawIntWeek.Mondayはswitch文の中では.Mondayに省略可能
    switch day {
    case .Sunday:
        println("sun")
    case .Monday:
        println("mon")
    }
    
    // swiftのenumは代数的データ型というものらしい。詳しくはよくわからん。。
    
    // パターンマッチ
    // タプルの各要素をそれぞれ別の変数に代入する
    let foobar = ("foo", "bar")
    let (a, b) = foobar
    let kk = foobar.0 // indexでタプルの要素にアクセス可能
    
    // タプルはネスト可能
    let foobarbaz = ("foo", ("bar", "baz"))
    let (c, (d, e)) = foobarbaz
    
    let foobarnamed = (foo:"foo", bar:"bar") // タプルの要素に名前を付けられる
    let kkk = foobarnamed.foo // 名前でアクセス可能
    
    // _はワイルドカードといっていらない値を受けるときに使える。関数の仮引数でも使える
    let (foo, _) = foobar
    
    func createStr(strTuple: (String, String)) -> String {
        var str: String
        // タプルもパターンマッチ出来る。パターンに一致した場合、caseの中に入る
        switch strTuple {
        case ("boo", "bar"):
            str = "boo bar"
            // ワイルドカードにすると、どんな値でもマッチする。
        case (_, "bar"):
            str = "boo bar"
            // パターンを変数にすると、caseの中で受け取った値を使える。letかvarを指定する必要あり
        case (let str1, var str2):
            str = str1 + str2
        default:
            str = "any"
        }
        return str
    }
    
    let fooBar = ("foo", "bar")
    createStr(fooBar)
    
    let time = 45
    switch time {
    case 0:
        println("test")
        // パターンとしてRangeを指定可能
    case 1...60:
        println("test")
        // 条件式を書くことも出来る
    case let x where x > 60:
        println("test")
    }
    
    let vals = (30, 40)
    switch vals {
        // タプルの場合の書き方
    case let (a, b) where a + b > 10:
        println("test")
    }
    
    class Foo {
        let id = "Foo"
    }
    class Bar {
        let id = "Bar"
    }
    let fb = [Foo(), Bar()]

    // ObjcでのidはAnyObject型
    for elem: AnyObject in fb {
        switch elem {
            // 型でマッチさせる。caseの中で値を使いたい場合はlet asを使う
        case let foo as Foo:
            println(foo.id)
            // elemの値を使わなくていい場合はis。isは型の比較
        case is Bar:
            println("bar")
        }
    }
    
    let list = [1,2,3]
    list == [1,2,3] // trueになる。Arrayの場合、==はアドレスの比較ではない？
    // switchにはenumだけでなく任意のオブジェクトを渡せる。
    switch list {
        // list == [1,2]の結果、trueならcaseの中に入る
    case [1,2]:
        println("test")
    case [1,2,3]:
        println("test")
    }
    
    switch [1,3,2] {
    case [1,2]:
        println("test")
        // 通常は[1,3,2]と[1,2,3]はマッチしないが、~=演算子をオーバーロードしているので、ソートしてから==でマッチさせているのでマッチする
    case [1,2,3]:
        println("test")
    }
    
    // カリー化
    // 関数を返値にする。任意の引数を固定するということはできないので不便。。
    func curriedAdd(a: Int) (b: Int) -> Int {
        return a + b
    }
    let add4 = curriedAdd(4)
    add4(b: 3) // 7
    
    // 構造体。以下の性質を持つ。
    // 代入は値渡しになる。メソッド、Subscript(array[0]の[]とか)、イニシャライザを定義出来る。エクステンション(Objcのカテゴリと同じ)が使える。プロトコルを継承できる。
    // 継承ができない。型キャスト出来ない。
    // 恐らくDomain Driven DesignでいうValue Objectはstructにした方がよい。Entityはclassにする。
    
    struct SomeStructure {
        let name: String
        var count: Int
        init(name: String) {
            self.name = name
        }
        // 代入が値渡しになるプロパティ(値型のプロパティ。Stringとか)を変更するメソッドにはmutatingを付ける
        mutating func increment() {
            count++
            // 自分自身を別インスタンスに置き換えられる。
            // TODO:その場合、他の箇所からの参照はどうなる？旧オブジェクトを指したまま？
            self = SomeStructure(name: "name")
            // nameは定数なので再代入できない
            name = "test"
        }
    }
    
    let ss = SomeStructure(name: "name")
    // ssは定数なので、自分自身を書き換えるメソッドの呼び出しはエラーになる
    ss.increment()
    // プロパティ自体は変数でも、構造体が定数の場合は変更出来ない。クラスの場合は変更可能なので注意！
    ss.count = 1
    
    class Hoge {
        let name: String
        var origin: String {
        // getter, setterを実装出来る
        get {
            return name
        }
        // setを定義しないと読み取り専用になる
        set {
            // TODO:これほんとに大丈夫？
            // setする値はnewValueという変数に自動的に渡される
            origin = newValue
        }
        // willSetとdidSetはinitメソッドの中で値をプロパティに代入しても呼ばれない
        willSet {
            if (origin == "test") {
                origin = newValue
            }
        }
        didSet {
            if (origin == "test") {
                // 変更前の値がoldValueに入っている
                origin = oldValue
            }
        }
        }
        init(name: String) {
            self.name = name
        }
        deinit {
            // deinitはdeallocと同じ
        }
    }
    
    // optional。？を付けてない変数にnilを代入できない
    var optional: String? = "orange"
    // coffee scriptっぽく、nilでない場合だけメソッドを実行する
    var intVal = optional?.toInt()
    // String?は実はOptional<String>のシンタックスシュガー。よって変数の型はOptional型になる。Optionalはラッパークラス
    var optional2: Optional<String> = "orange"
    // optionalはString型ではないので、toIntを直接呼ぶことは出来ない
    optional.toInt()
    // Optional型からラップしているインスタンスを取り出すには、!を付ける
    optional!.toInt()
    
    // 型の後ろに!を付けると代入時に自動的にアンラップされる
    var unwarppedOptional : String! = optional
    unwarppedOptional.toInt()
    // TODO:trueになる？
    if optional is String {
        
    }
    
    class WeakHoge {
        // weak参照
        weak var delegate : Hoge?
        // unowned。Objcのassignと同等。インスタンスが解放された後でアクセスすると実行時エラーになる。
        unowned let hoge : Hoge
        init(delegate:Hoge) {
            self.delegate = delegate;
        }
        var name: String
        // TODO:selfにアクセス出来ない？
        // キャプチャリストを使うと、weakifyと同等のことが出来る。
        // @lazyを付けると、参照されるまでsetterが実行されない。@lazyを付けたプロパティは以下の制約を受ける
        // ・変数でないといけない。　・willSetとdidSetが使えない
        @lazy var message : (String) -> String = {
            [unowned self] (value :String) -> String in
            return self.name + value
        }
    }
    
    
    class Hogee {
        let fuga: Fugaa
        init(fuga: Fugaa) {
            self.fuga = Fugaa(hoge: self)
        }
        
    }
    
    class Fugaa {
        unowned let hoge: Hogee
        init(hoge: Hogee) {
            self.hoge = hoge
        }
    }
    
    // ObjCのように、呼び出し側にラベルを付けさせることができる
    func function(externalName localName: Int) {
    }
    
    // 引数の説明と仮引数名が同じ場合、#を付けると二回同じ名前を書かなくて良い
    // イニシャライザは引数の説明を付けなくても自動的に仮引数名と同じ説明が付けられる（通常のメソッドで#を付けた時と同じ挙動）
    func function2(#externalName: Int) {
    }
    
    function(externalName: 1)
    
    // 引数にアドレスを渡す場合はinoutを付ける
    func ext(inout a: Int) {
        a = 5
    }
    
    var vala = 1
    // inout引数に変数を渡す場合は&を付ける
    ext(&vala)
    
    class Rect {
        var x : Int
        var y : Int
        var width : Int
        var height : Int
        init() {}
        init(x:Int,y:Int,width:Int,height:Int) {
            self.x = x
            self.y = y
            self.width = width
            self.height = height
        }
        // イニシャライザから他のイニシャライザを呼べる
        convenience init ((x:Int, y:Int), (width:Int, height:Int)) {
            self.init(x: x,y: y,width: width,height: height)
        }
        // getterのみの場合、以下のようにgetを書かなくても良い
        var origin: Int {
            return x * y
        }

        // overrideさせたくない場合はfinalを付ける。プロパティ、メソッドの両方につけられる
        @final func cannotOverride() {
            
        }
    }
    
    // ObjcのnilはswiftではNilType。
    // swiftのStringは値型。代入するとコピーされる。が、文字列が変更されるまでコピーされない
    var str1 :String = "1"
    var str2 :String = str1
    // str1とstr2は同じオブジェクトを指す
    str2 += "a" // 文字列を変更すると、オブジェクトが生成されstr2に代入される
    
    str1 == str2 // ==はアドレス比較でなく、文字列比較になる
    str1 < str2 // 文字コードで比較
    countElements(str1) // 文字数を返す。Objcのlengthと違い文字数をちゃんと数えてくれるらしい
    // Stringのメソッド
    str1.hasPrefix("prefix")
    str1.hasSuffix("suffix")
    str1.uppercaseString
    str1.lowercaseString
    str1.utf8
    str1.toInt() // 恐らくNSStringのintegerValueと同じ
    
    // platformによってIntがInt32だったりInt64だったりするので注意
    Int.min // 最小値
    Int.max // 最大値
    
    // Array, Dictionary, Stringのコピーはオブジェクトの変更が行われるまで遅延される。特殊な挙動なので注意。
    var rankNames : [String] = ["A", "B"]
    
    var rank :String = rankNames[0] //[]でアクセス出来る
    rankNames[0] = "C" // 代入できる
    rankNames[0...1] = ["D", "E"] // 複数の要素を一気に代入
    rankNames.append("F") // 最後に要素を追加
    rankNames += "G" // appendと同じ
    rankNames += ["H", "I"] // 複数の要素を追加
    rankNames.insert("K", atIndex:0)
    rankNames = ["A"] + rankNames + ["F"] // +で配列を結合できる
    
    // sortの長い書き方。クロージャで順序を定義する
    sort(&rankNames, ({(str1:String, str2:String) -> Bool in return str1 < str2}))
    // クロージャの型は型推論があるので省略可能
    sort(&rankNames, ({(str1, str2) in return str1 < str2}))
    // 引数の括弧は省略可能。式が一つだけの場合returnも省略可能
    sort(&rankNames, ({str1, str2 in str1 < str2}))
    // クロージャの引数は省略可能。引数は$0,$1...という名前でアクセス出来る。引数を省略した場合、inも省略可能。
    sort(&rankNames, {$0 < $1})
    // trailing closureといって、最後の引数がクロージャの場合、クロージャを外に出せる
    sort(&rankNames) {$0 < $1}
    // Arrayのsortメソッドを使ってもソートできる
    rankNames.sort({$0 < $1})
    // 演算子「<」は引数を二つ取ってBoolを返す中置関数(swiftではoperator functionsという)なので、これだけでもOK
    rankNames.sort(<)
    
    // filter, map
    let filtered = rankNames.filter({$0 == "A"})
    let mapped =rankNames.map({$0 += "A"})
    
    // 空の配列は[]
    let ary: [String] = []
    // どんな型でも入れられる配列
    let anyArray = [Any]()
    
    // 空の辞書を生成する
    let dictionary = [String: Float]()
    let val = dictionary["key"] // 存在しないKeyの場合はnilを返す。よってvalはoptional
    let keys = Array(dictionary.keys) // keyの配列を作る
    dictionary["key"] = 1 // 新しい値を追加または既存の値の変更
    dictionary["key"] = nil // 値を削除するにはnilを代入する
    
    // enum, struct, classはネスト可能
    class Train {
        enum Status {
            case Error
        }
    }
    let train = Train()
    let status = Train.Status.Error
    
    // 型名の頭にCを付けると、C互換の型になる。CBool以外にもCIntなど一通り用意されている
    var cbool : CBool
    
    var instance1 :AnyObject = "1"
    var instance2 :AnyObject = "1"
    instance1 === instance2 //等価性チェック。falseになる。型がAnyObjectでないと使えないっぽい
    instance1 as String == instance2 as String //等値性チェック。trueになる。型がAnyObjectだと使えないっぽい
    // EnumやStructは値型なので代入はコピーになる。よって異なるオブジェクトになる。
    
    var count1 : Int? = 0
    var count2 : Int? = nil
    count1 == count2 // false。0とnilは区別される
    
    // @auto_closure属性を付けると、関数に引数を渡す時に評価されずクロージャとして渡される
    func doTwice(f: @auto_closure () -> Void) {
        f()
        f()
    }
    
    // 通常はprint("hello")の返値がdoTwiceに渡されるが、@auto_closureを付けているのでprint("hello")関数が渡される
    // これをoperator functionで使うと短絡評価できる
    doTwice(print("hello")) // => hellohello
    
    // objcでinitWith~と定義されているイニシャライザはinitWithを除いて以下のように書く
    var vc = UIViewController(frame:{1,1,1,1})
    // インスタンスを生成するクラスメソッドも同様。colorWith~の場合はcolorWithを除く。
    let color = UIColor(red:1, green:1, blue:1, alpha:1)
    // 型名＋Withで始まらない場合はメソッド名をすべて書く
    var app = UIApplication.sharedApplication()
    // Objcのメソッドを呼び出す場合、以下のように一つ目の引数のみ説明を省略する
    var myTableView : UITableView
    myTableView.insertSubview(subview, atIndex:2)

    // @objcを付けると、NSObjectを継承していないクラスでもObjc側で使えるようになる
    // swiftで定義したメソッドをObjcから使う場合のセレクタを定義できる
    @objc(SomeClass)
    class SomeClass {
        @objc(initWithFrame:)
        init (frame:Rect) {}
    }

    // Int, Float, Double, Bool, UIntはObjcから使う場合NSNumberになる
    // Objcの構造体はSwiftの構造体として初期化できる
    let rect = CGRect(x:1,y:1,width:1,height:1)
}

// ~=演算子をオーバーロードすることで、パターンマッチロジックをカスタマイズできる
func ~=(pattern: [Int], value: [Int]) -> Bool {
    return pattern == value.sorted({x, y in x > y});
}

// プロトコル
protocol SomeProtocol {
    var hoge: Int {get set}
    var fuga: Int {get}
    // クラスメソッド。
    class func piyo()
}

class AClass {
    var hoge: Int
    init(hoge: Int) {
        self.hoge = hoge
    }
    func fuga() {
        
    }
}

func proto() {
    
    // 継承。プロトコルは複数継承可能
    struct AStructure : SomeProtocol {
        var hoge: Int
        var fuga: Int
        // initを実装しなければ自動的に値を代入するだけのイニシャライザが生成される。
        // structのクラスメソッドはstatic funcと書く。classの場合はclass func
        // クラス変数のことをswiftではType Propertiesという。クラスメソッドはType Method。
        static func piyo() {
            
        }
    }
    
    var val : SomeProtocol = AStructure(hoge: 1, fuga: 1)
    // fugaはSomeProtocolではreadonlyなので、書き込みできない
    val.fuga = "test"
    
    var ac = AClass(hoge: 1)
    ac.extFuga()
}

// エクステンション
// カテゴリに似ているが、プロパティを追加できるところ・ストラクチャや列挙型も拡張できるところが違う。
// 指定イニシャライザとdeinitは追加出来ない。
extension AClass {
    var extHoge: Int {get {return extHoge}}
    func extFuga() {
        
    }
}

// IntのようなPrimitiveな型でも拡張できる
extension Int {
    func times(block:(Int) ->()) {
        for i in 0...self {
            block(i)
        }
    }
}

func ext() {
    // rubyっぽく拡張できる
    10.times({i in println(i)})
}

